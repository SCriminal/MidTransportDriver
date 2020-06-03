//
//  UIView+Category.m
//中车运
//
//  Created by 刘惠萍 on 2017/5/29.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
//get
- (BOOL)isEdited{
    if ([self isKindOfClass:[UITextField class]]||[self isKindOfClass:[UITextView class]]) {
        UITextView * text = (UITextView *)self;
        if (self.userInteractionEnabled && isStr(text.text)) {
            if ([text.text intValue] != 1) {
                return true;
            }
        }
    }
    for (UIView * viewSub in self.subviews) {
        if (viewSub.isEdited) {
            return true;
        }
    }
    return false;
}
//fist responder
- (UIView *)fetchFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView fetchFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

//获取所在vc
- (UIViewController *)fetchVC{
    UIView * view = self;
    while (view) {
        UIResponder* nextResponder = [view nextResponder];
        if (nextResponder && [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
        view = view.superview;
    }
    return nil;
}

//移除全部
- (void)removeAllSubViews{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

//增加顶部高度
- (void)addSubViewsTopHeight:(CGFloat)height{
    for (UIView * view in self.subviews) {
        view.top += height;
    }
    self.height += height;
}

// 移除视图
- (void)removeSubViewWithTag:(NSInteger)tag{
    if (self == nil) return;
    NSArray * aryView = self.subviews;
    for (UIView * viewSub in aryView) {
        if (viewSub.tag == tag) {
            [viewSub removeFromSuperview];
        }
    }
}

//获取子视图  根据tag
- (NSMutableArray  *)fetchSubViewsWithTag:(NSInteger)tag{
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (UIView * subView in self.subviews) {
        if (subView.tag == tag) {
            [aryReturn addObject:subView];
        }
    }
    return aryReturn;
}

//添加线
- (CGFloat)addLineFrame:(CGRect)rect{
    return [self addLineFrame:rect color:COLOR_LINE];
}
- (CGFloat)addLineFrame:(CGRect)rect tag:(NSInteger)tag{
    return [self addLineFrame:rect color:COLOR_LINE tag:tag];
}
- (CGFloat)addLineFrame:(CGRect)rect color:(UIColor *)color{
    return [self addLineFrame:rect color:color tag:TAG_LINE];
}
- (CGFloat)addLineFrame:(CGRect)rect color:(UIColor *)color tag:(NSInteger)tag{
    UIView * viewLine = [UIView lineWithFrame:rect color:color];
    viewLine.tag = tag;
    [self addSubview:viewLine];
    return viewLine.bottom;
}
- (CGFloat)addLineWithHeight:(CGFloat)height{
    return [self addLineFrame:CGRectMake(0, 0, self.width, height) color:COLOR_LINE];
}
//获取线视图
+ (UIView *)lineWithFrame:(CGRect)rect color:(UIColor *)color{
    UIView * viewLine = [[UIView alloc]initWithFrame:rect];
    viewLine.backgroundColor = color;
    viewLine.tag = TAG_LINE;
    return viewLine;
}
+ (UIView *)lineWithHeight:(CGFloat)height{
    return [self lineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) color:COLOR_LINE];
}
+ (UIView *)lineWithHeight:(CGFloat)height backGroundColor:(UIColor *)color{
    return [self lineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) color:color];
}

/**
 增加点击事件
 
 @param target 目标
 @param action 点击事件
 */
- (void)addTarget:(id)target action:(SEL)action{
    if(target){
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapClick=[[UITapGestureRecognizer alloc]initWithTarget:target action:action];
        tapClick.delegate = target;
        [self addGestureRecognizer:tapClick];
    }
}
- (UIView *)addControlFrame:(CGRect)frame belowView:(UIView *)view target:(id)target action:(SEL)action{
    if (!view) {
        return nil;
    }
    UIView * superView = view.superview;
    if (!superView) {
        return nil;
    }
    UIControl * con = [[UIControl alloc]initWithFrame:frame];
    [con addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [superView insertSubview:con belowSubview:view];
    return con;
}

- (void)addKeyboardHideGesture{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHideKeyboardClick)];
    tap.cancelsTouchesInView = NO;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}
- (void)tapGestureHideKeyboardClick{
    [GlobalMethod hideKeyboard];
}
#pragma mark gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIControl class]]) {
        return  false;
    }if ([touch.view isKindOfClass:[UICollectionView class]]){
        return false;
    }
    return true;
}


@end
