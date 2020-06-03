//
//  InputAccountView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "InputAccountView.h"
//list view
#import "ListAlertView.h"
#import "UITextField+Text.h"

@interface InputAccountView ()<UITextFieldDelegate>

@end

@implementation InputAccountView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:10 width:0];
    }
    return _viewBG;
}
- (UILabel *)labelInput{
    if (_labelInput == nil) {
        _labelInput = [UILabel new];
        _labelInput.textColor = COLOR_333;
        _labelInput.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        [_labelInput fitTitle:@"添加账本" variable:0];
        
    }
    return _labelInput;
}
- (UIImageView *)ivClose{
    if (_ivClose == nil) {
        _ivClose = [UIImageView new];
        _ivClose.image = [UIImage imageNamed:@"inputClose"];
        _ivClose.widthHeight = XY(W(25),W(25));
    }
    return _ivClose;
}
- (UIView *)viewBorder{
    if (_viewBorder == nil) {
        _viewBorder = [UIView new];
        _viewBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewBorder color:COLOR_LINE numRound:5 width:1];
        _viewBorder.widthHeight = XY(W(275), W(45));
        _viewBorder.userInteractionEnabled = true;
        [_viewBorder addTarget:self action:@selector(downClick)];

    }
    return _viewBorder;
}
- (UILabel *)labelIncome{
    if (_labelIncome == nil) {
        _labelIncome = [UILabel new];
        _labelIncome.font = [UIFont systemFontOfSize:F(15)];
        _labelIncome.textColor = COLOR_333;
        _labelIncome.backgroundColor = [UIColor clearColor];
        [_labelIncome fitTitle:@"收入" variable:0];
    }
    return _labelIncome;
}
- (UIImageView *)ivDown{
    if (_ivDown == nil) {
        _ivDown = [UIImageView new];
        _ivDown.image = [UIImage imageNamed:@"accountDown"];
        _ivDown.widthHeight = XY(W(25),W(25));
    }
    return _ivDown;
}
- (UIView *)viewDesBorder{
    if (_viewDesBorder == nil) {
        _viewDesBorder = [UIView new];
        _viewDesBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewDesBorder color:COLOR_LINE numRound:5 width:1];
        _viewDesBorder.widthHeight = XY(W(275), W(45));
    }
    return _viewDesBorder;
}
- (UITextField *)tfDes{
    if (_tfDes == nil) {
        _tfDes = [UITextField new];
        _tfDes.font = [UIFont systemFontOfSize:F(15)];
        _tfDes.textAlignment = NSTextAlignmentLeft;
        _tfDes.textColor = COLOR_333;
        _tfDes.borderStyle = UITextBorderStyleNone;
        _tfDes.backgroundColor = [UIColor clearColor];
        _tfDes.delegate = self;
        _tfDes.placeholder = @"输入费用说明";

    }
    return _tfDes;
}
- (UIView *)viewPriceBorder{
    if (_viewPriceBorder == nil) {
        _viewPriceBorder = [UIView new];
        _viewPriceBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewPriceBorder color:COLOR_LINE numRound:5 width:1];
        _viewPriceBorder.widthHeight = XY(W(275), W(45));
    }
    return _viewPriceBorder;
}
- (UITextField *)tfPrice{
    if (_tfPrice == nil) {
        _tfPrice = [UITextField new];
        _tfPrice.font = [UIFont systemFontOfSize:F(15)];
        _tfPrice.textAlignment = NSTextAlignmentLeft;
        _tfPrice.textColor = COLOR_333;
        _tfPrice.borderStyle = UITextBorderStyleNone;
        _tfPrice.backgroundColor = [UIColor clearColor];
        _tfPrice.placeholder = @"输入金额（元）";
        _tfPrice.delegate = self;
        _tfPrice.contentType = ENUM_TEXT_CONTENT_TYPE_PRICE;
        
    }
    return _tfPrice;
}

-(UIButton *)btnSubmit{
    if (_btnSubmit == nil) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.backgroundColor = [UIColor clearColor];
        _btnSubmit.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSubmit setTitle:@"提交" forState:(UIControlStateNormal)];
        [_btnSubmit setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(btnSubmitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        self.isReceive = true;
        [self addSubView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification  object:nil];

    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.labelInput];
    [self.viewBG addSubview:self.ivClose];
    [self.viewBG addSubview:self.labelIncome];
    [self.viewBG addSubview:self.ivDown];
    [self.viewBG addSubview:self.viewBorder];
    [self.viewBG addSubview:self.viewDesBorder];
    [self.viewBG addSubview:self.tfDes];
    [self.viewBG addSubview:self.viewPriceBorder];
    [self.viewBG addSubview:self.tfPrice];
    [self.viewBG addSubview:self.btnSubmit];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.widthHeight = XY(W(315), W(333));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(167)));
    
    self.labelInput.centerXTop = XY(self.viewBG.width/2.0,W(25));
    
    self.ivClose.rightTop = XY(self.viewBG.width - W(16),W(21));
    [self.viewBG addControlFrame:CGRectInset(self.ivClose.frame, -W(20), -W(20)) belowView:self.ivClose target:self action:@selector(closeClick)];
    
    self.viewBorder.centerXTop = XY(self.viewBG.width/2.0,W(77));
    
    self.ivDown.rightCenterY = XY(self.viewBorder.right - W(15),self.viewBorder.centerY);
    
    self.labelIncome.leftCenterY = XY(self.viewBorder.left + W(15),self.viewBorder.centerY);
    
    self.viewDesBorder.centerXTop =  XY(self.viewBG.width/2.0,W(142));
    self.tfDes.widthHeight = XY(self.viewDesBorder.width - W(30),self.viewDesBorder.height);
    self.tfDes.leftCenterY = XY(self.viewBorder.left + W(15),self.viewDesBorder.centerY);

    self.viewPriceBorder.centerXTop =  XY(self.viewBG.width/2.0,W(207));
    self.tfPrice.widthHeight = XY(self.viewPriceBorder.width - W(30),self.viewPriceBorder.height);
    self.tfPrice.leftCenterY = XY(self.viewPriceBorder.left + W(15),self.viewPriceBorder.centerY);


    [self.viewBG addLineFrame:CGRectMake(0, self.viewBG.height - W(55), self.viewBG.width, 1)];
    
    self.btnSubmit.widthHeight = XY(self.viewBG.width,W(55));
    self.btnSubmit.centerXBottom = XY(self.viewBG.width/2.0,self.viewBG.height);
}
#pragma mark keyboard
- (void)keyboardShow:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewBG.top = MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(107));
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewBG.top = MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(167));
    }];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}

#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark click
- (void)closeClick{
    [GlobalMethod endEditing];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show{
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}
- (void)downClick{
    [GlobalMethod endEditing];
    ListAlertView * listNew = [ListAlertView new];
    [listNew showWithPoint:[self.viewBG convertPoint:CGPointMake(self.viewBorder.left, self.viewBorder.bottom) toView:[UIApplication sharedApplication].keyWindow]  width:self.viewBorder.width ary:@[@"收入",@"支出"]];
    WEAKSELF
    listNew.blockSelected = ^(NSInteger index) {
       weakSelf.isReceive = index == 0;
        [weakSelf.labelIncome fitTitle:weakSelf.isReceive?@"收入":@"支出" variable:0];
    };
}
- (void)btnSubmitClick{
    if (self.blockComplete) {
        self.blockComplete(self.tfDes.text,self.tfPrice.text,self.isReceive);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
@end
