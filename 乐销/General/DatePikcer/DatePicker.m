//
//  DatePicker.m
//中车运
//
//  Created by 隋林栋 on 2016/12/26.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "DatePicker.h"
//customdate picker
#import "CustomPickerView.h"

@implementation DatePicker

#pragma mark 懒加载
- (CustomPickerView *)datePicker{
    if (_datePicker == nil) {
        _datePicker = [[CustomPickerView alloc]initWithDatePickerMode:ENUM_PICKER_DATE_YEAR_MONTH_DAY MinDate:nil MaxDate:nil];
        /*
        _datePicker = [UIDatePicker new];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
         */
    }
    return _datePicker;
}
- (UIView *)viewBtnBG{
    if (_viewBtnBG == nil) {
        _viewBtnBG = [UIView new];
        _viewBtnBG.backgroundColor = [UIColor whiteColor];
        _viewBtnBG.widthHeight = XY(SCREEN_WIDTH,W(44));
    }
    return _viewBtnBG;
}
- (UIButton *)btnDismiss{
    if (_btnDismiss == nil) {
        _btnDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDismiss.tag = 1;
        [_btnDismiss addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnDismiss setTitle:@"取消" forState:UIControlStateNormal];
        [_btnDismiss setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnDismiss.backgroundColor = [UIColor clearColor];
        _btnDismiss.widthHeight = XY(W(80),W(44));
    }
    return _btnDismiss;
}
- (UIButton *)btnConfirm{
    if (_btnConfirm == nil) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.tag = 2;
        [_btnConfirm addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnConfirm.backgroundColor = [UIColor clearColor];
        _btnConfirm.widthHeight = XY(W(80),W(44));
    }
    return _btnConfirm;
}


#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:self.viewBtnBG];
        [self.viewBtnBG addSubview:self.btnDismiss];
        [self.viewBtnBG addSubview:self.btnConfirm];
        [self addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark 创建
+ (instancetype)initWithMinDate:(NSDate *)minDate dateSelectBlock:(void(^)(NSDate * date))dateSelectBlock{
    return [self initWithMinDate:minDate dateSelectBlock:dateSelectBlock type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
}
+ (instancetype)initWithBlock:(void(^)(NSDate * date))dateSelectBlock{
    return [self initWithMinDate:[NSDate date] dateSelectBlock:dateSelectBlock type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
}
+ (instancetype)initWithBlock:(void(^)(NSDate * date))dateSelectBlock type:(int)type{
    return [self initWithMinDate:[NSDate date] dateSelectBlock:dateSelectBlock type:type];
}

+ (instancetype)initWithMinDate:(NSDate *)minDate dateSelectBlock:(void(^)(NSDate * date))dateSelectBlock type:(int)type{
    DatePicker * view = [DatePicker new];
    view.block = dateSelectBlock;
    view.type = type;
    [view resetView:minDate];
    return view;
}


#pragma mark 刷新view
- (void)resetView:(NSDate *)minDate{
    
    self.datePicker = [[CustomPickerView alloc]initWithDatePickerMode:self.type MinDate:minDate MaxDate:nil];
    [self addSubview:self.datePicker];
    self.datePicker.frame = CGRectMake(W(0), W(0), SCREEN_WIDTH, W(220));
    self.datePicker.bottom = SCREEN_HEIGHT;

    self.viewBtnBG.leftBottom =XY(0,self.datePicker.top);
    
    self.btnDismiss.leftTop = XY(0,0);
    
    self.btnConfirm.rightTop = XY(SCREEN_WIDTH,0);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://dismiss
        {
            [self removeFromSuperview];
        }
            break;
        case 2://confirm
        {
            if (self.block != nil) {
                self.block(self.datePicker.date);
            }
            [self removeFromSuperview];
        }
            break;
        default:
            break;
    }
}


#pragma mark 点击事件
- (void)removeClick{
    [self removeFromSuperview];
}
@end


