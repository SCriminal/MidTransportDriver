//
//  IntegralCenterVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralCenterVC.h"

@interface IntegralCenterVC ()

@end

@implementation IntegralCenterVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"积分商城" rightTitle:@"订单" rightBlock:^{
        
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
//    [self.view addSubview:[BaseNavView initNavBackTitle:<#导航栏标题#> rightView:nil]];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
