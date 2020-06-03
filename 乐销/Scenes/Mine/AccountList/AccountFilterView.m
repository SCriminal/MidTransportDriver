//
//  AccountFilterView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "AccountFilterView.h"
//date picker
#import "DatePicker.h"
//list view
#import "ListAlertView.h"
//date
#import "NSDate+YYAdd.h"
@interface AccountFilterView ()<UITextFieldDelegate>
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, assign) CGRect borderFrame;
@end

@implementation AccountFilterView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
}

- (UITextField *)tfBillNo{
    if (_tfBillNo == nil) {
        _tfBillNo = [UITextField new];
        _tfBillNo.font = [UIFont systemFontOfSize:F(15)];
        _tfBillNo.textAlignment = NSTextAlignmentLeft;
        _tfBillNo.textColor = COLOR_333;
        _tfBillNo.borderStyle = UITextBorderStyleNone;
        _tfBillNo.backgroundColor = [UIColor clearColor];
        _tfBillNo.delegate = self;
        _tfBillNo.placeholder = @"输入提单号";
    }
    return _tfBillNo;
}
- (UILabel *)labelCarTeam{
    if (_labelCarTeam == nil) {
        _labelCarTeam = [UILabel new];
        _labelCarTeam.font = [UIFont systemFontOfSize:F(15)];
        _labelCarTeam.textColor = COLOR_333;
        _labelCarTeam.backgroundColor = [UIColor clearColor];
        [_labelCarTeam fitTitle:@"全部车队" variable:0];
    }
    return _labelCarTeam;
}
- (UILabel *)labelTimeStart{
    if (_labelTimeStart == nil) {
        _labelTimeStart = [UILabel new];
        _labelTimeStart.font = [UIFont systemFontOfSize:F(15)];
        _labelTimeStart.textColor = COLOR_999;
        _labelTimeStart.backgroundColor = [UIColor clearColor];
        [_labelTimeStart fitTitle:@"选择开始时间" variable:0];
    }
    return _labelTimeStart;
}
- (UILabel *)labelTimeEnd{
    if (_labelTimeEnd == nil) {
        _labelTimeEnd = [UILabel new];
        _labelTimeEnd.font = [UIFont systemFontOfSize:F(15)];
        _labelTimeEnd.textColor = COLOR_999;
        _labelTimeEnd.backgroundColor = [UIColor clearColor];
        [_labelTimeEnd fitTitle:@"选择结束时间" variable:0];
    }
    return _labelTimeEnd;
}
-(UIButton *)btnSearch{
    if (_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.backgroundColor = COLOR_BLUE;
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSearch setTitle:@"提交" forState:(UIControlStateNormal)];
        [_btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(btnSearchClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnSearch color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnSearch;
}
-(UIButton *)btnReset{
    if (_btnReset == nil) {
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.backgroundColor = COLOR_BLUE;
        _btnReset.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnReset setTitle:@"重置" forState:(UIControlStateNormal)];
        [_btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(btnResetClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnReset color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnReset;
}
- (UIView *)viewBlackAlpha{
    if (!_viewBlackAlpha) {
        _viewBlackAlpha = [UIView new];
        _viewBlackAlpha.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _viewBlackAlpha;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubView];
        [self addTarget:self action:@selector(closeClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBlackAlpha];
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.tfBillNo];
    [self.viewBG addSubview:self.btnSearch];
    [self.viewBG addSubview:self.btnReset];
    [self.viewBG addSubview:self.labelCarTeam];
    [self.viewBG addSubview:self.labelTimeStart];
    [self.viewBG addSubview:self.labelTimeEnd];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.widthHeight = XY(SCREEN_WIDTH, W(280));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT);
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(20), W(335), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(tfBillNoClick)];
        self.tfBillNo.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfBillNo.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
    }
    
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(85), W(335), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(allMotorcadeClick)];
        self.labelCarTeam.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        self.borderFrame = viewBorder.frame;
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
    }

    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(150), W(160), W(45))];
        [self.viewBG addSubview:viewBorder];
        self.labelTimeStart.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        [viewBorder addTarget:self action:@selector(startDateClick)];

        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
    }
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(195), W(150), W(160), W(45))];
        [self.viewBG addSubview:viewBorder];
        self.labelTimeEnd.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        [viewBorder addTarget:self action:@selector(endDateClick)];

        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
    }
    
    
    self.btnSearch.widthHeight = XY(W(160),W(45));
    self.btnReset.widthHeight = XY(W(160),W(45));
    self.btnSearch.leftBottom = XY(self.viewBG.width/2.0 + W(7.5),self.viewBG.height- W(20));
    self.btnReset.rightBottom = XY(self.viewBG.width/2.0 - W(7.5),self.viewBG.height- W(20));
}
- (UIView *)generateBorder:(CGRect)frame{
    UIView * viewBorder = [UIView new];
    viewBorder.backgroundColor = [UIColor clearColor];
    [GlobalMethod setRoundView:viewBorder color:COLOR_LINE numRound:5 width:1];
    viewBorder.frame = frame;
    return viewBorder;
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
- (void)tfBillNoClick{
    [self.tfBillNo becomeFirstResponder];
}
- (void)closeClick{
    if ([self fetchFirstResponder]) {
        [GlobalMethod endEditing];
        return;
    }
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
- (void)allMotorcadeClick{
    if (!isAry(self.aryDatas)) {
        [GlobalMethod showAlert:@"车队列表暂无数据"];
        return;
    }
    ListAlertView * listNew = [ListAlertView new];
    NSArray * aryStrs = [self.aryDatas fetchValues:@"entName"];
    [listNew showWithPoint:[self.viewBG convertPoint:CGPointMake(CGRectGetMinX(self.borderFrame), CGRectGetMaxY(self.borderFrame)) toView:[UIApplication sharedApplication].keyWindow]  width:self.borderFrame.size.width ary:aryStrs];
    WEAKSELF
    listNew.blockSelected = ^(NSInteger index) {
        if (weakSelf.aryDatas.count >index) {
            weakSelf.modelMotorcade = weakSelf.aryDatas[index];
            [weakSelf.labelCarTeam fitTitle:weakSelf.modelMotorcade.entName variable:0];
        }
        [weakSelf.labelCarTeam fitTitle:weakSelf.modelMotorcade.entName variable:0];
    };
}
- (void)startDateClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        weakSelf.dateStart = date;
        [weakSelf.labelTimeStart fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}
- (void)endDateClick{
    [GlobalMethod endEditing];
  
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        date = [date dateByAddingSeconds:86399];
        weakSelf.dateEnd = date;
        [weakSelf.labelTimeEnd fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}
- (void)btnSearchClick{
    if (self.blockSearchClick) {
        self.blockSearchClick(self.tfBillNo.text,self.modelMotorcade,self.dateStart,self.dateEnd);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}

- (void)btnResetClick{
    self.tfBillNo.text = @"";
    self.dateStart = nil;
    self.dateEnd = nil;
    self.modelMotorcade = nil;
    [self.labelTimeStart fitTitle:@"选择开始时间" variable:0];
    [self.labelTimeEnd fitTitle:@"选择结束时间" variable:0];
    [self btnSearchClick];
    
}
@end
