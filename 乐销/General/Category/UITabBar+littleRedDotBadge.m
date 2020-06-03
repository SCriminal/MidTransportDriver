//
//  UITabBar+littleRedDotBadge.m
//中车运
//
//  Created by mengxi on 16/8/20.
//  Copyright © 2016年 ping. All rights reserved.
//     标签视图控制器

#import "UITabBar+littleRedDotBadge.h"


@implementation UITabBar (littleRedDotBadge)

- (void)showBadgeOnItemIndex:(int)index{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    static NSInteger itemNums = 0;//item数量
    if (itemNums == 0) {
        UITabBarController * tabVC = GB_Nav.viewControllers.firstObject;
        if ([tabVC isKindOfClass:[UITabBarController class]]) {
            itemNums = tabVC.childViewControllers.count;
        }
    }
    float percentX = (index + 0.6) / itemNums;
    
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    if (isIphoneX) {
        y = ceilf(0.02 *tabFrame.size.height);
    }
    badgeView.frame = CGRectMake(x, y, 8, 8);
    badgeView.layer.cornerRadius = badgeView.frame.size.width/2;
    
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
