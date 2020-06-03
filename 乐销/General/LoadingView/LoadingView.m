//
//  LoadingView.m
//  米兰港
//
//  Created by 隋林栋 on 15/3/5.
//  Copyright (c) 2015年 Sl. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageLoading];
        self.imageLoading.center = CGPointMake(self.width/2.0, self.height/2.0);
        self.userInteractionEnabled = true;
    }
    return self;
}

- (UIImageView *)imageLoading{
    if (!_imageLoading) {
        _imageLoading = [UIImageView new];
        _imageLoading.image = [UIImage imageNamed:@"加载中"];
        _imageLoading.widthHeight = XY(W(34), W(34));
    }
    return _imageLoading;
}

- (void)resetFrame:(CGRect)frame viewShow:(UIView *)viewShow{
    self.frame = frame;
    self.imageLoading.centerXCenterY = XY(self.width/2.0, self.height/2.0-W(30));
    [viewShow addSubview:self];
    [self beginAnimate];

}

- (void)hideLoading{
    
    [self stopAnimate];
    [self removeFromSuperview];
}

#pragma mark Animate
//begin animate
- (void)beginAnimate{
    [self stopAnimate];
    CABasicAnimation * animate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animate.toValue = @(M_PI*2);
    [animate setRepeatCount:MAXFLOAT];
    [animate setDuration:2];
    [animate setRemovedOnCompletion:true];
    [self.imageLoading.layer addAnimation:animate forKey:@"animated"];
}

//stop animate
- (void)stopAnimate{
    [self.imageLoading.layer removeAllAnimations];
}


@end
