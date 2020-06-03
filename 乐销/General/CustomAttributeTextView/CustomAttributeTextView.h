//
//  CustomAttributeTextView.h
//  乐销
//
//  Created by 隋林栋 on 2017/10/31.
//Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//yykit
#import  <YYKit/YYKit.h>
//model
#import "ModelCell_TextView.h"

@interface CustomAttributeTextView : UIView
@property (nonatomic, strong) ModelCell_TextView *modelTextView;
@property (nonatomic, readonly) NSString *requestContentStr;
@property (nonatomic, readonly) NSString *requestCropStr;
@property (nonatomic, readonly) NSString *requestProductStr;
@property (nonatomic, readonly) NSString *requestCustomerStr;
@property (nonatomic, assign) CGFloat heightMinimum;//textview height minimum,default W(100)
@property (nonatomic, strong) YYTextView *textView;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCell_TextView *)model;

@end
