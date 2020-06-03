//
//  BaseVC+KeyboardObserve.h
//中车运
//
//  Created by 隋林栋 on 2017/1/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC.h"


@interface BaseVC (KeyboardObserve)<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *firstResponserView;
@property (nonatomic, assign) BOOL isKeyboardObserve;
//添加/移除键盘监听
- (void)addKeyboardObserve;
- (void)removeKeyboardObserve;

//移动位置
- (void)keyboardDidChangeFrame:(NSNotification *)noti;
@end
