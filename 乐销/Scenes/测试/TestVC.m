//
//  TestVC.m
//  中车运
//
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "TestVC.h"
#import "BaseNavView+Logical.h"
#import "BaseVC+BaseImageSelectVC.h"
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
#import "ShareView.h"
#import "TopAlertView.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
//
#import "RequestApi+Location.h"
//import request
#import "RequestApi+UserApi.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "RechargeInputView.h"
#import "GuideView.h"
#import "AuthTwoVC.h"

@interface TestVC ()<UIWebViewDelegate,NSURLSessionDelegate> 

@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) UILabel *labelShow;

@end

@implementation TestVC

- (UIWebView *)web{
    if (!_web) {
        _web = [UIWebView new];
        _web.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _web.delegate = self;
    }
    return _web;
}
- (UILabel *)labelShow{
    if (!_labelShow) {
        _labelShow = [UILabel new];
        _labelShow.fontNum = F(16);
        _labelShow.textColor = [UIColor blackColor];
        _labelShow.backgroundColor = [UIColor whiteColor];
        _labelShow.numberOfLines = 0;
        _labelShow.backgroundColor = [UIColor redColor];
        [_labelShow fitTitle:@"test" variable:0];
    }
    return _labelShow;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF
    //config nav
    BaseNavView * nav =[BaseNavView initNavBackTitle:@"测试" rightTitle:@"FlashLogin" rightBlock:^{
        [weakSelf.view endEditing:true];
        [weakSelf jump];
    }];
    [self.view addSubview:nav];
    [self.view addSubview:self.labelShow];
    self.labelShow.leftTop = XY(0, NAVIGATIONBAR_HEIGHT);
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(datarefresh) name:NOTICE_LOCATION_CHANGE object:nil];
    
    [CLShanYanSDKManager preGetPhonenumber];
    return;
}

- (void)jump{
    [self.view addSubview:[NSClassFromString(@"AdvertiesementView") new]];

}
/**
 当前周的日期范围

 @param firstWeekday 星期起始日
 @param dateFormat 日期格式
 @return 结果字符串
 */

- (void)addVersion{
//    [RequestApi requestAddVersionWithForceUpdate:false versionNumber:@"1.53" description:@"1.优化轨迹获取逻辑；\n2.设置中增加版本号显示\n" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        NSLog(@"success");
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//    }];
}

@end



