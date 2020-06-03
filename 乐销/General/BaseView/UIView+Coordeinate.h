//
//  UIView+Coordeinate.h
//中车运
//
//  Created by 隋林栋 on 2017/7/28.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Coordeinate)
//扩展
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

@end
