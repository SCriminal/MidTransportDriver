//
//  UITextField+Text.m
//中车运
//
//  Created by 隋林栋 on 2018/4/30.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "UITextField+Text.h"
//runtime
#import <objc/runtime.h>

static const void *key_textField_maxLength = &key_textField_maxLength;
static const void *key_textField_contentType = &key_textField_contentType;
static const void *key_textField_regularStr = &key_textField_regularStr;
static const void *key_textField_dispacthDelegateModel = &key_textField_dispacthDelegateModel;

//protol contain selector
BOOL sld_protocolContainSel(Protocol *protocol, SEL sel) {
    struct objc_method_description des = protocol_getMethodDescription(protocol, sel, NO, YES);
    return des.types ? YES: NO;
}

static BOOL sld_judgeRegular(NSString *contentStr, NSString *regularStr) {
    NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regularStr options:0 error:&error];
    if (error) {
        return YES;
    }
    NSArray *results = [regex matchesInString:contentStr options:0 range:NSMakeRange(0, contentStr.length)];
    return results.count > 0;
}
//
BOOL sld_shouldChangeCharacters(id<TextPropertyDelegate> target, NSRange range, NSString *string) {
    if (!target) {
        return YES;
    }
    //计算若输入成功的字符串
    NSString * resultStr = [target.text stringByReplacingCharactersInRange:range withString:string] ;
    //正则表达式匹配
    if (resultStr.length > 0) {
        if (!target.regularStr || target.regularStr.length <= 0) {
            return YES;
        }
        return sld_judgeRegular(resultStr, target.regularStr);
    }
    return YES;
}
void sld_textDidChange(id<TextPropertyDelegate> target) {
    if (!target) {
        return;
    }
    //内容适配
    NSLog(@"%ld",target.maxLength);
    
    if (target.maxLength != 0 && target.markedTextRange == nil) {
        NSString *resultText = target.text;
        //再判断长度
        if (resultText.length > target.maxLength) {
            target.text = [resultText substringToIndex:target.maxLength];
        } else {
            target.text = resultText;
        }
    }
}



#pragma mark model dispacth delegate
@interface ModelDispacthDelegate : NSObject <UITextFieldDelegate>
@property (nonatomic, weak) id delegate_inside;
@property (nonatomic, weak) id delegate_outside;
@property (nonatomic, strong) Protocol *protocol;
@end

@implementation ModelDispacthDelegate
- (BOOL)respondsToSelector:(SEL)aSelector {
    if (!sld_protocolContainSel(self.protocol, aSelector)) {
        return [super respondsToSelector:aSelector];
    }
    if ([self.delegate_inside respondsToSelector:aSelector] || [self.delegate_outside respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    BOOL isResponds = NO;
    if ([self.delegate_inside respondsToSelector:sel]) {
        isResponds = YES;
        [anInvocation invokeWithTarget:self.delegate_inside];
    }
    if ([self.delegate_outside respondsToSelector:sel]) {
        isResponds = YES;
        [anInvocation invokeWithTarget:self.delegate_outside];
    }
    if (!isResponds) {
        [self doesNotRecognizeSelector:sel];
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig_inside = [self.delegate_inside methodSignatureForSelector:aSelector];
    NSMethodSignature *sig_outside = [self.delegate_outside methodSignatureForSelector:aSelector];
    NSMethodSignature *result_sig = sig_inside?:sig_outside?:nil;
    return result_sig;
}
- (Protocol *)protocol {
    if (!_protocol) {
        _protocol = objc_getProtocol("UITextFieldDelegate");
    }
    return _protocol;
}
@end

@implementation UITextField (Text)

#pragma mark custom synthesize
- (void)setMaxLength:(NSUInteger)maxLength{
    [self addEditingChangeTarget];
    objc_setAssociatedObject(self, key_textField_maxLength, [NSNumber numberWithUnsignedInteger:maxLength], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSUInteger)maxLength{
    NSNumber * number = objc_getAssociatedObject(self, key_textField_maxLength);
    return number && [number isKindOfClass:NSNumber.self] ? number.unsignedIntegerValue : 0;
}
- (void)setContentType:(ENUM_TEXT_CONTENT_TYPE)contentType{
    objc_setAssociatedObject(self, key_textField_contentType, [NSNumber numberWithInteger:contentType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    switch (contentType) {
        case ENUM_TEXT_CONTENT_TYPE_NONE:
        {
            self.regularStr = nil;
            [self removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            return;
        }
            break;
        case ENUM_TEXT_CONTENT_TYPE_PRICE:
        {
            self.regularStr = @"^(([1-9]\\d*)|0)(\\.\\d{0,2})?$";
            self.keyboardType = UIKeyboardTypeDecimalPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.delegate = self.delegate;
        }
            break;
        default:
            break;
    }
    [self addEditingChangeTarget];
}
- (ENUM_TEXT_CONTENT_TYPE)contentType{
    NSNumber * number = objc_getAssociatedObject(self, key_textField_contentType);
    return number && [number isKindOfClass:NSNumber.self] ? number.integerValue : 0;
}
- (void)setRegularStr:(NSString *)regularStr{
    objc_setAssociatedObject(self, key_textField_regularStr, regularStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)regularStr{
    return objc_getAssociatedObject(self, key_textField_regularStr);
}

#pragma mark replace set delegate
+ (void)load {
        //更改光标
    [[UITextField appearance] setTintColor:COLOR_BLUE];

    if ([NSStringFromClass(self) isEqualToString:@"UITextField"]) {
        Method m1 = class_getInstanceMethod(self, @selector(setDelegate:));
        Method m2 = class_getInstanceMethod(self, @selector(sld_setDelegate:));
        if (m1 && m2) {
            method_exchangeImplementations(m1, m2);
        }
    }
}

#pragma mark sld set delegate
- (void)sld_setDelegate:(id)delegate {
    @synchronized(self) {
        ModelDispacthDelegate *tempDelegate = [ModelDispacthDelegate new];
        tempDelegate.delegate_inside = self;
        if ([delegate isKindOfClass:ModelDispacthDelegate.self]) {
            tempDelegate.delegate_outside = [(ModelDispacthDelegate *)delegate delegate_outside];
        }else{
            tempDelegate.delegate_outside = delegate;
        }
        //持久化存储
        objc_setAssociatedObject(self, key_textField_dispacthDelegateModel, tempDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self sld_setDelegate:tempDelegate];
    }
}

#pragma mark add target
- (void)addEditingChangeTarget{
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return sld_shouldChangeCharacters((id<TextPropertyDelegate>)textField, range, string);
}
- (void)textFieldDidChange:(UITextField *)textField {
    sld_textDidChange((id<TextPropertyDelegate>)textField);
}
@end

@implementation UITextView (YBInputControl)

#pragma mark custom synthesize
- (void)setMaxLength:(NSUInteger)maxLength{
    objc_setAssociatedObject(self, key_textField_maxLength, [NSNumber numberWithUnsignedInteger:maxLength], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSUInteger)maxLength{
    NSNumber * number = objc_getAssociatedObject(self, key_textField_maxLength);
    return number && [number isKindOfClass:NSNumber.self] ? number.unsignedIntegerValue : 0;
}
- (void)setContentType:(ENUM_TEXT_CONTENT_TYPE)contentType{
    objc_setAssociatedObject(self, key_textField_contentType, [NSNumber numberWithInteger:contentType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    switch (contentType) {
        case ENUM_TEXT_CONTENT_TYPE_NONE:
        {
            self.regularStr = nil;
            return;
        }
            break;
        case ENUM_TEXT_CONTENT_TYPE_PRICE:
        {
            self.regularStr = @"^(([1-9]\\d*)|0)(\\.\\d{0,2})?$";
            self.keyboardType = UIKeyboardTypeDecimalPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
        }
            break;
        default:
            break;
    }
}
- (ENUM_TEXT_CONTENT_TYPE)contentType{
    NSNumber * number = objc_getAssociatedObject(self, key_textField_contentType);
    return number && [number isKindOfClass:NSNumber.self] ? number.integerValue : 0;
}
- (void)setRegularStr:(NSString *)regularStr{
    objc_setAssociatedObject(self, key_textField_regularStr, regularStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)regularStr{
    return objc_getAssociatedObject(self, key_textField_regularStr);
}


#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return sld_shouldChangeCharacters((id<TextPropertyDelegate>)textView, range, text);
}
- (void)textViewDidChange:(UITextView *)textView {
    sld_textDidChange((id<TextPropertyDelegate>)textView);
}

@end


