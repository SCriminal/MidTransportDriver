//
//  SimpleProgressView.m
//中车运
//
//  Created by LLMPro on 2018/5/24.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "SimpleProgressView.h"

#define KProgressBorderWidth 1.0f
#define KProgressPadding 0.5f
#define KProgressColor [UIColor colorWithRed:50/255.0 green:217/255.0 blue:77/255.0 alpha:1]

@interface SimpleProgressView ()

@property (nonatomic, weak) UIView *tView;

@end


@implementation SimpleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //边框
        UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
        borderView.layer.cornerRadius = self.bounds.size.height * 0.5;
        borderView.layer.masksToBounds = YES;
        borderView.backgroundColor = [UIColor whiteColor];
        borderView.layer.borderColor = [[UIColor whiteColor] CGColor];
        borderView.layer.borderWidth = KProgressBorderWidth;
        [self addSubview:borderView];
        
        //进度
        UIView *tView = [[UIView alloc] init];
        tView.backgroundColor = KProgressColor;
        tView.layer.cornerRadius = (self.bounds.size.height - (KProgressBorderWidth + KProgressPadding) * 2) * 0.5;
        tView.layer.masksToBounds = YES;
        [borderView addSubview:tView];
        self.tView = tView;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat margin = KProgressBorderWidth + KProgressPadding;
    CGFloat maxWidth = self.bounds.size.width - margin * 2;
    CGFloat heigth = self.bounds.size.height - margin * 2;
    
    _tView.frame = CGRectMake(margin, margin, maxWidth * progress, heigth);
}
@end
