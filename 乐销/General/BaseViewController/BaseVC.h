//
//  BaseVC.h
//中车运
//
//  Created by 隋林栋 on 2016/12/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//提示view
#import "NoticeView.h"
//loading view
#import "LoadingView.h"
//
#import "RequestApi.h"

@class NoResultView;
@interface BaseVC : UIViewController<RequestDelegate,UITextFieldDelegate>
@property (nonatomic, assign) BOOL isNotShowNoticeView;//不显示notice
@property (nonatomic, assign) BOOL isNotShowLoadingView;//不显示loading
@property (nonatomic, assign) BOOL isShowNoResult;//显示无结果页 default false
@property (nonatomic, assign) BOOL isShowNoResultLoadingView;//显示loading无结果页 default false

@property (nonatomic, strong) LoadingView * loadingView;//loading动画
@property (nonatomic, strong) NoticeView * noticeView;//提示语

@property (nonatomic, strong) UIView *viewBG;//背景颜色

@property (nonatomic, strong) NoResultView *noResultView;//无结果页
@property (nonatomic, strong) NoResultView *noResultLoadingView;//无结果页


#pragma mark - add observe of keyboard
- (void)addObserveOfKeyboard;
//show loading view
- (void)showLoadingView;
@end
