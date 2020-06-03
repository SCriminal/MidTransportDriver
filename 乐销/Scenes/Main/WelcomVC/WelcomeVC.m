//
//  WelcomeVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/15.
//Copyright © 2019 ping. All rights reserved.
//

#import "WelcomeVC.h"
//高德地图
#import <MAMapKit/MAMapView.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAPinAnnotationView.h>
//init location
#import "BaseVC+Location.h"
//loginvc
#import "LoginViewController.h"

@interface WelcomeVC ()<MAMapViewDelegate>
//地图
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic, strong) UIButton *btnBig;
@property (nonatomic, strong) UIButton *btnSmall;
@property (nonatomic, strong) UIButton *btnCenter;
@property (nonatomic, strong) UIButton *btnUser;
@property (nonatomic, strong) WelcomeBottomView *bottomView;

@end

@implementation WelcomeVC
#pragma mark lazy init
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
-(UIButton *)btnUser{
    if (_btnUser == nil) {
        _btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUser addTarget:self action:@selector(btnUserClick) forControlEvents:UIControlEventTouchUpInside];
        _btnUser.backgroundColor = [UIColor clearColor];
        [_btnUser setBackgroundImage:[UIImage imageNamed:@"welcome_user"] forState:UIControlStateNormal];
        _btnUser.widthHeight = XY(W(68),W(68));
        _btnUser.leftTop = XY(W(2), STATUSBAR_HEIGHT + W(2));
        
    }
    return _btnUser;
}
-(UIButton *)btnBig{
    if (_btnBig == nil) {
        _btnBig = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBig addTarget:self action:@selector(btnAmplifyClick) forControlEvents:UIControlEventTouchUpInside];
        _btnBig.backgroundColor = [UIColor clearColor];
        [_btnBig setBackgroundImage:[UIImage imageNamed:@"welcome_add"] forState:UIControlStateNormal];
        _btnBig.widthHeight = XY(W(57),W(57));
        _btnBig.rightBottom = XY(self.btnCenter.right, self.btnSmall.top - W(2));
        
    }
    return _btnBig;
}
-(UIButton *)btnSmall{
    if (_btnSmall == nil) {
        _btnSmall = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSmall addTarget:self action:@selector(btnReduceClick) forControlEvents:UIControlEventTouchUpInside];
        _btnSmall.backgroundColor = [UIColor clearColor];
        [_btnSmall setBackgroundImage:[UIImage imageNamed:@"welcome_subtract"] forState:UIControlStateNormal];
        _btnSmall.widthHeight = XY(W(57),W(57));
        _btnSmall.rightBottom = XY(self.btnCenter.right, self.btnCenter.top - W(2));
    }
    return _btnSmall;
}
-(UIButton *)btnCenter{
    if (_btnCenter == nil) {
        _btnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCenter addTarget:self action:@selector(btnCenterClick) forControlEvents:UIControlEventTouchUpInside];
        _btnCenter.backgroundColor = [UIColor clearColor];
        [_btnCenter setBackgroundImage:[UIImage imageNamed:@"welcome_seat"] forState:UIControlStateNormal];
        _btnCenter.widthHeight = XY(W(57),W(57));
        _btnCenter.rightBottom = XY(SCREEN_WIDTH - W(10), self.bottomView.top - W(17));
    }
    return _btnCenter;
}
- (WelcomeBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [WelcomeBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        _bottomView.blockClick = ^{
            [GB_Nav pushViewController:[LoginViewController new] animated:true];
        };
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.btnBig];
    [self.view addSubview:self.btnSmall];
    [self.view addSubview:self.btnCenter];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.btnUser];

    //init location
    [self initLocation];    
}

#pragma mark init location
- (void)fetchLocation:(CLLocation *)location{
    self.mapView.centerCoordinate =location.coordinate;
}

- (void)btnAmplifyClick{
    self.mapView.zoomLevel++;
}
- (void)btnReduceClick{
    self.mapView.zoomLevel--;
}
- (void)btnCenterClick{
    self.mapView.centerCoordinate =self.mapView.userLocation.coordinate;
}
- (void)btnUserClick{
    [GB_Nav pushViewController:[LoginViewController new] animated:true];
}




#pragma mark status bar type
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end



@implementation WelcomeBottomView
#pragma mark 懒加载
- (UIImageView *)ivSurround{
    if (_ivSurround == nil) {
        _ivSurround = [UIImageView new];
        _ivSurround.image = [UIImage imageNamed:@"welcome_surround"];
        _ivSurround.widthHeight = XY(W(129),W(61));
        _ivSurround.userInteractionEnabled = true;
        [_ivSurround addTarget:self action:@selector(imageClick)];
    }
    return _ivSurround;
}
- (UIImageView *)ivGift{
    if (_ivGift == nil) {
        _ivGift = [UIImageView new];
        _ivGift.image = [UIImage imageNamed:@"welcome_gift"];
        _ivGift.widthHeight = XY(W(92),W(92));
        _ivGift.userInteractionEnabled = true;
        [_ivGift addTarget:self action:@selector(imageClick)];
    }
    return _ivGift;
}
- (UIImageView *)ivOrder{
    if (_ivOrder == nil) {
        _ivOrder = [UIImageView new];
        _ivOrder.image = [UIImage imageNamed:@"welcome_order"];
        _ivOrder.widthHeight = XY(W(129),W(61));
        _ivOrder.userInteractionEnabled = true;
        [_ivOrder addTarget:self action:@selector(imageClick)];
    }
    return _ivOrder;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivSurround];
    [self addSubview:self.ivGift];
    [self addSubview:self.ivOrder];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.ivGift.centerXTop = XY(SCREEN_WIDTH/2.0,0);

    self.ivSurround.rightCenterY = XY(self.ivGift.left-W(6) ,self.ivGift.centerY);
    
    self.ivOrder.leftCenterY = XY(self.ivGift.right+W(6)  ,self.ivGift.centerY);
    
    //设置总高度
    self.height = self.ivGift.bottom + W(10) + iphoneXBottomInterval;
}

#pragma mark click
- (void)imageClick{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end
