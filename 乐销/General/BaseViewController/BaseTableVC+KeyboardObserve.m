//
//  BaseTableVC+KeyboardObserve.m
//中车运
//
//  Created by 隋林栋 on 2017/4/26.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseTableVC+KeyboardObserve.h"
//first responder
#import "BaseVC+KeyboardObserve.h"

@implementation BaseTableVC (KeyboardObserve)

//重写改变方法

- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
    //    键盘的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    键盘的实时Y
    CGFloat keyHeight = SCREEN_HEIGHT - frame.origin.y;
    //    动画时间
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue];
    CGFloat yCorrect = 0;
    if (self.firstResponserView != nil && [self.firstResponserView isDescendantOfView:self.tableView]) {
        CGRect frame = [self.firstResponserView convertRect:self.firstResponserView.bounds toView:self.view];
        yCorrect = - ( SCREEN_HEIGHT - ( frame.origin.y + frame.size.height) - keyHeight  - W(120) );
    }else{
        return [super keyboardDidChangeFrame:noti];
    }
    if (yCorrect < 0) {
        yCorrect = 0;
    }
    //    执行动画
    if (keyHeight != 0) {
        [UIView animateWithDuration:keyDuration animations:^{
            [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x,self.tableView.contentOffset.y+yCorrect) animated:false];
        }completion:^(BOOL finished) {
        }];
    }
    
}
@end
