//
//  CustomTabBar.m
//  DouBanProject
//
//  Created by wuli萍萍 on 16/5/6.
//  Copyright © 2016年 wuli萍萍. All rights reserved.
//

#import "CustomTabBar.h"

#define NUM_TAB 5
@implementation CustomTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (isIphoneX) {
        return;
    }
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    CGFloat buttonW = barWidth / NUM_TAB;// 每个的宽
    CGFloat buttonH = barHeight - 2.0;// 每个的高
    CGFloat buttonY = 1.0;// button的X坐标，因为设置距离上下各1厘米
        
    for (UIView *view in self.subviews) {
        // 获得这个类,并将类转换成字符串
        //NSString *viewClass = NSStringFromClass([view class]);
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 获取button的x
            view.frame = CGRectMake(view.left, buttonY, buttonW, buttonH);
        }
    }
    for (UIView * view in self.subviews) {
        if (view.tag >= 888) {
            [self addSubview:view];
            return;
        }
    }
}

@end
