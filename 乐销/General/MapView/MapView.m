//
//  MapView.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "MapView.h"


@interface MapView ()<MAMapViewDelegate>

@end

@implementation MapView

#pragma mark lazy init
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(100))];
        _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
        _mapView.showsScale= NO;
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = true;
        [_mapView setZoomLevel:MAPZOOMNUM animated:true];
        _mapView.userTrackingMode = MAUserTrackingModeNone;
        
    }
    return _mapView;
}
#pragma mark 刷新view
- (void)resetViewWithFrame:(CGRect)frame{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.frame = frame;
    //重置视图坐标
    self.mapView.frame = CGRectMake(0, 0, self.width, self.height);
    if (self.centerCoordinate.latitude) {
        self.mapView.centerCoordinate = self.centerCoordinate;
    }
}
#pragma mark - 定位
- (void)initLocation
{
    self.locationManager = [[AMapLocationManager alloc]init];
    //带逆地理信息的一次定位（返回坐标和地址信息）
    //kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右，超时时间设置在2s-3s左右即可。
    //高精度：kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右。
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout = 2;
    //逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
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
        //保存地址到本地
        ModelAddress * modelAddress = [ModelAddress initWithAMapLocationReGeocode:regeocode location:location];
        self.centerCoordinate = location.coordinate;
        self.mapView.centerCoordinate =location.coordinate;
    }];
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
        [self initLocation];//定位
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self addSubview:self.mapView];
}

@end
