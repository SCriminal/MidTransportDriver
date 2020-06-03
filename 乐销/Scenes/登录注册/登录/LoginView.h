//
//  LoginView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginBtnView : UIView
//属性
@property (strong, nonatomic) UIButton *btnLogin;
@property (strong, nonatomic) UILabel *labelCode;
@property (strong, nonatomic) UILabel *labelForget;
@property (strong, nonatomic) UILabel *labelFastLogin;
@property (nonatomic, strong) void (^blockMainClick)();
@property (nonatomic, strong) void (^blockSwitchClick)();
@property (nonatomic, strong) void (^blockForgetClick)();
@property (nonatomic, strong) void (^blockFastLoginClick)();



#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end



@interface LoginAuthorityView : UIView



@end


