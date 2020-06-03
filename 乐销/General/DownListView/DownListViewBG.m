//
//  DownListViewBG.m
//中车运
//
//  Created by 隋林栋 on 2016/12/23.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "DownListViewBG.h"
//下拉列表
#import "DownListView.h"
@implementation DownListViewBG

- (DownListView *)viewDown{
    if (!_viewDown) {
        _viewDown = [DownListView new];
    }
    return _viewDown;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        self.isAnimate = false;
        self.alpha = 0;
        [self addSubview:self.viewDown];
        [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark 创建
+ (instancetype)initWithFrame:(CGRect)rect
             downListTopRight:(STRUCT_XY)aryRect
                  downListAry:(NSArray *)aryModel
                       target:(id)target{
    DownListViewBG * view = [DownListViewBG new];
    [view resetWithFrame:rect downListTopRight:aryRect downListAry:aryModel target:target];
    return view;
}
+ (instancetype)initWithFrame:(CGRect)rect
           downListCenterXTop:(STRUCT_XY)aryRect
                  downListAry:(NSArray *)aryModel
                       target:(id)target{
    DownListViewBG * view = [DownListViewBG new];
    [view resetWithFrame:rect downListCenterXTop:aryRect downListAry:aryModel target:target];
    return view;
}
- (void)resetWithFrame:(CGRect)rect
      downListCenterXTop:(STRUCT_XY)aryRect
           downListAry:(NSArray *)aryModel
                target:(id)target{
    [self resetWithFrame:rect downListAry:aryModel target:target];
    self.viewDown.layer.anchorPoint = CGPointMake(0.5, 0);
    self.viewDown.centerXTop = aryRect;
}
- (void)resetWithFrame:(CGRect)rect
      downListTopRight:(STRUCT_XY)aryRect
           downListAry:(NSArray *)aryModel
                target:(id)target{
    [self resetWithFrame:rect downListAry:aryModel target:target];
    self.viewDown.rightTop = aryRect;
}

- (void)resetWithFrame:(CGRect)rect
           downListAry:(NSArray *)aryModel
                target:(id)target{
    self.frame = rect;
    [self.viewDown resetWithAry:aryModel target:target];
    self.viewDown.transform = CGAffineTransformMakeScale(0.1, 0.1);
}
#pragma mark 点击事件
- (void)btnClick{
    [self hideAnimation];
}

#pragma mark 动画

- (void)hideAnimation{
    if (!_isAnimate) {
        _isAnimate = true;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
            self.viewDown.transform = CGAffineTransformMakeScale(0.1, 0.1);

        } completion:^(BOOL finished) {
            _isAnimate = false;
            [self removeFromSuperview];
        }];
    }
}

- (void)showAnimation{
    if (!_isAnimate) {
        _isAnimate = true;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1;
            self.viewDown.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            _isAnimate = false;
        }];
    }
}

@end
