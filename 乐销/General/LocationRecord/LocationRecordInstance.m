//
//  LocationRecordInstance.m
//  Driver
//
//  Created by 隋林栋 on 2019/6/5.
//Copyright © 2019 ping. All rights reserved.
//

#import "LocationRecordInstance.h"
//logcation
#import <AMapLocationKit/AMapLocationKit.h>
//request
#import "RequestApi+Location.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
#import <MAMapKit/MAGeometry.h>
#import <MapManage/MapManage.h>


@interface LocationRecordInstance ()<AMapLocationManagerDelegate>
@property (nonatomic, strong) MapService *mapTransport;

@end

@implementation LocationRecordInstance

#pragma mark single instance
SYNTHESIZE_SINGLETONE_FOR_CLASS(LocationRecordInstance)

#pragma mark init
- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeSelfModelChange) name:NOTICE_SELFMODEL_CHANGE object:nil];
        //
        //        @"com.wabob.ntocc.driver"
#ifdef UP_TRANSPORT
        self.mapTransport = [[NSClassFromString(@"MapService") alloc]init];
        [self.mapTransport openServiceWithAppId:@"tlanx.midCarrierTransport.dirver" appSecurity:TRANSPORT_AGENCY_APP_SEC enterpriseSenderCode:TRANSPORT_AGENCY_CODE environment:TRANSPORT_AGENCY_ENV listener:^(id  _Nonnull model, NSError * _Nonnull error) {
            NSLog([NSString stringWithFormat:@"%@ %@",model,error]);
        }];
#endif
    }
    return self;
}
#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%s  %@",__func__,self.class);
}
- (void)noticeSelfModelChange{
    [self upLocation:nil];
}
- (void)upLocation:(void (^)(void))successBlock{
    NSMutableArray * ary = [GlobalMethod readAry:LOCAL_LOCATION_RECORD modelName:@"ModelAddress"];
    [self request:ary blockSuccess:successBlock];
}
#pragma mark lazy init

//- (MapService *)mapTransport{
//    if (!_mapTransport) {
//        _mapTransport = [[MapService alloc]init];
//    }
//    return _mapTransport;
//}
- (AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc]init];
        _locationManager.delegate = self;
        //带逆地理信息的一次定位（返回坐标和地址信息）
        //kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右，超时时间设置在2s-3s左右即可。
        //高精度：kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右。
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //位置更改超过5米记录
        _locationManager.distanceFilter = 10;
        _locationManager.locatingWithReGeocode = true;
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
        _locationManager.locationTimeout = 5;
        
    }
    return _locationManager;
}

#pragma mark start record
- (void)startRecord{
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark 交通部
-(void)startLocationWithShippingNoteInfos:(NSArray *)shippingNoteInfos listener:(void(^)(id model, NSError *error))listener{
    NSMutableArray * aryDatas = [NSMutableArray new];
    for (ModelOrderList * modelItem in shippingNoteInfos) {
        if ([modelItem isKindOfClass:[ModelOrderList class]]) {
            [RequestApi requestTransportDeptlWithId:modelItem.startAreaId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                NSString * startCode = [response stringValueForKey:@"code"];
                [RequestApi requestTransportDeptlWithId:modelItem.endAreaId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    NSString * endCode = [response stringValueForKey:@"code"];
                    if (isStr(startCode)&& isStr(endCode)) {
                        [aryDatas addObject:@{@"shippingNoteNumber":UnPackStr(modelItem.waybillNumber),@"serialNumber":@"0000",@"startCountrySubdivisionCode":startCode,@"endCountrySubdivisionCode":endCode}];
                        [self.mapTransport startLocationWithShippingNoteInfos:aryDatas listener:listener];
                        return;
                    }
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }else if ([modelItem isKindOfClass:[ModelBulkCargoOrder class]]){
            ModelBulkCargoOrder * modelBulkItem = (ModelBulkCargoOrder *)modelItem;
            [RequestApi requestTransportDeptlWithId:modelBulkItem.startTownId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                NSString * startCode = [response stringValueForKey:@"code"];
                [RequestApi requestTransportDeptlWithId:modelBulkItem.endTownId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    NSString * endCode = [response stringValueForKey:@"code"];
                    if (isStr(startCode)&& isStr(endCode)) {
                        [aryDatas addObject:@{@"shippingNoteNumber":UnPackStr(modelBulkItem.waybillNumber),@"serialNumber":@"0000",@"startCountrySubdivisionCode":startCode,@"endCountrySubdivisionCode":endCode}];
                        [self.mapTransport startLocationWithShippingNoteInfos:aryDatas listener:listener];
                        return;
                    }
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
    }
}
-(void)stopLocationWithShippingNoteInfos:(NSArray *)shippingNoteInfos listener:(void(^)(id model, NSError *error))listener{
    NSMutableArray * aryDatas = [NSMutableArray new];
    for (ModelOrderList * modelItem in shippingNoteInfos) {
        if ([modelItem isKindOfClass:[ModelOrderList class]]) {
            [RequestApi requestTransportDeptlWithId:modelItem.startAreaId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                NSString * startCode = [response stringValueForKey:@"code"];
                [RequestApi requestTransportDeptlWithId:modelItem.endAreaId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    NSString * endCode = [response stringValueForKey:@"code"];
                    if (isStr(startCode)&& isStr(endCode)) {
                        [aryDatas addObject:@{@"shippingNoteNumber":UnPackStr(modelItem.waybillNumber),@"serialNumber":@"0000",@"startCountrySubdivisionCode":startCode,@"endCountrySubdivisionCode":endCode}];
                        [self.mapTransport stopLocationWithShippingNoteInfos:aryDatas listener:listener];
                        return;
                    }
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
            
        }else if ([modelItem isKindOfClass:[ModelBulkCargoOrder class]]){
                ModelBulkCargoOrder * modelBulkItem = (ModelBulkCargoOrder *)modelItem;
                [RequestApi requestTransportDeptlWithId:modelBulkItem.startTownId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    NSString * startCode = [response stringValueForKey:@"code"];
                    [RequestApi requestTransportDeptlWithId:modelBulkItem.endTownId  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        NSString * endCode = [response stringValueForKey:@"code"];
                        if (isStr(startCode)&& isStr(endCode)) {
                            [aryDatas addObject:@{@"shippingNoteNumber":UnPackStr(modelBulkItem.waybillNumber),@"serialNumber":@"0000",@"startCountrySubdivisionCode":startCode,@"endCountrySubdivisionCode":endCode}];
                            [self.mapTransport stopLocationWithShippingNoteInfos:aryDatas listener:listener];
                            return;
                        }
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];        }
    }
}
#pragma mark delegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    ModelAddress * modelAddress = [ModelAddress initWithAMapLocationReGeocode:reGeocode location:location];
    if (!modelAddress.lat) {
        return;
    }
    [ModelAddress saveLastLocation:modelAddress];
    
    NSLog(@"sld %f,%f,speed:%f",modelAddress.lat,modelAddress.lng,location.speed);
    //本地记录
    {
        ModelAddress * addressLast = [GlobalData sharedInstance].aryLocations.lastObject;
        MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(modelAddress.lat,modelAddress.lng));
        MAMapPoint point2 =  MAMapPointForCoordinate(CLLocationCoordinate2DMake(addressLast.lat,addressLast.lng));
        //2.计算距离
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        if (distance > 5||addressLast.lat == 0) {
            [[GlobalData sharedInstance].aryLocations addObject:modelAddress];
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_LOCATION_CHANGE object:nil];
            [self requestUpuserLocation:modelAddress];
        }
    }
    NSMutableArray * ary = [GlobalMethod readAry:LOCAL_LOCATION_RECORD modelName:@"ModelAddress"];
    //计算距离
    if (ary.count) {
        ModelAddress * addressLast = ary.lastObject;
        MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(modelAddress.lat,modelAddress.lng));
        MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(addressLast.lat,addressLast.lng));
        //2.计算距离
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        if (distance <800) {
            return;
        }
    }
    
    [ary addObject:modelAddress];
    [GlobalMethod writeAry:ary key:LOCAL_LOCATION_RECORD];
    //请求
    [self request:ary blockSuccess:nil];
}
- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager{
    NSLog(@"%@",locationManager);
    [locationManager requestAlwaysAuthorization];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self startRecord];
    }else{
        [self.locationManager stopUpdatingLocation];
    }
}
#pragma mark request
- (void)request:(NSMutableArray *)aryParameter blockSuccess:(void (^)(void))successBlock{
    if (!isAry(aryParameter)) {
        return;
    }
    if (![GlobalData sharedInstance].GB_UserModel.iDProperty) {
        return;
    }
    static NSDate * dateRequest = nil;
    if (dateRequest && [[NSDate date]timeIntervalSinceDate:dateRequest]<30) {
        return;
    }
    NSMutableArray * aryJson = [NSMutableArray array];
    for (ModelAddress * modelItem in aryParameter) {
        [aryJson addObject:@{@"uploaderId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.iDProperty),
                             @"lng":NSNumber.dou(modelItem.lng),
                             @"terminalNumber":UnPackStr([CloudPushSDK getDeviceId]),
                             @"terminalType":@1,
                             @"collectTime":[NSNumber numberWithLong:(long)modelItem.dateRecord],
                             @"addr":UnPackStr(modelItem.desc),
                             @"lat":NSNumber.dou(modelItem.lat),
                             @"spd":NSNumber.lon(modelItem.spd)
        }];
    }
    NSString * strJson = [GlobalMethod exchangeDicToJson:aryJson];
    [RequestApi requestAddLocationsWithData:strJson delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        dateRequest = [NSDate date];
        NSMutableArray * aryLocation = [GlobalMethod readAry:LOCAL_LOCATION_RECORD modelName:@"ModelAddress"];
        {//删除本地数据
            ModelAddress * itemLast = aryParameter.lastObject;
            for (ModelAddress * item in [GlobalData sharedInstance].aryLocations) {
                if (item.dateRecord > itemLast.dateRecord) {
                    [[GlobalData sharedInstance].aryLocations removeObjectsInRange:NSMakeRange(0, [[GlobalData sharedInstance].aryLocations indexOfObject:item])];
                    break;
                }
            }
        }
        if (aryLocation.count >= aryParameter.count) {
            [aryLocation removeObjectsInRange:NSMakeRange(0, aryParameter.count)];
            [GlobalMethod writeAry:aryLocation key:LOCAL_LOCATION_RECORD];
        }
        if (successBlock) {
            successBlock();
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_LOCATION_UP_SUCCESS object:nil];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestUpuserLocation:(ModelAddress *)model{
    if (![GlobalMethod isLoginSuccess]) {
        return;
    }
    static NSDate * dateRequestLocation = nil;
    if (dateRequestLocation && [[NSDate date]timeIntervalSinceDate:dateRequestLocation]<180) {
        return;
    }
    [RequestApi requestAddLocationWithLng:model.lng addr:model.desc lat:model.lat spd:model.spd delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        dateRequestLocation = [NSDate date];
        NSLog(@"success");
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        NSLog(@"fail");
    }];
}

@end
