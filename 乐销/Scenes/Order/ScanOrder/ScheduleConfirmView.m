//
//  ScheduleConfirmView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "ScheduleConfirmView.h"
//list view
#import "ListAlertView.h"
#import "UITextField+Text.h"

@interface ScheduleConfirmView ()<UITextFieldDelegate>
@property (nonatomic, assign) NSInteger indexSelect;
@end

@implementation ScheduleConfirmView
@synthesize aryDatas = _aryDatas;

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
        [_labelTitle fitTitle:@"确认车辆信息" variable:0];
        
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

- (UIView *)viewNameBorder{
    if (_viewNameBorder == nil) {
        _viewNameBorder = [UIView new];
        _viewNameBorder.backgroundColor = COLOR_BACKGROUND;
        [GlobalMethod setRoundView:_viewNameBorder color:COLOR_LINE numRound:5 width:1];
        _viewNameBorder.widthHeight = XY(W(275), W(45));
    }
    return _viewNameBorder;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.font = [UIFont systemFontOfSize:F(15)];
        _labelName.textColor = COLOR_999;
        _labelName.backgroundColor = [UIColor clearColor];
        [_labelName fitTitle:UnPackStr([GlobalData sharedInstance].GB_UserModel.realName) variable:0];
    }
    return _labelName;
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
- (UILabel *)labelCarNumber{
    if (_labelCarNumber == nil) {
        _labelCarNumber = [UILabel new];
        _labelCarNumber.font = [UIFont systemFontOfSize:F(15)];
        _labelCarNumber.textColor = COLOR_333;
        _labelCarNumber.backgroundColor = [UIColor clearColor];
        [_labelCarNumber fitTitle:@"车牌号" variable:0];
    }
    return _labelCarNumber;
}
- (UIImageView *)ivDown{
    if (_ivDown == nil) {
        _ivDown = [UIImageView new];
        _ivDown.image = [UIImage imageNamed:@"accountDown"];
        _ivDown.widthHeight = XY(W(25),W(25));
    }
    return _ivDown;
}
- (UIView *)viewPhoneBorder{
    if (_viewPhoneBorder == nil) {
        _viewPhoneBorder = [UIView new];
        _viewPhoneBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewPhoneBorder color:COLOR_LINE numRound:5 width:1];
        _viewPhoneBorder.widthHeight = XY(W(275), W(45));
    }
    return _viewPhoneBorder;
}
- (UITextField *)tfPhone{
    if (_tfPhone == nil) {
        _tfPhone = [UITextField new];
        _tfPhone.font = [UIFont systemFontOfSize:F(15)];
        _tfPhone.textAlignment = NSTextAlignmentLeft;
        _tfPhone.textColor = COLOR_333;
        _tfPhone.borderStyle = UITextBorderStyleNone;
        _tfPhone.backgroundColor = [UIColor clearColor];
        _tfPhone.delegate = self;
        _tfPhone.placeholder = @"输入手机号";
        _tfPhone.text = [GlobalData sharedInstance].GB_UserModel.cellPhone;
        
    }
    return _tfPhone;
}

-(UIButton *)btnSubmit{
    if (_btnSubmit == nil) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.backgroundColor = [UIColor clearColor];
        _btnSubmit.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSubmit setTitle:@"确认下单" forState:(UIControlStateNormal)];
        [_btnSubmit setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(btnSubmitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
- (void)setAryDatas:(NSMutableArray *)aryDatas{
    _aryDatas = aryDatas;
    if (aryDatas.count) {
        ModelValidCar * model = _aryDatas.firstObject;
        [self.labelCarNumber fitTitle:model.nameShow variable:W(200)];
    }
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
    [self.viewBG addSubview:self.labelCarNumber];
    [self.viewBG addSubview:self.ivDown];
    [self.viewBG addSubview:self.viewNameBorder];
    [self.viewBG addSubview:self.labelName];
    [self.viewBG addSubview:self.viewBorder];
    [self.viewBG addSubview:self.viewPhoneBorder];
    [self.viewBG addSubview:self.tfPhone];
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
    
    self.labelTitle.centerXTop = XY(self.viewBG.width/2.0,W(25));
    
    self.ivClose.rightTop = XY(self.viewBG.width - W(16),W(21));
    [self.viewBG addControlFrame:CGRectInset(self.ivClose.frame, -W(20), -W(20)) belowView:self.ivClose target:self action:@selector(closeClick)];
    
    self.viewNameBorder.centerXTop = XY(self.viewBG.width/2.0, W(77));
    self.labelName.leftCenterY = XY(self.viewNameBorder.left + W(15),self.viewNameBorder.centerY);
    
    self.viewBorder.centerXTop = XY(self.viewBG.width/2.0,W(142));
    
    self.ivDown.rightCenterY = XY(self.viewBorder.right - W(15),self.viewBorder.centerY);
    
    self.labelCarNumber.leftCenterY = XY(self.viewBorder.left + W(15),self.viewBorder.centerY);
    
    self.viewPhoneBorder.centerXTop =  XY(self.viewBG.width/2.0,W(207));
    self.tfPhone.widthHeight = XY(self.viewPhoneBorder.width - W(30),self.viewPhoneBorder.height);
    self.tfPhone.leftCenterY = XY(self.viewBorder.left + W(15),self.viewPhoneBorder.centerY);
    
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
    NSArray * ary = [self.aryDatas fetchValues:@"nameShow"];
    [listNew showWithPoint:[self.viewBG convertPoint:CGPointMake(self.viewBorder.left, self.viewBorder.bottom) toView:[UIApplication sharedApplication].keyWindow]  width:self.viewBorder.width ary:ary];
    WEAKSELF
    listNew.blockSelected = ^(NSInteger index) {
        weakSelf.indexSelect = index;
        ModelValidCar * model = (weakSelf.indexSelect<=weakSelf.aryDatas.count-1)?weakSelf.aryDatas[weakSelf.indexSelect]:nil;
        [weakSelf.labelCarNumber fitTitle:model.nameShow variable:W(200)];
    };
}

- (void)btnSubmitClick{
    if (self.blockComplete) {
        ModelValidCar * model = (self.indexSelect<=self.aryDatas.count-1)?self.aryDatas[self.indexSelect]:nil;
        if (!self.aryDatas.count) {
            [GlobalMethod showAlert:@"当前无可运输车辆"];
            return;
        }
        if (!model) {
            [GlobalMethod showAlert:@"请先选择车辆"];
            return;
        }
        if (!self.tfPhone.text.length) {
            [GlobalMethod showAlert:@"请填写手机号"];
            return;
        }
        self.blockComplete(model,self.tfPhone.text);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
@end
