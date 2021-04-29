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
#import "SelectDistrictView.h"
#import <NSAttributedString+YYText.h>

@interface ScheduleConfirmView ()<UITextFieldDelegate>
@property (nonatomic, assign) NSInteger indexSelect;
@property (nonatomic, assign) BOOL isShowAll;
@property (nonatomic, strong) SelectDistrictView *selectDistrictView;
@property (nonatomic, strong) ModelValidCar *carSelected;

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
- (UILabel *)labelAlert{
    if (_labelAlert == nil) {
        _labelAlert = [UILabel new];
        _labelAlert.textColor = COLOR_RED;
        _labelAlert.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _labelAlert.numberOfLines = 0;
        _labelAlert.lineSpace = W(3);
        [_labelAlert fitTitle:@"根据交通部规定，牵引车运输需完善挂车信息。请于6月1日之前重新提交车辆认证，否则后期将无法下单。【去认证】" variable:W(275)];
        NSString * str1 = @"根据交通部规定，牵引车运输需完善挂车信息。请于6月1日之前重新提交车辆认证，否则后期将无法下单。";
        NSString * str2 = @"【去认证】";
        NSMutableAttributedString * strAttribute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
        [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_RED,        NSFontAttributeName : [UIFont systemFontOfSize:F(12)]} range:NSMakeRange(0, str1.length)];
        [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_BLUE,        NSFontAttributeName : [UIFont systemFontOfSize:F(12)]} range:NSMakeRange(str1.length, str2.length)];
        strAttribute.lineSpacing = W(3);
        _labelAlert.attributedText = strAttribute;
        [_labelAlert addTarget:self action:@selector(alertClick)];
    }
    return _labelAlert;
}

- (UIImageView *)ivClose{
    if (_ivClose == nil) {
        _ivClose = [UIImageView new];
        _ivClose.image = [UIImage imageNamed:@"inputClose"];
        _ivClose.widthHeight = XY(W(25),W(25));
    }
    return _ivClose;
}
- (SelectDistrictView *)selectDistrictView{
    if (!_selectDistrictView) {
        _selectDistrictView = [SelectDistrictView new];
        WEAKSELF
        _selectDistrictView.blockCitySeleted = ^(ModelProvince *p, ModelProvince *c, ModelProvince *d) {
            weakSelf.modelProvince = p;
            weakSelf.modelCity = c;
            weakSelf.modelDistrict = d;
            [weakSelf.labelReceiveAddress fitTitle:[NSString stringWithFormat:@"%@%@%@",p.name,c.name,d.name] variable:W(200)];
        };
    }
    return _selectDistrictView;
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
- (UIView *)viewReceiveAddressBorder{
    if (_viewReceiveAddressBorder == nil) {
        _viewReceiveAddressBorder = [UIView new];
        _viewReceiveAddressBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewReceiveAddressBorder color:COLOR_LINE numRound:5 width:1];
        _viewReceiveAddressBorder.widthHeight = XY(W(275), W(45));
        _viewReceiveAddressBorder.userInteractionEnabled = true;
        [_viewReceiveAddressBorder addTarget:self action:@selector(selectAddressClick)];
    }
    return _viewReceiveAddressBorder;
}
- (UIView *)viewReceiverPhoneBorder{
    if (_viewReceiverPhoneBorder == nil) {
        _viewReceiverPhoneBorder = [UIView new];
        _viewReceiverPhoneBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewReceiverPhoneBorder color:COLOR_LINE numRound:5 width:1];
        _viewReceiverPhoneBorder.widthHeight = XY(W(275), W(45));
        _viewReceiverPhoneBorder.userInteractionEnabled = true;
        [_viewReceiverPhoneBorder addTarget:self action:@selector(downClick)];
    }
    return _viewReceiverPhoneBorder;
}
- (UIView *)viewReceiverNameBorder{
    if (_viewReceiverNameBorder == nil) {
        _viewReceiverNameBorder = [UIView new];
        _viewReceiverNameBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewReceiverNameBorder color:COLOR_LINE numRound:5 width:1];
        _viewReceiverNameBorder.widthHeight = XY(W(275), W(45));
        _viewReceiverNameBorder.userInteractionEnabled = true;
        [_viewReceiverNameBorder addTarget:self action:@selector(downClick)];
    }
    return _viewReceiverNameBorder;
}
- (UIView *)viewAddressDetailBorder{
    if (_viewAddressDetailBorder == nil) {
        _viewAddressDetailBorder = [UIView new];
        _viewAddressDetailBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewAddressDetailBorder color:COLOR_LINE numRound:5 width:1];
        _viewAddressDetailBorder.widthHeight = XY(W(275), W(45));
        _viewAddressDetailBorder.userInteractionEnabled = true;
        [_viewAddressDetailBorder addTarget:self action:@selector(downClick)];
    }
    return _viewAddressDetailBorder;
}
- (UIView *)viewReceiveCompanyNameBorder{
    if (_viewReceiveCompanyNameBorder == nil) {
        _viewReceiveCompanyNameBorder = [UIView new];
        _viewReceiveCompanyNameBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewReceiveCompanyNameBorder color:COLOR_LINE numRound:5 width:1];
        _viewReceiveCompanyNameBorder.widthHeight = XY(W(275), W(45));
        _viewReceiveCompanyNameBorder.userInteractionEnabled = true;
        [_viewReceiveCompanyNameBorder addTarget:self action:@selector(downClick)];
    }
    return _viewReceiveCompanyNameBorder;
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
- (UIImageView *)ivDown1{
    if (_ivDown1 == nil) {
        _ivDown1 = [UIImageView new];
        _ivDown1.image = [UIImage imageNamed:@"accountDown"];
        _ivDown1.widthHeight = XY(W(25),W(25));
    }
    return _ivDown1;
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
- (UITextField *)tfReceiveCompanyName{
    if (_tfReceiveCompanyName == nil) {
        _tfReceiveCompanyName = [UITextField new];
        _tfReceiveCompanyName.font = [UIFont systemFontOfSize:F(15)];
        _tfReceiveCompanyName.textAlignment = NSTextAlignmentLeft;
        _tfReceiveCompanyName.textColor = COLOR_333;
        _tfReceiveCompanyName.borderStyle = UITextBorderStyleNone;
        _tfReceiveCompanyName.backgroundColor = [UIColor clearColor];
        _tfReceiveCompanyName.delegate = self;
        _tfReceiveCompanyName.placeholder = @"收货企业名称(必填)";
    }
    return _tfReceiveCompanyName;
}
- (UITextField *)tfAddressDetail{
    if (_tfAddressDetail == nil) {
        _tfAddressDetail = [UITextField new];
        _tfAddressDetail.font = [UIFont systemFontOfSize:F(15)];
        _tfAddressDetail.textAlignment = NSTextAlignmentLeft;
        _tfAddressDetail.textColor = COLOR_333;
        _tfAddressDetail.borderStyle = UITextBorderStyleNone;
        _tfAddressDetail.backgroundColor = [UIColor clearColor];
        _tfAddressDetail.delegate = self;
        _tfAddressDetail.placeholder = @"收货详细地址(必填)";
    }
    return _tfAddressDetail;
}
- (UITextField *)tfReceiverName{
    if (_tfReceiverName == nil) {
        _tfReceiverName = [UITextField new];
        _tfReceiverName.font = [UIFont systemFontOfSize:F(15)];
        _tfReceiverName.textAlignment = NSTextAlignmentLeft;
        _tfReceiverName.textColor = COLOR_333;
        _tfReceiverName.borderStyle = UITextBorderStyleNone;
        _tfReceiverName.backgroundColor = [UIColor clearColor];
        _tfReceiverName.delegate = self;
        _tfReceiverName.placeholder = @"收货联系人";
    }
    return _tfReceiverName;
}
- (UITextField *)tfReceiverPhone{
    if (_tfReceiverPhone == nil) {
        _tfReceiverPhone = [UITextField new];
        _tfReceiverPhone.font = [UIFont systemFontOfSize:F(15)];
        _tfReceiverPhone.textAlignment = NSTextAlignmentLeft;
        _tfReceiverPhone.textColor = COLOR_333;
        _tfReceiverPhone.borderStyle = UITextBorderStyleNone;
        _tfReceiverPhone.backgroundColor = [UIColor clearColor];
        _tfReceiverPhone.delegate = self;
        _tfReceiverPhone.placeholder = @"收货联系电话";
    }
    return _tfReceiverPhone;
}
- (UILabel *)labelReceiveAddress{
    if (_labelReceiveAddress == nil) {
        _labelReceiveAddress = [UILabel new];
        _labelReceiveAddress.font = [UIFont systemFontOfSize:F(15)];
        _labelReceiveAddress.textColor = COLOR_333;
        _labelReceiveAddress.backgroundColor = [UIColor clearColor];
        [_labelReceiveAddress fitTitle:@"选择收货地(必填)" variable:0];
    }
    return _labelReceiveAddress;
}
- (UIButton *)btnSubmit{
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
        self.carSelected = model;
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
    [self.viewBG addSubview:self.viewReceiveCompanyNameBorder];
    [self.viewBG addSubview:self.viewAddressDetailBorder];
    [self.viewBG addSubview:self.viewReceiverNameBorder];
    [self.viewBG addSubview:self.viewReceiverPhoneBorder];
    [self.viewBG addSubview:self.viewReceiveAddressBorder];
    [self.viewBG addSubview:self.tfReceiveCompanyName];
    [self.viewBG addSubview:self.tfAddressDetail];
    [self.viewBG addSubview:self.tfReceiverName];
    [self.viewBG addSubview:self.tfReceiverPhone];
    [self.viewBG addSubview:self.labelReceiveAddress];
    [self.viewBG addSubview:self.ivDown1];
    [self.viewBG addSubview:self.labelAlert];

    //初始化页面
    [self resetViewWithModel:true];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(BOOL)showAll{
    self.isShowAll = showAll;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    CGFloat alertHeight = 0;
    self.labelAlert.hidden = !(self.carSelected.isTrailer && self.carSelected.trailerNumber.length == 0) ;
    if (!self.labelAlert.hidden) {
        self.labelAlert.top = W(67);
        self.labelAlert.centerX = self.viewBG.width/2.0;
        alertHeight = W(53);
    }
    //刷新view
    self.viewBG.width = W(315);
    
    self.labelTitle.centerXTop = XY(self.viewBG.width/2.0,W(25));
    
    self.ivClose.rightTop = XY(self.viewBG.width - W(16),W(21));
    [self.viewBG addControlFrame:CGRectInset(self.ivClose.frame, -W(20), -W(20)) belowView:self.ivClose target:self action:@selector(closeClick)];
    
   
    
    self.viewNameBorder.centerXTop = XY(self.viewBG.width/2.0, W(77)+alertHeight);
    self.labelName.leftCenterY = XY(self.viewNameBorder.left + W(15),self.viewNameBorder.centerY);
    
    self.viewBorder.centerXTop = XY(self.viewBG.width/2.0,W(65)+self.viewNameBorder.top);
    
    self.ivDown.rightCenterY = XY(self.viewBorder.right - W(15),self.viewBorder.centerY);
    
    self.labelCarNumber.leftCenterY = XY(self.viewBorder.left + W(15),self.viewBorder.centerY);
    
    self.viewPhoneBorder.centerXTop =  XY(self.viewBG.width/2.0,W(130)+self.viewNameBorder.top);
    self.tfPhone.widthHeight = XY(self.viewPhoneBorder.width - W(30),self.viewPhoneBorder.height);
    self.tfPhone.leftCenterY = XY(self.viewBorder.left + W(15),self.viewPhoneBorder.centerY);
    
    NSArray * ary = @[self.tfReceiveCompanyName,self.labelReceiveAddress,self.tfAddressDetail,self.tfReceiverName,self.tfReceiverPhone];
    NSArray * arySub = @[self.viewReceiveCompanyNameBorder,self.viewReceiveAddressBorder,self.viewAddressDetailBorder,self.viewReceiverNameBorder,self.viewReceiverPhoneBorder];
    for (int i = 0; i<ary.count; i++) {
        UIView * vMain = ary[i];
        UIView * vSub = arySub[i];
        vMain.hidden = !showAll;
        vSub.hidden = !showAll;
    }
    self.ivDown.hidden = !showAll;
    CGFloat top = self.viewPhoneBorder.bottom;
    if (showAll) {
        for (int i = 0; i<ary.count; i++) {
            UIView * vMain = ary[i];
            UIView * vSub = arySub[i];
            vSub.centerXTop =  XY(self.viewBG.width/2.0,top+W(15));
            top = vSub.bottom;
            if ([vMain isKindOfClass:[UILabel class]]) {
                vMain.leftCenterY = XY(vSub.left + W(15),vSub.centerY);
            }else{
                vMain.widthHeight = XY(vSub.width - W(30),vSub.height);
                vMain.leftCenterY = XY(vSub.left + W(15),vSub.centerY);
            }
        }
    }
    self.ivDown1.rightCenterY = XY(self.viewReceiveAddressBorder.right - W(15),self.viewReceiveAddressBorder.centerY);
    self.viewBG.height = top + W(80);
    [self.viewBG addLineFrame:CGRectMake(0, self.viewBG.height - W(55), self.viewBG.width, 1)];
    
    self.btnSubmit.widthHeight = XY(self.viewBG.width,W(55));
    self.btnSubmit.centerXBottom = XY(self.viewBG.width/2.0,self.viewBG.height);
    
    if (showAll) {
        self.viewBG.centerXCenterY = XY(SCREEN_WIDTH/2.0,SCREEN_HEIGHT/2.0);
    }else{
        self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(167)));
    }
    
}
#pragma mark keyboard
- (void)keyboardShow:(NSNotification *)notice{
    //    键盘的frame
    CGRect frame = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    键盘的实时Y
    CGFloat keyHeight = SCREEN_HEIGHT -  frame.origin.y;
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isShowAll) {
            self.viewBG.bottom = SCREEN_HEIGHT - keyHeight;
        }else{
            self.viewBG.top = MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(107));
        }
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isShowAll) {
            self.viewBG.centerY = SCREEN_HEIGHT/2.0;
        }else{
            self.viewBG.top = MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(167));
        }
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
    [GlobalMethod endEditing];
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
        weakSelf.carSelected = model;
        [weakSelf resetViewWithModel:weakSelf.isShowAll];
    };
}
- (void)selectAddressClick{
    [GlobalMethod endEditing];
    [GB_Nav.lastVC.view addSubview:self.selectDistrictView];
}
- (void)btnSubmitClick{
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
    if (self.isShowAll) {
        if (!self.tfReceiveCompanyName.text.length) {
            [GlobalMethod showAlert:@"请填写收货企业名称"];
            return;
        }
        if (!self.modelDistrict.iDProperty) {
            [GlobalMethod showAlert:@"请选择收货地"];
            return;
        }
        if (!self.tfAddressDetail.text.length) {
            [GlobalMethod showAlert:@"请填写详细收货地址"];
            return;
        }
        if (self.blockAllComplete ) {
            self.blockAllComplete(model, self.tfPhone.text, self.tfReceiveCompanyName.text, self.modelDistrict.iDProperty, self.tfAddressDetail.text, self.tfReceiverName.text, self.tfReceiverPhone.text);
        }
    }else{
        if (self.blockComplete) {
            self.blockComplete(model,self.tfPhone.text);
        }
    }
    
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)alertClick{
    if (self.blockAlertClick) {
        self.blockAlertClick(self.carSelected);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
@end
