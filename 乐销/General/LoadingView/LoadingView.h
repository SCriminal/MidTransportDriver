//
//  LoadingView.h
//  米兰港
//
//  Created by 隋林栋 on 15/3/5.
//  Copyright (c) 2015年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (strong, nonatomic) UIImageView *imageLoading;

- (void)resetFrame:(CGRect)frame viewShow:(UIView *)viewShow;
- (void)hideLoading;
//stop animate
- (void)stopAnimate;
//begin animate
- (void)beginAnimate;
@end
