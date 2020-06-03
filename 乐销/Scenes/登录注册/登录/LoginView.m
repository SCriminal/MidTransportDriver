//
//  LoginView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "LoginView.h"
#import "WebVC.h"


@implementation LoginBtnView
#pragma mark 懒加载
-(UIButton *)btnLogin{
    if (_btnLogin == nil) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.tag = 1;
        [_btnLogin addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        _btnLogin.backgroundColor = COLOR_BLUE;
        _btnLogin.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [GlobalMethod setRoundView:_btnLogin color:[UIColor clearColor] numRound:5 width:0];
        [_btnLogin setTitle:@"登录" forState:(UIControlStateNormal)];
        _btnLogin.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnLogin;
}
- (UILabel *)labelCode{
    if (_labelCode == nil) {
        _labelCode = [UILabel new];
        _labelCode.textColor = COLOR_666;
        _labelCode.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelCode fitTitle:@"注册/验证码登录" variable:0];
    }
    return _labelCode;
}
- (UILabel *)labelForget{
    if (_labelForget == nil) {
        _labelForget = [UILabel new];
        _labelForget.textColor = COLOR_666;
        _labelForget.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [_labelForget fitTitle:@"忘记密码" variable:0];
    }
    return _labelForget;
}
- (UILabel *)labelFastLogin{
    if (_labelFastLogin == nil) {
        _labelFastLogin = [UILabel new];
        _labelFastLogin.textColor = COLOR_BLUE;
        _labelFastLogin.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelFastLogin fitTitle:@"一键快捷登录" variable:0];
        _labelFastLogin.hidden = true;
    }
    return _labelFastLogin;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.btnLogin];
    [self addSubview:self.labelCode];
    [self addSubview:self.labelForget];
    [self addSubview:self.labelFastLogin];
    //初始化页面
    [self resetViewWithModel:nil];
    [self addControlFrame:CGRectInset(self.labelCode.frame, -W(10), -W(10)) belowView:self.labelCode target:self action:@selector(codeClick)];
    [self addControlFrame:CGRectInset(self.labelForget.frame, -W(10), -W(10)) belowView:self.labelForget target:self action:@selector(forgetClick)];
    [self addControlFrame:CGRectInset(self.labelFastLogin.frame, -W(10), -W(10)) belowView:self.labelFastLogin target:self action:@selector(fastLoginClick)];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnLogin.widthHeight = XY(SCREEN_WIDTH - W(50), W(45));
    self.btnLogin.centerXTop = XY(SCREEN_WIDTH/2.0,0);
    
    self.labelCode.leftTop = XY(self.btnLogin.left,self.btnLogin.bottom+W(22));
    
    self.labelForget.rightTop = XY(self.btnLogin.right,self.labelCode.top);
    
    self.labelFastLogin.centerXTop = XY(self.btnLogin.centerX,self.labelForget.bottom+W(65));
    
    //设置总高度
    self.height = self.labelFastLogin.bottom;
}
#pragma mark 点击事件
- (void)loginClick{
    if (self.blockMainClick) {
        self.blockMainClick();
    }
}
- (void)codeClick{
    if (self.blockSwitchClick) {
        self.blockSwitchClick();
    }
}
- (void)forgetClick{
    if (self.blockForgetClick) {
        self.blockForgetClick();
    }
}
- (void)fastLoginClick{
    if (self.labelFastLogin.hidden == true) {
        return;
    }
    if (self.blockFastLoginClick) {
        self.blockFastLoginClick();
    }
}
@end



@implementation LoginAuthorityView


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    CGFloat left = 0;
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_333;
        [label fitTitle:@"已阅并同意" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
    }
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_666;
        [label fitTitle:@"《用户协议》" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
        
        [self addControlFrame:CGRectInset(label.frame, 0, -W(20)) belowView:label target:self action:@selector(userContractClick)];
    }
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_333;
        [label fitTitle:@"&" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
    }
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_666;
        [label fitTitle:@"《隐私政策》" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
        [self addControlFrame:CGRectInset(label.frame, 0, -W(20)) belowView:label target:self action:@selector(privacyContractClick)];

        self.widthHeight = XY(label.right, label.height);
    }
}

#pragma mark click
- (void)userContractClick{
    WebVC * vc = [WebVC new];
    vc.navTitle = @"用户协议";
    vc.url = @"https://www.zhongcheyun.cn/user/agreement";
    [GB_Nav pushViewController:vc animated:true];
}
- (void)privacyContractClick{
    WebVC * vc = [WebVC new];
    vc.navTitle = @"隐私政策";
    vc.url = @"https://www.zhongcheyun.cn/privacy";
    [GB_Nav pushViewController:vc animated:true];
}

@end
