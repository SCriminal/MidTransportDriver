//
//  ForgetPwdVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "ForgetPwdVC.h"
//tf
#import "LoginTextField.h"
//key board observe
#import "BaseVC+KeyboardObserve.h"
//next code
#import "InputCodeVC.h"
//request
#import "RequestApi+UserAuth.h"
#import "RequestApi+UserApi.h"
@interface ForgetPwdVC ()

@property (strong, nonatomic) UILabel *labelForget;
@property (strong, nonatomic) UILabel *labelPhone;
@property (strong, nonatomic) UIButton *btnNext;
@property (nonatomic, strong) LoginTextField *tfPhone;

@end

@implementation ForgetPwdVC

#pragma mark 懒加载
- (UILabel *)labelForget{
    if (_labelForget == nil) {
        _labelForget = [UILabel new];
        _labelForget.textColor = [UIColor blackColor];
        _labelForget.font =  [UIFont systemFontOfSize:F(25) ];
        [_labelForget fitTitle:@"忘记密码" variable:0];
        _labelForget.leftTop = XY(W(25), NAVIGATIONBAR_HEIGHT + W(35));
    }
    return _labelForget;
}
- (UILabel *)labelPhone{
    if (_labelPhone == nil) {
        _labelPhone = [UILabel new];
        _labelPhone.textColor = COLOR_666;
        _labelPhone.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelPhone fitTitle:@"输入绑定手机号码" variable:0];
        _labelPhone.leftTop = XY(W(25), self.labelForget.bottom + W(20));

    }
    return _labelPhone;
}

- (LoginTextField *)tfPhone{
    if (!_tfPhone) {
        _tfPhone = [LoginTextField new];
        _tfPhone.tf.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
        [_tfPhone resetViewWithTitle:UnPackStr(self.strPhone) placeHolder:@"手机号"];
        _tfPhone.tf.keyboardType = UIKeyboardTypeNumberPad;
        _tfPhone.top = self.labelPhone.bottom + W(65);
    }
    return _tfPhone;
}
-(UIButton *)btnNext{
    if (_btnNext == nil) {
        _btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnNext.tag = 1;
        [_btnNext addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        _btnNext.backgroundColor = COLOR_BLUE;
        _btnNext.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [GlobalMethod setRoundView:_btnNext color:[UIColor clearColor] numRound:5 width:0];
        [_btnNext setTitle:@"下一步" forState:(UIControlStateNormal)];
        _btnNext.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
        [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNext.centerXTop = XY(SCREEN_WIDTH/2.0,self.tfPhone.bottom + W(49));
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
    [self.view addSubview:self.labelForget];
    [self.view addSubview:self.labelPhone];
    [self.view addSubview:self.tfPhone];
    [self.view addSubview:self.btnNext];
}
#pragma mark 点击事件
- (void)nextClick{
    NSString * strPhone = [self.tfPhone.tf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [RequestApi requestFetchCodeWithApp:@"" cellPhone:strPhone smsType:@"2" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        InputCodeVC * codeVC = [InputCodeVC new];
        codeVC.strPhone = strPhone;
        codeVC.typeFrom = ENUM_CODE_PWD;
        [GB_Nav pushViewController:codeVC animated:true];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}

@end
