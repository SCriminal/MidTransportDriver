//
//  BulkCargoOrderDetailTrackView.m
//  Driver
//
//  Created by 隋林栋 on 2020/7/31.
//Copyright © 2020 ping. All rights reserved.
//

#import "BulkCargoOrderDetailTrackView.h"
//高德地图
#import <MAMapKit/MAMapView.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAPinAnnotationView.h>
#import <MAMapKit/MAPolyline.h>
#import <MAMapKit/MAPolylineRenderer.h>

//request
//request
#import "RequestApi+BulkCargo.h"
#import "RequestApi+Location.h"

@interface BulkCargoOrderDetailTrackView ()<MAMapViewDelegate,NSURLSessionDelegate>
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) UIView *mapViewSuperiew;

@property (nonatomic, strong) ModelBulkCargoOrder *modelOrder;
@property (nonatomic, strong) NSMutableArray *aryLocationRequest;
@property (nonatomic, assign) CLLocationCoordinate2D locationStart;
@property (nonatomic, assign) CLLocationCoordinate2D locationEnd;

@end

@implementation BulkCargoOrderDetailTrackView
#pragma mark 懒加载
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, W(325), W(150))];
        _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
        _mapView.showsScale= NO;
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.rotateEnabled = false;
        _mapView.rotateCameraEnabled = false;
        _mapView.showsUserLocation = false;
        _mapView.clipsToBounds = true;
        [_mapView setZoomLevel:MAPZOOMNUM animated:true];
        _mapView.userTrackingMode = MAUserTrackingModeNone;
    }
    return _mapView;
}
- (UIView *)mapViewSuperiew{
    if (!_mapViewSuperiew) {
        _mapViewSuperiew = [UIView new];
        _mapViewSuperiew.size = CGSizeMake(W(325), W(150));
        _mapViewSuperiew.clipsToBounds = true;
        [_mapViewSuperiew addSubview:self.mapView];
    }
    return _mapViewSuperiew;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelTitle fitTitle:@"路线轨迹" variable:0];
        
    }
    return _labelTitle;
}

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    [self addSubview:self.mapViewSuperiew];

}
-(void)requestTrick{
    if (!self.modelOrder.loadTime) {
        self.mapView.showsUserLocation = true;
        return;
    }
    double finishTime = self.modelOrder.unloadTime?self.modelOrder.unloadTime:self.modelOrder.finishTime;
    [RequestApi requestCarLocationWithuploaderId:self.modelOrder.driverId startTime:self.modelOrder.loadTime endTime:finishTime?finishTime:[[NSDate date]timeIntervalSince1970] vehicleNumber:self.modelOrder.vehicleNumber  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryLocationRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelLocationItem"];
        [self drawLine:self.aryLocationRequest.mutableCopy];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        self.mapView.showsUserLocation = true;
    } ];
    
}



#pragma mark line
- (void)drawLine:(NSMutableArray *)aryLocation{
   
    if (!isAry(aryLocation)) {
        self.mapView.showsUserLocation = true;
        return;
    }
    {
        ModelLocationItem *item = aryLocation.firstObject;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(item.lat, item.lng) animated:false];
    }
    
    //draw line
    CLLocationCoordinate2D commonPolylineCoords[aryLocation.count];
    for (int i = 0; i<aryLocation.count; i++) {
        ModelLocationItem *item = aryLocation[i];
        commonPolylineCoords[i].latitude = item.lat;
        commonPolylineCoords[i].longitude = item.lng;
    }
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:aryLocation.count];
    
    //在地图上添加折线对象
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView addOverlay:commonPolyline];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    //drwa end point annotation
    if (isAry(aryLocation)) {
        ModelLocationItem *item = aryLocation.firstObject;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(item.lat, item.lng);
        [self.mapView addAnnotation:pointAnnotation];
    }
    
    //draw start point annotation
    ModelLocationItem *item = aryLocation.lastObject;
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(item.lat, item.lng);
    self.locationStart = pointAnnotation.coordinate;
    [self.mapView addAnnotation:pointAnnotation];
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView =  [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        if(annotation.coordinate.latitude == self.locationStart.latitude && annotation.coordinate.longitude == self.locationStart.longitude){
            annotationView.image =  [UIImage imageNamed:@"origin_map"];
        }
        if(annotation.coordinate.latitude == self.locationEnd.latitude && annotation.coordinate.longitude == self.locationEnd.longitude){
            annotationView.image =  [UIImage imageNamed:@"car_map"];
        }
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        //        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        polylineRenderer.strokeImage = [UIImage imageNamed:@"arrowTexture"];
        
        return polylineRenderer;
    }
    return nil;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    self.modelOrder = model;
    [self requestTrick];
    [self removeSubViewWithTag:TAG_LINE];//移除线

    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    self.mapViewSuperiew.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(18));
    
    self.height = top + W(186);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}


@end
