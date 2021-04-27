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
#import "PerfectAuthorityInfoVC.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
//
#import "RequestApi+Location.h"
//import request
#import "RequestApi+UserApi.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "ScheduleConfirmView.h"


@interface TestVC ()<UIWebViewDelegate,NSURLSessionDelegate> 

@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) UILabel *labelShow;

@end

@implementation TestVC

#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF
    //config nav
    BaseNavView * nav =[BaseNavView initNavBackTitle:@"测试" rightTitle:@"FlashLogin" rightBlock:^{
        [weakSelf.view endEditing:true];
        [weakSelf jump];
    }];
    [nav configRedStyle];
    [self.view addSubview:nav];
    [self.view addSubview:self.labelShow];
    self.labelShow.leftTop = XY(0, NAVIGATIONBAR_HEIGHT);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(datarefresh) name:NOTICE_LOCATION_CHANGE object:nil];
    
    [CLShanYanSDKManager preGetPhonenumber];
    return;
}

- (void)jump{
//    [GB_Nav pushVCName:@"ScheduleOrderInfoVC" animated:true];
//    d dateFromString:<#(nonnull NSString *)#>

    [RequestApi requestValidCarListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelValidCar"];
//        self.confirmView.aryDatas = ary;
        ScheduleConfirmView *_confirmView = [ScheduleConfirmView new];
        _confirmView.aryDatas = ary;
        [_confirmView resetViewWithModel:0];
        [_confirmView show];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        ScheduleConfirmView *_confirmView = [ScheduleConfirmView new];
        [_confirmView resetViewWithModel:1];
        [_confirmView show];
    }];

}

- (void)addVersion{
//    [RequestApi requestAddVersionWithForceUpdate:false versionNumber:@"1.53" description:@"1.优化轨迹获取逻辑；\n2.设置中增加版本号显示\n" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        NSLog(@"success");
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//    }];
}

@end



