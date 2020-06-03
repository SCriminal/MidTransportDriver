//
//  BaseVC+KeyboardObserve.m
//中车运
//
//  Created by 隋林栋 on 2017/1/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC+KeyboardObserve.h"

static const char firstResponserViewKey = '\0';
static const char isKeyboardObserveKey = '\0';
@implementation BaseVC (KeyboardObserve)

#pragma mark 运行时
- (void)setIsKeyboardObserve:(BOOL)isKeyboardObserve{
    objc_setAssociatedObject(self, &isKeyboardObserveKey, [NSNumber numberWithBool:isKeyboardObserve], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isKeyboardObserve{
   NSNumber * num = objc_getAssociatedObject(self, &isKeyboardObserveKey);
    return (num && [num isKindOfClass:NSNumber.self])?[num boolValue]:false;
}
- (void)setFirstResponserView:(UIView *)firstResponserView{
    objc_setAssociatedObject(self, &firstResponserViewKey, firstResponserView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)firstResponserView{
    UIView * view = objc_getAssociatedObject(self, &firstResponserViewKey);
    if (view == nil) {
        view = [self.view fetchFirstResponder];
        [self setFirstResponserView:view];
    }
    return view;
}

#pragma mark //添加键盘监听
- (void)addKeyboardObserve{
    NSNotificationCenter * nCenter = [NSNotificationCenter defaultCenter];
    [nCenter addObserver:self selector:@selector(myTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [nCenter addObserver:self selector:@selector(myTextFieldDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
    [nCenter addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)removeKeyboardObserve{
    NSNotificationCenter * nCenter = [NSNotificationCenter defaultCenter];
    [nCenter removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [nCenter removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
    [nCenter removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)myTextFieldDidEndEditing:(NSNotification *)noti{
    self.firstResponserView = nil;
}

//移动位置
- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
    //    键盘的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //    键盘的实时Y
    CGFloat keyHeight = SCREEN_HEIGHT -  frame.origin.y;
    //    屏幕的高度
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    //    动画时间
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue];
    CGFloat yCorrect = 0;
    if (self.firstResponserView != nil ) {
        CGRect frame = [self.firstResponserView convertRect:self.firstResponserView.bounds toView:self.view];
        yCorrect = - ( SCREEN_HEIGHT - ( frame.origin.y + frame.size.height) - keyHeight  - W(120) );
    }
    if (yCorrect < 0) {
        yCorrect = 0;
    }
    if (yCorrect > keyHeight ) {//if on the bottom,remove keyHeight Most
        yCorrect = keyHeight;
    }
    //    执行动画
    [UIView animateWithDuration:keyDuration animations:^{
        
        CGFloat transformY = keyHeight == 0 ? 0 : - yCorrect;
        
            self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}
@end
