//
//  LoginTextField.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextField : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *labelPlaceHolder;

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title placeHolder:(NSString *)placeHolderString;

@end
