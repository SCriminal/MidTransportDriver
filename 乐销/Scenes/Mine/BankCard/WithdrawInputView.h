//
//  WithdrawInputView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/9.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawInputView : UIView
@property (nonatomic, strong) void (^blockConfirm)(double price);
@property (nonatomic, assign) int amtNum;
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface WithdrawCodeView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) void (^blockComplete)(NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)clearCode;

@end
