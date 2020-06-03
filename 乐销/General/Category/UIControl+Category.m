//
//  UIControl+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/3/10.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIControl+Category.h"

@implementation UIControl (Category)
+ (void)load
{
//    method_exchangeImplementations(class_getInstanceMethod(self,@selector(sendAction: to: forEvent:)), class_getInstanceMethod(self,@selector(sldSendAction: to: forEvent:)));
}
//- (void)sldSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//    if ([self isKindOfClass:[UITextView class]] || [self isKindOfClass:[UITextField class]] ||[self isKindOfClass:NSClassFromString(@"UICalloutBarButton")] ||[self.superview isKindOfClass:[UITextField class]] || [self isKindOfClass:NSClassFromString(@"UIInputSwitcherSegmentControl")]||[self isKindOfClass:NSClassFromString(@"UIKeyboardCandidateUnsplitKeyboardToggleButton")]) {
//        [self sldSendAction:action to:target forEvent:event];
//        return;
//    }
//    if(self.tag >= TAG_KEYBOARD){
//        [self sldSendAction:action to:target forEvent:event];
//        return;
//    }
//    //判断键盘是否弹出
//    if ([GlobalData sharedInstance].isKeyboardShow) {
//        [[UIApplication sharedApplication].keyWindow endEditing:true];
//    }else{
//        [self sldSendAction:action to:target forEvent:event];
//    }
//}
@end
