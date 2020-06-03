//
//  MapView.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//高德地图
#import <MAMapKit/MAMapView.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAPinAnnotationView.h>

@interface MapView : UIView
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;
//地图
@property (nonatomic,strong) MAMapView *mapView;
//定位
@property (nonatomic, strong) AMapLocationManager * locationManager;
#pragma mark 刷新view
- (void)resetViewWithFrame:(CGRect)frame;

@end
