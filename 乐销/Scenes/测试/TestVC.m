//
//  TestVC.m
//  中车运
//13300000099
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "TestVC.h"
#import "BaseNavView+Logical.h"
#import "BaseVC+BaseImageSelectVC.h"
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
#import "TopAlertView.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
//
#import "RequestApi+Location.h"
//import request

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "RechargeInputView.h"
#import "GuideView.h"
#import "AuthTwoVC.h"
#import "OrderDetailVC.h"
#import "RejectOrderView.h"
//request
#import "RequestDriver2.h"
#import "ImageCodeView.h"

/*
 
 */

@interface TestVC ()<UIWebViewDelegate,NSURLSessionDelegate>
@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) UILabel *labelShow;
@property (nonatomic, strong) dispatch_source_t timer;

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
    [RequestApi requestFetchImageCodeWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [response arrayValueForKey:@"display"];
        if (ary.count >= 2) {
            //使用方法
            ImageCodeView * codeView = [ImageCodeView new];
            [codeView resetViewWithModel:ary[0] urlSmal:ary[1] alert:[response stringValueForKey:@"tip"] identity:[response doubleValueForKey:@"id"]];
           [self.view addSubview:codeView];
            WEAKSELF
            codeView.blockEnd = ^(double x, double identity, double width) {
                [RequestApi requestVertifyImageCodeWithId:identity phone:@"15263676100" width:width x:x delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    switch ([response intValueForKey:@"status"]) {
                        case 1:
                            [codeView removeFromSuperview];
                            [GlobalMethod showAlert:@"验证成功"];
                            break;
                        case 2:
                            [codeView reconfigSlider];
                            [GlobalMethod showAlert:@"验证失败"];
                            break;
                        case 3:
                            [codeView reconfigSlider];
                            [GlobalMethod showAlert:@"验证次数过多"];
                            break;
                        case 4:
                            [codeView reconfigSlider];
                            [GlobalMethod showAlert:@"无该图形验证码"];
                            [codeView removeFromSuperview];

                            break;
                        default:
                            break;
                    }
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    [codeView reconfigSlider];
                }];
            };
        }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

        }];
//    [self test15];
}

- (void)test15{
   

}
/*
 
 */
- (void)startTimer{
    // 倒计时的时间 测试数据
    // 当前时间的时间戳
    // 计算时间差值
    if (_timer == nil) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 2.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                NSLog(@"sld timer");
            });
            dispatch_resume(_timer);
        
    }
}

@end



