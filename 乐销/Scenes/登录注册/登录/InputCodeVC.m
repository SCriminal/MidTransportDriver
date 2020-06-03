//
//  InputCodeVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "InputCodeVC.h"
//request
#import "RequestApi+UserApi.h"
#import "RequestApi+UserAuth.h"
//
#import "InputPwdVC.h"

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
        [_labelCode fitTitle:@"请输入短信验证码" variable:0];
        _labelCode.leftTop = XY(W(25), NAVIGATIONBAR_HEIGHT+ W(35));
    }
    return _labelCode;
}
- (UILabel *)labelSend{
    if (_labelSend == nil) {
        _labelSend = [UILabel new];
        _labelSend.textColor = COLOR_666;
        _labelSend.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelSend fitTitle:@"验证码已发送到您的手机" variable:0];
        _labelSend.leftTop = XY(W(25), self.labelCode.bottom + W(20));
    }
    return _labelSend;
}
- (UILabel *)labelPhone{
    if (_labelPhone == nil) {
        _labelPhone = [UILabel new];
        _labelPhone.textColor = COLOR_666;
        _labelPhone.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelPhone fitTitle:UnPackStr(self.strPhone) variable:0];
        _labelPhone.leftTop = XY(W(25), self.labelSend.bottom + W(12));
    }
    return _labelPhone;
}
- (UILabel *)labelSix{
    if (_labelSix == nil) {
        _labelSix = [UILabel new];
        _labelSix.textColor = COLOR_666;
        _labelSix.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelSix fitTitle:@"6位数字验证码" variable:0];
        _labelSix.leftTop = XY(W(25), self.labelPhone.bottom + W(50));
    }
    return _labelSix;
}
- (UILabel *)labelResend{
    if (_labelResend == nil) {
        _labelResend = [UILabel new];
        _labelResend.textColor = COLOR_666;
        _labelResend.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelResend fitTitle:@"重新获取" variable:0];
        _labelResend.rightCenterY = XY(SCREEN_WIDTH - W(25), self.labelSix.centerY);
    }
    return _labelResend;
}
- (CodeView *)codeView{
    if (!_codeView) {
        _codeView = [CodeView new];
        _codeView.leftTop = XY(0, self.labelSix.bottom + W(25));
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
        _controlResendCode.frame = CGRectInset(self.labelResend.frame, -W(20), -W(10));
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
    [self.view addSubview:self.labelPhone];
    [self.view addSubview:self.labelSix];
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
        [self.labelResend fitTitle:@"重新发送" variable:0];
        self.labelResend.textColor = COLOR_BLUE;
        self.controlResendCode.userInteractionEnabled = true;
        self.labelResend.right = SCREEN_WIDTH - W(25);
        return;
    }
    _numTime --;
    [self.labelResend fitTitle:[NSString stringWithFormat:@"%.lf秒以后重新获取",_numTime] variable:0];
    self.labelResend.textColor = COLOR_666;
    self.labelResend.right = SCREEN_WIDTH - W(25);
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
    [RequestApi requestFetchCodeWithApp:@"" cellPhone:self.strPhone smsType:@"3" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self timerStart];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestLogin:(NSString *)code{
    [RequestApi requestLoginCodeWithApp:@"" scene:@"" cellPhone:self.strPhone code:code delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [ModelBaseInfo jumpToAuthorityStateVCSuccessBlock:^{
            [GB_Nav popToRootViewControllerAnimated:true];
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        [self.codeView clearCode];
    }];
}
- (void)requestMatchCode:(NSString *)code{
    NSString * strPhone = [self.strPhone stringByReplacingOccurrencesOfString:@" " withString:@""];

    [RequestApi requestMatchCodeWithApp:@"" phone:strPhone code:code  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if ([response isKindOfClass:[NSDictionary class]]&&[response boolValueForKey:@"status"]) {
            InputPwdVC * inputPwdVC = [ InputPwdVC new];
            inputPwdVC.strPhone = self.strPhone;
            inputPwdVC.code = code;
            [GB_Nav pushViewController:inputPwdVC animated:true];
        }else{
            [self.codeView clearCode];
            [GlobalMethod showAlert:@"验证码输入错误"];
        }
      

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
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
    CGFloat left = W(25);
    CGFloat width = (SCREEN_WIDTH - W(50) - 5*W(5))/6.0;
    for (int i = 0; i<6; i++) {
        UIView * viewLine = [[UIView alloc]initWithFrame:CGRectMake(left, 0, width, width)];
        [GlobalMethod setRoundView:viewLine color:COLOR_LINE numRound:5 width:1];
        viewLine.tag = 10+i;
        [self addSubview:viewLine];
        left = viewLine.right+W(5);
        
        UILabel * labelShow = [[UILabel alloc]initWithFrame:viewLine.frame];
        labelShow.backgroundColor = [UIColor clearColor];
        labelShow.textColor = COLOR_BLUE;
        labelShow.font = [UIFont systemFontOfSize:F(25) weight:UIFontWeightBold];
        labelShow.tag = 20+i;
        labelShow.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelShow];
    }
    //设置总高度
    self.height = width;
}

#pragma mark text change
- (void)textChange{
    NSString * str = self.tf.text;
    for (int i = 0; i<6; i++) {
        UILabel * label = [self viewWithTag:20+i];
        if (str.length >= i+1) {
            NSString * strCharacter = [str substringWithRange:NSMakeRange(i, 1)];
            label.text = strCharacter;
        }else{
            label.text = @"";
        }
        UIView * viewLine = [self viewWithTag:10+i];
        [GlobalMethod setRoundView:viewLine color:str.length >= i+1?COLOR_BLUE:COLOR_LINE numRound:5 width:1];
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
