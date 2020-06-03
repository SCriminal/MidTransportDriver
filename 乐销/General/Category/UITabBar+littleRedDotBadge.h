//
//  UITabBar+littleRedDotBadge.h
//中车运
//
//  Created by mengxi on 16/8/20.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (littleRedDotBadge)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index;
//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index;

@end
