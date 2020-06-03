//
//  BaseVC+Location.m
//中车运
//
//  Created by 隋林栋 on 2017/7/4.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC+Location.h"
#import <AMapLocationKit/AMapLocationKit.h>


static const char numRepeatKey = '\0';
static const char locationManagerKey = '\0';
static const char aMapsearchKey = '\0';
static const char geocodeCoordinate2DBlockKey = '\0';
static const char reGeocodeAddressBlockKey = '\0';

@interface BaseVC()
@property (nonatomic, assign) int numRepeat;//重复获取地理位置次数
@property (nonatomic, strong) AMapLocationManager *locationManager;//获取地址
@property (nonatomic, strong)AMapSearchAPI *aMapsearch;
@property (nonatomic, strong)void(^geocodeCoordinate2DBlock)(CLLocationCoordinate2D);//编码返回block
@property (nonatomic, strong)void(^reGeocodeAddressBlock)(AMapAddressComponent *);//编码返回block
@end

@implementation BaseVC (Location)

#pragma mark 运行时
- (void)setNumRepeat:(int)numRepeat{
    objc_setAssociatedObject(self, &numRepeatKey, [NSNumber numberWithInt:numRepeat], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)numRepeat{
    NSNumber * num = objc_getAssociatedObject(self, &numRepeatKey);
    if (num && [num isKindOfClass:[NSNumber class]]) {
        return [num intValue];
    }
    return 0;
}
- (void)setLocationManager:(AMapLocationManager *)locationManager{
    objc_setAssociatedObject(self, &locationManagerKey, locationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (AMapLocationManager *)locationManager{
    AMapLocationManager * location  = objc_getAssociatedObject(self, &locationManagerKey);
    if (location && [location isKindOfClass:[AMapLocationManager class]]) {
        return location;
    }
    return nil;
}

-(void)setAMapsearch:(AMapSearchAPI *)aMapsearch{
    objc_setAssociatedObject(self, &aMapsearchKey,aMapsearch, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (AMapSearchAPI *)aMapsearch{
    return objc_getAssociatedObject(self, &aMapsearchKey);
}

-(void)setGeocodeCoordinate2DBlock:(void (^)(CLLocationCoordinate2D))geocodeCoordinate2DBlock{
    objc_setAssociatedObject(self, &geocodeCoordinate2DBlockKey, geocodeCoordinate2DBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)(CLLocationCoordinate2D))geocodeCoordinate2DBlock{
    
    return objc_getAssociatedObject(self, &geocodeCoordinate2DBlockKey);
}

-(void)setReGeocodeAddressBlock:(void (^)(AMapAddressComponent *))reGeocodeAddressBlock{
    
    objc_setAssociatedObject(self, &reGeocodeAddressBlockKey, reGeocodeAddressBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(AMapAddressComponent *))reGeocodeAddressBlock{
    return objc_getAssociatedObject(self, &reGeocodeAddressBlockKey);
}


#pragma mark - 定位
- (void)initLocation
{
    
    if (!self.locationManager) {
        self.locationManager = [[AMapLocationManager alloc]init];
    }
    //带逆地理信息的一次定位（返回坐标和地址信息）
    //kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右，超时时间设置在2s-3s左右即可。
    //高精度：kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右。
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout = 2;
    //逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    //位置更改记录
    self.locationManager.distanceFilter = 5;
    //带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    WEAKSELF
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        STRONGSELF
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        if (!regeocode && self.numRepeat < 3) {
            self.numRepeat ++;
            [self initLocation];
        }else{
            ModelAddress * modelAddress = [ModelAddress initWithAMapLocationReGeocode:regeocode location:location];
            [self fetchLocation:location];
            [self fetchAddress:modelAddress];
        }
    }];
}

#pragma mark sub use
- (void)fetchLocation:(CLLocation *)loc{
    
}
- (void)fetchAddress:(ModelAddress *)clPlace{
    
}

/**
 根据省市区获取经纬度
 
 @param addressStr 省市区
 @param Coordinate2DBlock 经纬度Block
 */
-(void)fetchCoordinate2DFromAddress:(NSString *)addressStr coordinate2D:(void(^)(CLLocationCoordinate2D coordinate2D))Coordinate2DBlock{
    if (Coordinate2DBlock) {
        self.geocodeCoordinate2DBlock = Coordinate2DBlock;
    }
    if (!isStr(addressStr)) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
        if (self.geocodeCoordinate2DBlock) {
            self.geocodeCoordinate2DBlock(coordinate);
        }
        return;
    }
    
    
    AMapGeocodeSearchRequest * AMapGeocodeRequest = [[AMapGeocodeSearchRequest alloc] init];
    AMapGeocodeRequest.address = addressStr;
    if (!self.aMapsearch) {
        
        self.aMapsearch = [[AMapSearchAPI alloc] init];
    }
    self.aMapsearch.delegate =self;
    [self.aMapsearch AMapGeocodeSearch:AMapGeocodeRequest];
    
}




/**
 根据经纬度获取地址信息
 
 @param coordinate2D 经纬度
 @param addressBlock 地址信息回调
 */
-(void)fetchAddressFromCoordinate2D:(CLLocationCoordinate2D )coordinate2D coordinate2D:(void(^)(AMapAddressComponent *))addressBlock{
    
    self.reGeocodeAddressBlock = addressBlock;
    AMapReGeocodeSearchRequest * AMapReGeocodeRequest = [[AMapReGeocodeSearchRequest alloc] init];
    ///中心点坐标。
    AMapReGeocodeRequest.location = [AMapGeoPoint locationWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude];;
    ///查询半径，单位米，范围0~3000，默认1000。
    AMapReGeocodeRequest.radius = 1000;
    if (!self.aMapsearch) {
        
        self.aMapsearch = [[AMapSearchAPI alloc] init];
    }
    self.aMapsearch.delegate =self;
    [self.aMapsearch AMapReGoecodeSearch:AMapReGeocodeRequest];
    
}


- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    
    if (response != nil && isAry(response.geocodes))
    {
        AMapGeocode *aMapGeocode = response.geocodes[0];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(aMapGeocode.location.latitude, aMapGeocode.location.longitude);
        if (self.geocodeCoordinate2DBlock) {
            self.geocodeCoordinate2DBlock(coordinate);
        }
        
    }else{
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
        if (self.geocodeCoordinate2DBlock) {
            self.geocodeCoordinate2DBlock(coordinate);
        }
    }
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    if (response != nil)
    {
        AMapReGeocode *aMapReGeocode = response.regeocode;
        if (self.reGeocodeAddressBlock) {
            self.reGeocodeAddressBlock(aMapReGeocode.addressComponent);
        }
        
    }
    
}
@end
