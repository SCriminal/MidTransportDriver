//
//  UITextField+Text.h
//中车运
//
//  Created by 隋林栋 on 2018/4/30.
//  Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ENUM_TEXT_CONTENT_TYPE) {
    ENUM_TEXT_CONTENT_TYPE_NONE = 0, //无限制
    ENUM_TEXT_CONTENT_TYPE_NUMBER,   //数字
    ENUM_TEXT_CONTENT_TYPE_PRICE,    //价格（小数点后最多输入两位）
};

@protocol TextPropertyDelegate
@required
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, readonly) UITextRange *markedTextRange;

/**
 if implement the should change delegate, the regular string will invalued
 */
@property (nonatomic, copy) NSString *regularStr;
/**
 if implement the should change delegate, the regular string will invalued
 */
@property (nonatomic, assign) ENUM_TEXT_CONTENT_TYPE contentType;

@end

@interface UITextField (Text)
/**
 limit characters, default 0, don't limit if is 0
 */
@property (nonatomic, assign) NSUInteger maxLength;

/**
 regulation type
 */
@property (nonatomic, assign) ENUM_TEXT_CONTENT_TYPE contentType;

/**
 regular string
 */
@property (nonatomic, copy) NSString *regularStr;
@end

#pragma mark text view category
@interface UITextView (Text) <UITextViewDelegate,TextPropertyDelegate>

/**
 limit characters, default 0, don't limit if is 0
 */
@property (nonatomic, assign) NSUInteger maxLength;

/**
 regulation type
 */
@property (nonatomic, assign) ENUM_TEXT_CONTENT_TYPE contentType;

/**
 regular string
 */
@property (nonatomic, copy) NSString *regularStr;
@end
