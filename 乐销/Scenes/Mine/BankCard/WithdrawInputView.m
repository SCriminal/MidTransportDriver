//
//  WithdrawInputView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/9.
//Copyright © 2020 ping. All rights reserved.
//

#import "WithdrawInputView.h"
#import "UITextField+Text.h"

@interface WithdrawInputView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tfPrice;
@property (nonatomic, strong) UIView *viewWhitBG;

@end

@implementation WithdrawInputView

- (UITextField *)tfPrice{
    if (_tfPrice == nil) {
        _tfPrice = [UITextField new];
        _tfPrice.font = [UIFont systemFontOfSize:F(35) weight:UIFontWeightMedium];
        _tfPrice.textAlignment = NSTextAlignmentLeft;
        _tfPrice.textColor = COLOR_333;
        _tfPrice.borderStyle = UITextBorderStyleNone;
        _tfPrice.backgroundColor = [UIColor clearColor];
//        _tfPrice.delegate = self;
        _tfPrice.contentType = ENUM_TEXT_CONTENT_TYPE_PRICE;
//        _tfPrice.placeholder = @"";
    }
    return _tfPrice;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    {
        UIView * _viewBlackAlpha = [UIView new];
         _viewBlackAlpha.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
         _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_viewBlackAlpha];
    }
    
      UIView * viewWhiteBG = [UIView new];
    self.viewWhitBG = viewWhiteBG;
          viewWhiteBG.backgroundColor = [UIColor whiteColor];
          viewWhiteBG.widthHeight = XY(SCREEN_WIDTH, W(247)+iphoneXBottomInterval);
          viewWhiteBG.bottom = SCREEN_HEIGHT;
          [viewWhiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:8 lineWidth:0 lineColor:[UIColor clearColor]];
          [self addSubview:viewWhiteBG];
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"提现" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(20), W(20));
        [viewWhiteBG addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(35) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"¥" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(20), W(67));
        [viewWhiteBG addSubview:l];
        [viewWhiteBG addSubview:self.tfPrice];
        self.tfPrice.widthHeight = XY(W(200), [UIFont fetchHeight:F(35)]);
        self.tfPrice.leftCenterY = XY(l.right + W(11), l.centerY);
        
        [viewWhiteBG addControlFrame:CGRectMake(0, W(60), W(220), W(60)) belowView:self.tfPrice target:self action:@selector(priceClick)];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_BLUE;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"全部余额" variable:SCREEN_WIDTH - W(30)];
        l.rightCenterY = XY(SCREEN_WIDTH - W(20), self.tfPrice.centerY);
        [viewWhiteBG addSubview:l];

        [viewWhiteBG addControlFrame:CGRectInset(l.frame, -W(20), -W(20)) belowView:l target:self action:@selector(yueClick)];
    }
    {
        [viewWhiteBG addLineFrame:CGRectMake(W(20), W(114), SCREEN_WIDTH - W(40), 1)];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"说明：提现成功后，1-2个小时到账！" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(20), W(146));
        [viewWhiteBG addSubview:l];
    }
    
   
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(335), W(39));
        btn.backgroundColor = COLOR_ORANGE;
        [btn setTitle:@"确认提现" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.rightTop = XY(SCREEN_WIDTH - W(20), W(178));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    

    
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;
        [self addTarget:self action:@selector(endClick)];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification  object:nil];

    }
    return self;
}
- (void)keyboardShow:(NSNotification *)notice{
    CGRect frame = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = frame.origin.y;
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = SCREEN_HEIGHT;
    }];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)priceClick{
    [self.tfPrice becomeFirstResponder];
}
- (void)endClick{
    if ([self.tfPrice isFirstResponder]) {
            [GlobalMethod endEditing];

    }else{
        [self btnDismissClick];
    }
}
- (void)btnDismissClick{
    [GlobalMethod endEditing];
    [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}
- (void)btnConfirmClick{
    if (self.blockConfirm) {
        self.blockConfirm(self.tfPrice.text.doubleValue);
    }
}
- (void)yueClick{
    self.tfPrice.text = [NSNumber bigDecimal:self.amtNum divide:100.0];
}
@end


@implementation WithdrawCodeView
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
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeAllSubViews];//移除线
    [self addSubview:self.tf];

    CGFloat top = W(215);
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(315), W(237));
        view.centerXTop = XY(SCREEN_WIDTH/2.0, top);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
        [self addSubview:view];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = COLOR_333;
        [l fitTitle:@"请输入支付验证码" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(22));
        [self addSubview:l];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"inputClose"];
        iv.widthHeight = XY(W(25),W(25));
        iv.rightTop = XY(SCREEN_WIDTH- W(45),top + W(19));
        [self addSubview:iv];

        [self addControlFrame:CGRectInset(iv.frame, -W(40), -W(40)) belowView:iv target:self action:@selector(closeClick)];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        NSString * phone = [GlobalData sharedInstance].GB_UserModel.cellPhone.length>4?[GlobalData sharedInstance].GB_UserModel.cellPhone:@"*******";
        [l fitTitle:[NSString stringWithFormat:@"已向%@****%@发送一条短信", [phone substringToIndex:3],[phone substringFromIndex:phone.length - 4]] variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(54));
        [self addSubview:l];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"withdraw_line"];
        iv.widthHeight = XY(W(272),W(44));
        iv.centerXTop = XY(SCREEN_WIDTH/2.0,top + W(106));
        [iv addTarget:self action:@selector(click)];
        [self addSubview:iv];
    }
    //刷新view
    CGFloat left = W(52);
    CGFloat width = (W(272))/6.0;
    for (int i = 0; i<6; i++) {
        UILabel * labelShow = [[UILabel alloc]initWithFrame:CGRectMake(left, top + W(106), width, W(44))];
        labelShow.backgroundColor = [UIColor clearColor];
        labelShow.textColor = COLOR_333;
        labelShow.font = [UIFont systemFontOfSize:F(24) weight:UIFontWeightBold];
        labelShow.tag = 20+i;
        labelShow.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelShow];
        left = labelShow.right;
    }
    [self addLineFrame:CGRectMake(W(30), top + W(180), SCREEN_WIDTH - W(60), 1)];
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_BLUE;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"支付确认" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(202)+top);
        [self addSubview:l];
        
        [self addControlFrame:CGRectMake(W(30), top + W(180), SCREEN_WIDTH - W(60), W(55)) belowView:l target:self action:@selector(btnConfirm)];
    }
    [self click];
}

#pragma mark text change
- (void)textChange{
    if (self.tf.text.length >6 ) {
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
    }
    
}
- (void)clearCode{
    self.tf.text = @"";
    [self textChange];
}
- (void)click{
    [self.tf becomeFirstResponder];
}
- (void)closeClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)btnConfirm{
    if (self.blockComplete) {
        self.blockComplete(self.tf.text);
    }
    [self closeClick];
}
@end
