//
//  MarQueueView.m
//中车运
//
//  Created by 隋林栋 on 2018/6/18.
//Copyright © 2018年 ping. All rights reserved.
//

#import "MarQueueView.h"

@interface MarQueueView ()

@end

@implementation MarQueueView

#pragma mark lazy init
- (UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [UILabel new];
    }
    return _labelTitle;
}

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title{
    [self.labelTitle fitTitle:title variable:0];
    self.labelTitle.x = self.width;
    self.height = self.labelTitle.height;
    
    [self.layer removeAllAnimations];
    //animation
    [UIView beginAnimations:@"Marquee" context:NULL];
    [UIView setAnimationDuration:self.labelTitle.width * 0.01f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:CGFLOAT_MAX];
    CGRect frame = self.labelTitle.frame;
    frame.origin.x = -frame.size.width;
    self.labelTitle.frame = frame;
    [UIView commitAnimations];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.clipsToBounds = true;
        [self addSubview:self.labelTitle];
    }
    return self;
}

#pragma mark 销毁
- (void)dealloc{
    [self.layer removeAllAnimations];
}


@end
