//
//  OrderFilterView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/14.
//Copyright © 2019 ping. All rights reserved.
//

#import "OrderFilterView.h"
//date picker
#import "DatePicker.h"
//list view
#import "ListAlertView.h"
//date
#import "NSDate+YYAdd.h"

@interface OrderFilterView ()<UITextFieldDelegate>

@end

@implementation OrderFilterView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        [_viewBG addTarget:self action:@selector(viewBgClick)];
    }
    return _viewBG;
}

- (UITextField *)tfBillNo{
    if (_tfBillNo == nil) {
        _tfBillNo = [UITextField new];
        _tfBillNo.font = [UIFont systemFontOfSize:F(14)];
        _tfBillNo.textAlignment = NSTextAlignmentLeft;
        _tfBillNo.textColor = COLOR_333;
        _tfBillNo.borderStyle = UITextBorderStyleNone;
        _tfBillNo.backgroundColor = [UIColor clearColor];
        _tfBillNo.delegate = self;
        _tfBillNo.placeholder = @"填写运单编号（支持模糊搜索）";
    }
    return _tfBillNo;
}

- (UILabel *)labelTimeStart{
    if (_labelTimeStart == nil) {
        _labelTimeStart = [UILabel new];
        _labelTimeStart.font = [UIFont systemFontOfSize:F(14)];
        _labelTimeStart.textColor = COLOR_999;
        _labelTimeStart.backgroundColor = [UIColor clearColor];
        [_labelTimeStart fitTitle:@"开始时间" variable:0];
    }
    return _labelTimeStart;
}
- (UILabel *)labelTimeEnd{
    if (_labelTimeEnd == nil) {
        _labelTimeEnd = [UILabel new];
        _labelTimeEnd.font = [UIFont systemFontOfSize:F(14)];
        _labelTimeEnd.textColor = COLOR_999;
        _labelTimeEnd.backgroundColor = [UIColor clearColor];
        [_labelTimeEnd fitTitle:@"结束时间" variable:0];
    }
    return _labelTimeEnd;
}
-(UIButton *)btnSearch{
    if (_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.backgroundColor = COLOR_BLUE;
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSearch setTitle:@"搜索" forState:(UIControlStateNormal)];
        [_btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(btnSearchClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnSearch color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnSearch;
}
-(UIButton *)btnReset{
    if (_btnReset == nil) {
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.backgroundColor = [UIColor whiteColor];
        _btnReset.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnReset setTitle:@"重置" forState:(UIControlStateNormal)];
        [_btnReset setTitleColor:COLOR_666 forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(btnResetClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnReset color:[UIColor colorWithHexString:@"#D7DBDA"] numRound:5 width:1];
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
    [self.viewBG addSubview:self.labelTimeStart];
    [self.viewBG addSubview:self.labelTimeEnd];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.widthHeight = XY(SCREEN_WIDTH, W(375));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT);
    [self addLabel:@"运单状态" top:W(17)];
    [self addBtn];
    [self addLabel:@"运单编号" top:W(137)];
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(15), W(160), W(345), W(39))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(tfBillNoClick)];
        self.tfBillNo.widthHeight = XY(viewBorder.width - W(24),viewBorder.height);
        self.tfBillNo.leftCenterY = XY(viewBorder.left + W(12),viewBorder.centerY);
    }
    [self addLabel:@"下单时间" top:W(216)];
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(15), W(239), W(165), W(39))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(startDateClick)];
        self.labelTimeStart.leftCenterY = XY(viewBorder.left + W(12),viewBorder.centerY);
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(23),W(23));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
    }
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(195), W(239), W(165), W(39))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(endDateClick)];
        self.labelTimeEnd.leftCenterY = XY(viewBorder.left + W(12),viewBorder.centerY);
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(23),W(23));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
    }
    
    [self.viewBG addLineFrame:CGRectMake(W(20), W(295), SCREEN_WIDTH - W(40), 1)];
    
    self.btnSearch.widthHeight = XY(W(165),W(39));
    self.btnReset.widthHeight = XY(W(165),W(39));
    self.btnSearch.leftBottom = XY(self.viewBG.width/2.0 + W(7.5),self.viewBG.height- W(17));
    self.btnReset.rightBottom = XY(self.viewBG.width/2.0 - W(7.5),self.viewBG.height- W(17));
}
- (CGFloat)addLabel:(NSString *)title top:(CGFloat)top{
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_666;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(0);
    [l fitTitle:title variable:SCREEN_WIDTH - W(30)];
    l.leftTop = XY(W(15), top);
    [self.viewBG addSubview:l];
    return l.bottom;
}
- (void)addBtn{
    NSArray * ary = @[@"全部",@"待接单",@"待装车",@"已装车",@"已装车",@"已支付"];
    CGFloat left = W(15);
    CGFloat top = W(40);
    for (int i = 0; i<ary.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(74), W(34));
        btn.backgroundColor = COLOR_ORANGE;
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(14);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        btn.leftTop = XY(left, top);
        left = btn.right + W(15);
        if (i == 3) {
            left = W(15);
            top = W(86);
        }
        [self.viewBG addSubview:btn];
    }
    [self resetBtn:100];
}
- (void)resetBtn:(int)tag{
    self.btnTagSelected = tag - 100;
    for (int i = 0; i<6; i++) {
        UIButton * btn = [self.viewBG viewWithTag:i+100];
        if (tag == i+100) {
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.backgroundColor = COLOR_BLUE;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:6 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
            }
        }else{
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
                [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
                [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:6 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
            }
        }
    }
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [self resetBtn:sender.tag];
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
- (void)tfBillNoClick{
    [self.tfBillNo becomeFirstResponder];
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

- (void)btnResetClick{
    self.tfBillNo.text = @"";
    self.dateStart = nil;
    self.dateEnd = nil;
    [self resetBtn:100];
    [self.labelTimeStart fitTitle:@"开始时间" variable:0];
    [self.labelTimeEnd fitTitle:@"结束时间" variable:0];
    [self btnSearchClick];
    
}
- (void)btnSearchClick{
    if (self.blockSearchClick) {
        self.blockSearchClick(self.btnTagSelected,self.tfBillNo.text,self.dateStart,self.dateEnd);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)viewBgClick{
    
}
@end
