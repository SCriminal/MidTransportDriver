//
//  DatePicker.h
//中车运
//
//  Created by 隋林栋 on 2016/12/26.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPickerView.h"
//选择cell  选择的内容
typedef NS_ENUM(NSUInteger, ENUM_PICK_DATE) {
    ENUM_SELECT_VALID = 0,//有效点击
    //选择时间格式
    ENUM_PICKER_DATE_YEAR_MONTH = 100,
    ENUM_PICKER_DATE_YEAR_MONTH_DAY,
    ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR,
    ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN,
    ENUM_PICKER_DATE_MONTH_DAY,
    ENUM_PICKER_DOUBLE_DATE_TIME,//选择两个日期 时间
};

@class CustomPickerView;
@interface DatePicker : UIControl

@property (nonatomic, strong) CustomPickerView *datePicker;
@property (nonatomic, strong) UIView *viewBtnBG;
@property (nonatomic, strong) UIButton *btnDismiss;
@property (nonatomic, strong) UIButton *btnConfirm;
@property (nonatomic, strong) void(^block)(NSDate * date);
@property (nonatomic, assign) ENUM_PICK_DATE type;
#pragma mark 创建
//创建
+ (instancetype)initWithMinDate:(NSDate *)minDate dateSelectBlock:(void(^)(NSDate * date))dateSelectBlock;
+ (instancetype)initWithBlock:(void(^)(NSDate * date))dateSelectBlock;

+ (instancetype)initWithMinDate:(NSDate *)minDate dateSelectBlock:(void(^)(NSDate * date))dateSelectBlock type:(int)type;
+ (instancetype)initWithBlock:(void(^)(NSDate * date))dateSelectBlock type:(int)type;

@end
