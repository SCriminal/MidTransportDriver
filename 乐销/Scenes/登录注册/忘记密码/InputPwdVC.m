//
//  InputPwdVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/10.
//Copyright © 2019 ping. All rights reserved.
//

#import "InputPwdVC.h"
//tf
#import "LoginTextField.h"
//key board observe
#import "BaseVC+KeyboardObserve.h"
//next code
#import "InputCodeVC.h"
#import "RequestApi+UserAuth.h"

@interface InputPwdVC ()

@property (strong, nonatomic) UILabel *labelInput;
@property (strong, nonatomic) UILabel *labelPwd;
@property (strong, nonatomic) UIButton *btnNext;
@property (nonatomic, strong) LoginTextField *tfPwd;
@property (nonatomic, strong) LoginTextField *tfPwdAgain;

@end

@implementation InputPwdVC

#pragma mark 懒加载
- (UILabel *)labelInput{
    if (_labelInput == nil) {
        _labelInput = [UILabel new];
        _labelInput.textColor = [UIColor blackColor];
        _labelInput.font =  [UIFont systemFontOfSize:F(25) ];
        [_labelInput fitTitle:@"请输入新的密码" variable:0];
        _labelInput.leftTop = XY(W(25), NAVIGATIONBAR_HEIGHT + W(35));
    }
    return _labelInput;
}
- (UILabel *)labelPwd{
    if (_labelPwd == nil) {
        _labelPwd = [UILabel new];
        _labelPwd.textColor = COLOR_666;
        _labelPwd.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelPwd fitTitle:@"修改成功后使用新密码登录" variable:0];
        _labelPwd.leftTop = XY(W(25), self.labelInput.bottom + W(20));
        
    }
    return _labelPwd;
}

- (LoginTextField *)tfPwd{
    if (!_tfPwd) {
        _tfPwd = [LoginTextField new];
        [_tfPwd resetViewWithTitle:@"" placeHolder:@"请输入至少6位密码"];
        _tfPwd.top = self.labelPwd.bottom + W(65);
        _tfPwd.tf.secureTextEntry = true;
    }
    return _tfPwd;
}
- (LoginTextField *)tfPwdAgain{
    if (!_tfPwdAgain) {
        _tfPwdAgain = [LoginTextField new];
        [_tfPwdAgain resetViewWithTitle:@"" placeHolder:@"再次输入新密码"];
        _tfPwdAgain.top = self.tfPwd.bottom + W(30);
        _tfPwdAgain.tf.secureTextEntry = true;
    }
    return _tfPwdAgain;
}
-(UIButton *)btnNext{
    if (_btnNext == nil) {
        _btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnNext addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        _btnNext.backgroundColor = COLOR_BLUE;
        _btnNext.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [GlobalMethod setRoundView:_btnNext color:[UIColor clearColor] numRound:5 width:0];
        [_btnNext setTitle:@"确认修改" forState:(UIControlStateNormal)];
        _btnNext.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
        [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNext.centerXTop = XY(SCREEN_WIDTH/2.0,self.tfPwdAgain.bottom + W(49));
    }
    return _btnNext;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addKeyboardHideGesture];
    [self.view addSubview:^(){
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
        nav.line.hidden = true;
        return nav;
    }()];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    //添加subView
    [self.view addSubview:self.labelInput];
    [self.view addSubview:self.labelPwd];
    [self.view addSubview:self.tfPwd];
    [self.view addSubview:self.tfPwdAgain];
    [self.view addSubview:self.btnNext];
}
#pragma mark 点击事件
- (void)nextClick{
    if (!isStr(self.tfPwd.tf.text)) {
        [GlobalMethod showAlert:@"请输入密码"];
        return;
    }
    if (![self.tfPwd.tf.text isEqualToString:self.tfPwdAgain.tf.text]) {
        [GlobalMethod showAlert:@"两次密码不一致"];
        return;
    }
    [RequestApi requestForgetPwdWithApp:nil account:self.strPhone code:self.code password:self.tfPwd.tf.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if ([GB_Nav hasClass:@"LoginViewController"]) {
            [GB_Nav popToClass:@"LoginViewController"];
        }else{
            [GlobalMethod clearUserInfo];
            [GlobalMethod createRootNav];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    

}

@end
