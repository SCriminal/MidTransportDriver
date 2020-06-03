//
//  WebVC.m
//中车运
//
//  Created by 隋林栋 on 2018/11/13.
//Copyright © 2018 ping. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()
@property (nonatomic, strong) UIWebView *webDetails;

@end

@implementation WebVC
- (NSString *)navTitle{
    if (!_navTitle) {
        _navTitle = @"阅读正文";
    }
    return _navTitle;
}
#pragma mark lazy init

- (UIWebView *)webDetails{
    if (!_webDetails) {
        _webDetails = [UIWebView new];
        _webDetails.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
    }
    return _webDetails;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.webDetails];
    [self.webDetails loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:self.navTitle rightView:nil];
    WEAKSELF
    nav.blockBack = ^{
        if ([weakSelf.webDetails canGoBack]) {
            [weakSelf.webDetails goBack];
        }else{
            [GB_Nav popViewControllerAnimated:true];
        }
    };
    [self.view addSubview:nav];
   
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
