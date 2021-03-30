//
//  RechargeInputView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeInputView : UIView
@property (nonatomic, strong) void (^blockConfirm)(double ,double );

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;


@end

@interface RechargeCodeView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) void (^blockComplete)(NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)clearCode;

@end
