//
//  InputCodeVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "InputCodeVC.h"
//request


//
#import "InputPwdVC.h"
//request
#import "RequestDriver2.h"
#import "AuthOneVC.h"

@interface InputCodeVC ()
@property (nonatomic, strong) UILabel *labelCode;
@property (nonatomic, strong) UILabel *labelSend;
@property (nonatomic, strong) UILabel *labelPhone;
@property (nonatomic, strong) UILabel *labelSix;
@property (nonatomic, strong) UILabel *labelResend;
@property (nonatomic, strong) UIControl *controlResendCode;
@property (nonatomic, strong) CodeView *codeView;


@end

@implementation InputCodeVC

#pragma mark lazy init
- (UILabel *)labelCode{
    if (_labelCode == nil) {
        _labelCode = [UILabel new];
        _labelCode.textColor = [UIColor blackColor];
        _labelCode.font =  [UIFont systemFontOfSize:F(25)];
        [_labelCode fitTitle:@"输入短信验证码" variable:0];
        _labelCode.leftTop = XY(W(30), NAVIGATIONBAR_HEIGHT+ W(35));
    }
    return _labelCode;
}
- (UILabel *)labelSend{
    if (_labelSend == nil) {
        _labelSend = [UILabel new];
        _labelSend.textColor = COLOR_666;
        _labelSend.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelSend fitTitle:[NSString stringWithFormat:@"验证码已发送至%@",self.strPhone]  variable:0];
        _labelSend.leftTop = XY(W(30), self.labelCode.bottom + W(20));
    }
    return _labelSend;
}


- (UILabel *)labelResend{
    if (_labelResend == nil) {
        _labelResend = [UILabel new];
        _labelResend.textColor = COLOR_666;
        _labelResend.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelResend fitTitle:@"重新获取" variable:0];
        _labelResend.rightCenterY = XY(W(30), self.codeView.bottom + W(40));
    }
    return _labelResend;
}
- (CodeView *)codeView{
    if (!_codeView) {
        _codeView = [CodeView new];
        _codeView.leftTop = XY(0, self.labelSend.bottom + W(68));
        WEAKSELF
        _codeView.blockComplete = ^(NSString *code) {
            switch (weakSelf.typeFrom) {
                case ENUM_CODE_LOGIN:
                {
                    [weakSelf requestLogin:code];
                }
                    break;
                case ENUM_CODE_PWD:
                {
                    [weakSelf requestMatchCode:code];
                   
                }
                    break;
                default:
                    break;
            }
            
        };
    }
    return _codeView;
}
- (UIControl *)controlResendCode{
    if (!_controlResendCode) {
        _controlResendCode = [UIControl new];
        _controlResendCode.backgroundColor = [UIColor clearColor];
        [_controlResendCode addTarget:self action:@selector(requestSend) forControlEvents:UIControlEventTouchUpInside];
        _controlResendCode.widthHeight = XY(W(350), W(35));
        _controlResendCode.center = self.labelResend.center;
    }
    return _controlResendCode;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.labelCode];
    [self.view addSubview:self.labelSend];
//    [self.view addSubview:self.labelPhone];
//    [self.view addSubview:self.labelSix];
    [self.view addSubview:self.labelResend];
    [self.view addSubview:self.controlResendCode];
    [self.view addSubview:self.codeView];
    self.viewBG.backgroundColor = [UIColor clearColor];
    
    [self.codeView.tf becomeFirstResponder];
    [self timerStart];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
    nav.line.hidden = true;
    [self.view addSubview:nav];
}

#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        self.numTime = 60;
        [self timerRun];
    }
}

- (void)timerRun{
    //每秒的动作
    if (_numTime <=0) {
        //刷新按钮 开始
        [self timerStop];
        [self.labelResend fitTitle:@"重新获取" variable:0];
        self.labelResend.textColor = COLOR_BLUE;
        self.controlResendCode.userInteractionEnabled = true;
        self.labelResend.left =  W(30);
        return;
    }
    _numTime --;
    [self.labelResend fitTitle:[NSString stringWithFormat:@"%.lf秒后重新获取",_numTime] variable:0];
    self.labelResend.textColor = [UIColor colorWithHexString:@"#9EBAEB"];
    self.labelResend.left =  W(30);
    self.controlResendCode.userInteractionEnabled = false;
}

- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}

#pragma mark request
- (void)requestSend{
    [RequestApi requestSmsForgetPwdWithApp:REQUEST_APP account:self.strPhone userType:1 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self timerStart];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
  
}
- (void)requestLogin:(NSString *)code{
    static BOOL isRequest = false;
    if (isRequest) {
        return;
    }else{
        isRequest = true;
    [RequestApi requestLoginWithAppid:@"1" clientId:@"1" phone:self.strPhone code:code
 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        isRequest = false;
        if ([GlobalData sharedInstance].GB_UserModel.isUser1 == 1 && [GlobalData sharedInstance].GB_UserModel.isVehicle == 0 && [GlobalData sharedInstance].GB_UserModel.user1Auth == 1) {
            [GB_Nav pushVCName:@"TransferCarListVC" animated:true];
        }else{
            [GB_Nav popToRootViewControllerAnimated:true];
        }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            isRequest = false;
            [self.codeView clearCode];

        }];
    }
}
- (void)requestMatchCode:(NSString *)code{
    NSLog(@"sld code %@",code);
    NSString * strPhone = [self.strPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    static BOOL isRequest = false;
    if (isRequest) {
        return;
    }else{
        isRequest = true;
        [RequestApi requestMatchCodeAccount:strPhone code:code delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            isRequest = false;
            InputPwdVC * inputPwdVC = [ InputPwdVC new];
            inputPwdVC.strPhone = self.strPhone;
            inputPwdVC.code = code;
            [GB_Nav pushViewController:inputPwdVC animated:true];

                
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                isRequest = false;
                [self.codeView clearCode];

            }];
    }
   
   
}
@end



@implementation CodeView
#pragma mark 懒加载
- (UITextField *)tf{
    if (!_tf) {
        _tf = [UITextField new];
        _tf.delegate = self;
        _tf.keyboardType = UIKeyboardTypeNumberPad;
        _tf.backgroundColor = [UIColor clearColor];
        _tf.textColor = [UIColor clearColor];
        _tf.height = 0;
        [_tf addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    }
    return _tf;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
    [self addSubview:self.tf];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat left = W(30);
    CGFloat width = W(40);
    for (int i = 0; i<6; i++) {
       
        
        UILabel * labelShow = [[UILabel alloc]initWithFrame:CGRectMake(left, 0, width, width)];
        labelShow.backgroundColor = [UIColor clearColor];
        labelShow.textColor = COLOR_333;
        labelShow.font = [UIFont systemFontOfSize:F(30) weight:UIFontWeightBold];
        labelShow.tag = 20+i;
        labelShow.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelShow];
        
        UIView * viewLine = [UIView new];
        viewLine.widthHeight = XY(W(40), W(2));
        viewLine.backgroundColor = [UIColor colorWithHexString:@"#D9D9D9"];
        viewLine.tag = 10+i;
        viewLine.centerXBottom = XY(labelShow.centerX, labelShow.bottom+ W(20));
        [self addSubview:viewLine];
        
        left = viewLine.right+W(15);
        self.height = viewLine.bottom;
    }
    
}

#pragma mark text change
- (void)textChange{
    if (self.tf.text.length>6) {
        self.tf.text = [self.tf.text substringToIndex:6];
    }
    NSString * str = self.tf.text;
    for (int i = 0; i<6; i++) {
        UILabel * label = [self viewWithTag:20+i];
        if (str.length >= i+1) {
            NSString * strCharacter = [str substringWithRange:NSMakeRange(i, 1)];
            label.text = strCharacter;
        }else{
            label.text = @"";
        }
//        UIView * viewLine = [self viewWithTag:10+i];
//        [GlobalMethod setRoundView:viewLine color:str.length >= i+1?COLOR_BLUE:COLOR_LINE numRound:5 width:1];
    }
    if (self.tf.text.length >=6 && self.blockComplete) {
        self.blockComplete([self.tf.text substringToIndex:6]);
    }
}
- (void)clearCode{
    self.tf.text = @"";
    [self textChange];
}

- (void)click{
    [self.tf becomeFirstResponder];
}
@end
