//
//  ImageCodeView.h
//  Driver
//
//  Created by Happy on 2021/4/12.
//Copyright © 2021 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCodeView : UIView
@property (nonatomic, strong) void (^blockEnd)(double x,double identity,double width);
@property (nonatomic, assign) double identity;

#pragma mark 刷新view

//设置默认的滑动
- (void)reconfigSlider;
- (void)resetViewWithModel:(NSString *)urlBig urlSmal:(NSString *)urlSmall alert:(NSString *)alert identity:(double)identity;

@end
