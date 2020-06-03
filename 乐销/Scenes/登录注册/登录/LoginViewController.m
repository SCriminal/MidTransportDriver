//
//  LoginViewController.m
//中车运
//
//  Created by mengxi on 16/11/18.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "LoginViewController.h"
//key board observe
#import "BaseVC+KeyboardObserve.h"
//tf
#import "LoginTextField.h"
//login view
#import "LoginView.h"
#import "UITextField+Text.h"
//fast login
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
//send code vc
#import "InputCodeVC.h"
//text edit
#import "UITextField+Text.h"
//request
#import "RequestApi+UserAuth.h"
#import "RequestApi+UserApi.h"
//forget vc
#import "ForgetPwdVC.h"

@interface LoginViewController ()
@property (nonatomic, strong) UILabel *labelHello;
@property (nonatomic, strong) UILabel *labelWelcome;
@property (nonatomic, strong) LoginBtnView *btnView;
@property (nonatomic, strong) LoginTextField *tfPhone;
@property (nonatomic, strong) LoginTextField *tfPwd;
@property (nonatomic, strong) LoginAuthorityView *authorityView;
@property (nonatomic, assign) BOOL pwdLogin;
@end

@implementation LoginViewController

#pragma mark lazy init
- (UILabel *)labelHello{
    if (_labelHello == nil) {
        _labelHello = [UILabel new];
        _labelHello.textColor = [UIColor blackColor];
        _labelHello.font =  [UIFont systemFontOfSize:F(25)];
        [_labelHello fitTitle:@"你好，" variable:0];
        _labelHello.leftTop = XY(W(25), STATUSBAR_HEIGHT+ W(75));
    }
    return _labelHello;
}
- (UILabel *)labelWelcome{
    if (_labelWelcome == nil) {
        _labelWelcome = [UILabel new];
        _labelWelcome.textColor = [UIColor blackColor];
        _labelWelcome.font =  [UIFont systemFontOfSize:F(25)];
        [_labelWelcome fitTitle:@"欢迎来到中车运" variable:0];
        _labelWelcome.leftTop = XY(W(25), self.labelHello.bottom + W(20));
    }
    return _labelWelcome;
}
- (LoginTextField *)tfPhone{
    if (!_tfPhone) {
        _tfPhone = [LoginTextField new];
        _tfPhone.tf.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * strValue = [user objectForKey:LOCAL_PHONE];
        [_tfPhone resetViewWithTitle:[self exchangePhone:isStr(strValue)?strValue:@""] placeHolder:@"填写手机号/用户名"];
        _tfPhone.tf.keyboardType = UIKeyboardTypeNumberPad;
        _tfPhone.top = self.labelWelcome.bottom + W(60);
    }
    return _tfPhone;
}
//exchange phone
- (NSString *)exchangePhone:(NSString*)str{
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString * strReturn = [NSMutableString stringWithString:str];
    if (strReturn.length >= 11) {
        [strReturn insertString:@" " atIndex:7];
        [strReturn insertString:@" " atIndex:3];
        return strReturn;
    }
    return str;
}
- (LoginTextField *)tfPwd{
    if (!_tfPwd) {
        _tfPwd = [LoginTextField new];
        _tfPwd.tf.secureTextEntry = true;
        [_tfPwd resetViewWithTitle:@"" placeHolder:@"输入密码"];
        _tfPwd.top = self.tfPhone.bottom + W(30);
    }
    return _tfPwd;
}
- (LoginAuthorityView *)authorityView{
    if (!_authorityView) {
        _authorityView = [LoginAuthorityView new];
        _authorityView.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - iphoneXBottomInterval - W(25));
    }
    return _authorityView;
}
- (LoginBtnView *)btnView{
    if (!_btnView) {
        _btnView = [LoginBtnView new];
        _btnView.top = self.tfPwd.bottom + W(44);
        WEAKSELF
        _btnView.blockMainClick = ^{
            if (weakSelf.pwdLogin) {
                [weakSelf requestWithPwd];
            }else{
                [weakSelf requestSendCode];
            }
        };
        
        _btnView.blockSwitchClick = ^{
            [weakSelf switchPwdLogin];
        };
        _btnView.blockForgetClick = ^{
            ForgetPwdVC * fv = [ForgetPwdVC new];
            fv.strPhone = weakSelf.tfPhone.tf.text;
            [GB_Nav pushViewController:fv animated:true];
        };
        _btnView.blockFastLoginClick = ^{
            [weakSelf quickLoginBtnClick];
        };
    }
    return _btnView;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    self.pwdLogin = true;
    [self.view addKeyboardHideGesture];
    
    [self.view addSubview:^(){
        BaseNavView * nav = [BaseNavView initNavTitle:@"" leftImageName:nil leftImageSize:CGSizeZero leftBlock:^{
            
        } rightImageName:nil rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{

        }];
        nav.line.hidden = true;
        return nav;
    }()];
    
    //background color
    self.viewBG.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    // reset subview
    [self.view addSubview:self.labelHello];
    [self.view addSubview:self.labelWelcome];
    [self.view addSubview:self.tfPhone];
    [self.view addSubview:self.tfPwd];
    [self.view addSubview:self.btnView];
    [self.view addSubview:self.authorityView];
    [CLShanYanSDKManager preGetPhonenumber];
}


#pragma mark request
- (void)requestWithPwd{
    NSString * strPhone = [self.tfPhone.tf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [RequestApi requestLoginPwdWithPassword:self.tfPwd.tf.text account:strPhone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [ModelBaseInfo jumpToAuthorityStateVCSuccessBlock:^{
            [GB_Nav popToRootViewControllerAnimated:true];
        }];
        [GlobalMethod showAlert:@"登录成功"];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestSendCode{
    NSString * strPhone = [self.tfPhone.tf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [RequestApi requestFetchCodeWithApp:@"" cellPhone:strPhone smsType:@"3" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        InputCodeVC * codeVC = [InputCodeVC new];
        codeVC.strPhone = strPhone;
        [GB_Nav pushViewController:codeVC animated:true];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}
#pragma mark login
- (void)switchPwdLogin{
    self.pwdLogin = !self.pwdLogin;
    [self.btnView.btnLogin setTitle:self.pwdLogin?@"登录":@"下一步" forState:UIControlStateNormal];
    [self.btnView.labelCode fitTitle:self.pwdLogin?@"注册/验证码登录":@"账号密码登录" variable:0];
    [UIView animateWithDuration:0.3 animations:^{
        self.tfPwd.hidden = !self.pwdLogin;
        self.btnView.top = (self.pwdLogin?self.tfPwd.bottom:self.tfPhone.bottom)+ W(44);
    } completion:^(BOOL finished) {
    }];
}
#pragma mark fastlogin
// 快捷登录
- (void)quickLoginBtnClick {
    
    //耗时开始计时
    CFAbsoluteTime startButtonClick   = CFAbsoluteTimeGetCurrent();
    
    //    [sender setEnabled:NO];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [sender setEnabled:YES];
    //    });
    
    //电信定制界面
    CLCTCCUIConfigure * ctccUIConfigure = [CLCTCCUIConfigure new];
    ctccUIConfigure.viewController = self;
    
    //移动定制界面
    CLCMCCUIConfigure * cmccUIConfigure = [CLCMCCUIConfigure new];
    cmccUIConfigure.viewController = self;
    
    //联通定制界面
    CLCUCCUIConfigure * cuccUIConfigure = [CLCUCCUIConfigure new];
    cuccUIConfigure.viewController = self;
    
    //    [SVProgressHUD setContainerView:self.view];
    //    [SVProgressHUD show];
    
    [CLShanYanSDKManager quickAuthLoginWithConfigureCTCC:ctccUIConfigure CMCC:cmccUIConfigure CUCC:cuccUIConfigure timeOut:4 complete:^(CLCompleteResult * _Nonnull completeResult) {
        
        //        [SVProgressHUD dismiss];
        
        if (completeResult.error) {
            
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            
            if (completeResult.code == 1011){
                //用户取消登录（点返回）
                //处理建议：如无特殊需求可不做处理，仅作为交互状态回调，此时已经回到当前用户自己的页面
                //                [SVProgressHUD showInfoWithStatus: @"用户取消免密登录"];
                [GlobalMethod mainQueueBlock:^{
                    [GlobalMethod showAlert:@"用户取消免密登录"];
                }];
            }else{
                //处理建议：其他错误代码表示闪验通道无法继续，可以统一走开发者自己的其他登录方式，也可以对不同的错误单独处理
                //1003    一键登录获取token失败
                //1008    未开启移动网络
                //1009    未检测到sim卡
                //其他     其他错误//
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    LoginResultController *vc = [LoginResultController new];
                    //                    vc.error = completeResult.error;
                    //                    [self.navigationController pushViewController:vc animated:YES];
                    //                    NSLog(@"%@",completeResult.error);
                    [GlobalMethod showAlert:@"一键登录失败"];
                    
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"quickAuthLogin Success:%@",completeResult.data);
                [GlobalMethod showAlert:@"登录成功"];
                //                LoginResultController *vc = [LoginResultController new];
                //                vc.completeResultData = completeResult.data;
                //                vc.timesStart = startButtonClick;
                //                if(self.navigationController){
                //                    [self.navigationController pushViewController:vc animated:YES];
                //                } else {
                //                    [self presentViewController:vc animated:YES completion:^{
                //
                //                    }];
                //                }
            });
        }
    }];
}
//授权页 点击自定义控件绑定的方法
-(void)otherLoginWayBtnCliced:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        //建议使用授权页面配置对象传入的viewcontroller 调 dismiss
        if (self.navigationController.viewControllers.lastObject.navigationController) {
            [self.navigationController.viewControllers.lastObject dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
            // 在这里加一个这个样式的循环
            while (topRootViewController.presentedViewController) {
                // 这里固定写法
                topRootViewController = topRootViewController.presentedViewController;
            }
            // 然后再进行present操作
            [topRootViewController dismissViewControllerAnimated:YES completion:nil];
        }
    });
    [GlobalMethod showAlert:@"用户使用其他方式进行注册登录"];
}
#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end
