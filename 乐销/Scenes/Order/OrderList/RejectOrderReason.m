//
//  ScheduleConfirmView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "RejectOrderReason.h"

@interface RejectOrderReason ()<UITextViewDelegate>
@end

@implementation RejectOrderReason

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:10 width:0];
    }
    return _viewBG;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        [_labelTitle fitTitle:@"拒单" variable:0];
        
    }
    return _labelTitle;
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
        _viewBorder.widthHeight = XY(W(275), W(150));
        _viewBorder.userInteractionEnabled = true;
    }
    return _viewBorder;
}

- (PlaceHolderTextView *)tfReason{
    if (_tfReason == nil) {
        _tfReason = [PlaceHolderTextView new];
        _tfReason.font = [UIFont systemFontOfSize:F(15)];
        _tfReason.textAlignment = NSTextAlignmentLeft;
        _tfReason.textColor = COLOR_333;

        _tfReason.backgroundColor = [UIColor clearColor];
        _tfReason.delegate = self;
        _tfReason.placeHolder.fontNum = F(15);
        _tfReason.placeHolder.textColor = COLOR_999;
        [_tfReason.placeHolder fitTitle:@"请输入拒单理由" variable:W(238)];
    }
    return _tfReason;
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
        [self addSubView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification  object:nil];
        
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.labelTitle];
    [self.viewBG addSubview:self.ivClose];
    [self.viewBG addSubview:self.viewBorder];
    [self.viewBG addSubview:self.tfReason];
    [self.viewBG addSubview:self.btnSubmit];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.widthHeight = XY(W(315), W(308));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(167)));
    
    self.labelTitle.centerXTop = XY(self.viewBG.width/2.0,W(25));
    
    self.ivClose.rightTop = XY(self.viewBG.width - W(16),W(21));
    [self.viewBG addControlFrame:CGRectInset(self.ivClose.frame, -W(20), -W(20)) belowView:self.ivClose target:self action:@selector(closeClick)];
    
    self.viewBorder.centerXTop = XY(self.viewBG.width/2.0,W(77));
    
    
    self.tfReason.widthHeight = XY(self.viewBorder.width - W(30),self.viewBorder.height-W(30));
    self.tfReason.leftCenterY = XY(self.viewBorder.left + W(15),self.viewBorder.centerY);
    
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


- (void)btnSubmitClick{
    if (self.blockComplete) {
        if (self.tfReason.text.length<=0) {
            [GlobalMethod showAlert:@"至少输入5个字符"];
            return;
        }
//        if (self.tfReason.text.length>20) {
//            [GlobalMethod showAlert:@"最多输入20个字符"];
//            return;
//        }
        self.blockComplete(self.tfReason.text);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
@end
