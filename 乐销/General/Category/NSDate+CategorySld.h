//
//  NSDate+CategorySld.h
//中车运
//
//  Created by 隋林栋 on 2017/3/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CategorySld)
-(NSString *)formattedTimes;
- (BOOL)isEqualToDate:(NSDate *)aDate;//只比较年月日
- (BOOL)isBigThanOneDate:(NSDate *)date;//比较相差超过一天
- (BOOL)isSmallThanOneDate:(NSDate *)date;//比较相差超过一天
- (NSArray *)fetchWeekDays;//获取本周一和周日
- (NSArray *)fetchMonthDays;//获取本月第一天 最后一天
- (NSArray *)fetchQuarterDays;//获取本季第一天 最后一天
+ (NSDate *)currentDate;
@end
