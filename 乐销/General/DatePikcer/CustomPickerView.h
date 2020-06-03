//
//  CustomPickerView.h
//中车运
//
//  Created by 隋林栋 on 2017/3/30.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, assign) NSInteger rowHeight;


/**
 *  查看datePicker当前选择的日期
 */
@property (nonatomic, strong, readonly) NSDate *date;


/**
 *  datePicker显示date
 */
- (void)selectDate:(NSDate *)date;

/**
 *  datePicker设置最小年份和最大年份
 */
- (void)setMinDate:(NSDate *)minDate;

-(instancetype)initWithDatePickerMode:(int)datePickerMode MinDate:(NSDate *)minDate MaxDate:(NSDate *)maxDate;

@end
