//
//  InputNumView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "InputNumView.h"
//list view
#import "ListAlertView.h"

@interface InputNumView ()<UITextFieldDelegate>

@end

@implementation InputNumView

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
        [_labelInput fitTitle:@"录入箱号" variable:0];

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
    }
    return _viewBorder;
}
- (UITextField *)tfNum{
    if (_tfNum == nil) {
        _tfNum = [UITextField new];
        _tfNum.font = [UIFont systemFontOfSize:F(15)];
        _tfNum.textAlignment = NSTextAlignmentLeft;
        _tfNum.textColor = COLOR_333;
        _tfNum.borderStyle = UITextBorderStyleNone;
        _tfNum.backgroundColor = [UIColor clearColor];
        _tfNum.delegate = self;
//        [_tfNum addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _tfNum;
}
- (UIImageView *)ivCamera{
    if (_ivCamera == nil) {
        _ivCamera = [UIImageView new];
        _ivCamera.image = [UIImage imageNamed:@"inputCamera"];
        _ivCamera.widthHeight = XY(W(25),W(25));
    }
    return _ivCamera;
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
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.font = [UIFont systemFontOfSize:F(15)];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.backgroundColor = [UIColor clearColor];
        [_labelTitle fitTitle:@"货物名称" variable:0];
    }
    return _labelTitle;
}
- (UIImageView *)ivDown{
    if (_ivDown == nil) {
        _ivDown = [UIImageView new];
        _ivDown.image = [UIImage imageNamed:@"accountDown"];
        _ivDown.widthHeight = XY(W(25),W(25));
    }
    return _ivDown;
}
- (UIView *)viewDownBorder{
    if (_viewDownBorder == nil) {
        _viewDownBorder = [UIView new];
        _viewDownBorder.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_viewDownBorder color:COLOR_LINE numRound:5 width:1];
        _viewDownBorder.widthHeight = XY(W(275), W(45));
        
    }
    return _viewDownBorder;
}

- (NSString *)title{
    return self.packageSelect.containerNumber;
}
- (void)setTitle:(NSString *)title{
    self.packageSelect.containerNumber = title;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubView];
        [self addTarget:self action:@selector(hideKeyboardClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.labelInput];
    [self.viewBG addSubview:self.ivClose];
    [self.viewBG addSubview:self.viewBorder];
    [self.viewBG addSubview:self.tfNum];
    [self.viewBG addSubview:self.ivCamera];
    [self.viewBG addSubview:self.btnSubmit];
    [self.viewBG addSubview:self.labelTitle];
    [self.viewBG addSubview:self.viewDownBorder];
    [self.viewBG addSubview:self.ivDown];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.widthHeight = XY(W(315), W(268));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(200)) );
    
    self.labelInput.centerXTop = XY(self.viewBG.width/2.0,W(25));
    
    self.ivClose.rightTop = XY(self.viewBG.width - W(16),W(21));
    [self.viewBG addControlFrame:CGRectInset(self.ivClose.frame, -W(20), -W(20)) belowView:self.ivClose target:self action:@selector(closeClick)];
    
    self.viewDownBorder.centerXTop = XY(self.viewBG.width/2.0,W(77));
    
    self.ivDown.rightCenterY = XY(self.viewDownBorder.right - W(15),self.viewDownBorder.centerY);
    [self.viewBG addControlFrame:CGRectInset(self.viewDownBorder.frame, -W(5), -W(5)) belowView:self.ivDown target:self action:@selector(downClick)];
    
    self.labelTitle.leftCenterY = XY(self.viewDownBorder.left + W(15),self.viewDownBorder.centerY);
    
    self.viewBorder.widthHeight = XY(W(275), W(45));
    self.viewBorder.centerXTop = XY(self.viewBG.width/2.0, W(142));
    
    self.ivCamera.rightCenterY = XY(self.viewBorder.right - W(15),self.viewBorder.centerY);
    [self.viewBG addControlFrame:CGRectInset(self.ivCamera.frame, -W(5), -W(5)) belowView:self.ivCamera target:self action:@selector(cameraClick)];
    
    self.tfNum.widthHeight = XY(self.ivCamera.left - self.viewBorder.left - W(30),self.viewBorder.height);
    self.tfNum.leftCenterY = XY(self.viewBorder.left + W(15),self.viewBorder.centerY);
    
    [self.viewBG addLineFrame:CGRectMake(0, self.viewBG.height - W(55), self.viewBG.width, 1)];
    
    self.btnSubmit.widthHeight = XY(self.viewBG.width,W(55));
    self.btnSubmit.centerXBottom = XY(self.viewBG.width/2.0,self.viewBG.height);
}

#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}

#pragma mark click
- (void)closeClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)showWithAry:(NSArray *)ary{
    //config data
    self.aryDatas = ary;
    self.packageSelect = isAry(ary)?ary.firstObject:nil;
    [self refreshView];
    
    //show
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}

- (void)refreshView{
//    NSString * strNum = self.aryDatas.count>1?[NSString stringWithFormat:@"(%d/%d)",(int)[self.aryDatas indexOfObject:self.packageSelect]+1,(int)self.aryDatas.count]:@"";

    [self.labelTitle fitTitle:[NSString stringWithFormat:@"%@%@%@*1",UnPackStr(self.packageSelect.cargoName),isStr(self.packageSelect.cargoName)?@" ":@"",self.packageSelect.containerTypeShow] variable:0];
    self.tfNum.text = self.title;
}

- (void)cameraClick{
    if (self.blockORCClick) {
        self.blockORCClick();
    }
}
- (void)btnSubmitClick{
    self.title = self.tfNum.text;
    if (self.blockComplete) {
        self.blockComplete(self.packageSelect);
    }
    [self removeFromSuperview];
}
- (void)hideKeyboardClick{
    [GlobalMethod endEditing];
}
- (void)downClick{
    [GlobalMethod endEditing];
    WEAKSELF
    NSMutableArray * ary = [NSMutableArray array];
    for (int i = 0; i< self.aryDatas.count; i++) {
        ModelPackageInfo * modelItem = self.aryDatas[i];
        [ary addObject:[NSString stringWithFormat:@"%@%@%@*1",UnPackStr(modelItem.cargoName),isStr(modelItem.cargoName)?@" ":@"",self.packageSelect.containerTypeShow]];

    }
   
    ListAlertView * listNew = [ListAlertView new];
    [listNew showWithPoint:[self.viewBG convertPoint:CGPointMake(self.viewDownBorder.left, self.viewDownBorder.bottom) toView:[UIApplication sharedApplication].keyWindow]  width:self.viewDownBorder.width ary:ary];
    listNew.blockSelected = ^(NSInteger index) {
        if (weakSelf.aryDatas.count > index ) {
            weakSelf.packageSelect = [weakSelf.aryDatas objectAtIndex:index];
            [weakSelf refreshView];
        }
    };
}
@end


//@implementation InputPlumbumNumView
//@synthesize labelInput = _labelInput;
//
//- (UILabel *)labelInput{
//    if (_labelInput == nil) {
//        _labelInput = [UILabel new];
//        _labelInput.textColor = COLOR_333;
//        _labelInput.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
//        [_labelInput fitTitle:@"录入铅封号" variable:0];
//        
//    }
//    return _labelInput;
//}
//
//@end
