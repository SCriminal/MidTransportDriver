//
//  NSDate+CategorySld.m
//中车运
//
//  Created by 隋林栋 on 2017/3/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSDate+CategorySld.h"
//dateformatter
#import "NSDateFormatter+Category.h"

@implementation NSDate (CategorySld)
-(NSString *)formattedTimes{
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {//within one minute
        return @"刚刚";
    } else if (timeInterval < 3600) {//within one hour
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60.0];
    } else {//within one day
        NSInteger hour = [self hoursAfterDate:[NSDate currentDate]];
        NSDateFormatter *dateFormatter = nil;
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24) {
            return @"昨天";
        }else if (hour < -24 && hour >= -48) {
            return @"前天";
        }else if (hour >= -24*7 ) {
            NSString *weekday = @"";
            switch ([self weekday]) {
                case 1: weekday = @"星期日"; break;
                case 2: weekday = @"星期一"; break;
                case 3: weekday = @"星期二"; break;
                case 4: weekday = @"星期三"; break;
                case 5: weekday = @"星期四"; break;
                case 6: weekday = @"星期五"; break;
                case 7: weekday = @"星期六"; break;
                default:
                    break;
            }
            return [NSString stringWithFormat:@"%@",weekday];
//            dateFormatter = [NSDateFormatter dateFormatterWithFormat:[NSString stringWithFormat:@"%@ HH:mm",weekday]];
        } else if([[NSDate currentDate] year] == self.year) {//如果是同一年
           dateFormatter =  [NSDateFormatter dateFormatterWithFormat:TIME_DAY_CN];
        }else {
            dateFormatter =  [NSDateFormatter dateFormatterWithFormat:TIME_DAY_CN];
        }
        return [dateFormatter stringFromDate:self];
    }
}

- (BOOL)isToday{
    NSDate *today = [[NSDate alloc] init];
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * dateString = [[self description] substringToIndex:10];
    return [dateString isEqualToString:todayString];
}
- (BOOL)isTomorrow{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    NSString * dateString = [[self description] substringToIndex:10];
    
    return [dateString isEqualToString:tomorrowString];
}
- (BOOL)isYesterday{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *yesterday;
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    // 10 first characters of description is the calendar date:
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * dateString = [[self description] substringToIndex:10];
    return [dateString isEqualToString:yesterdayString];
}
+ (NSDate *)currentDate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian dateFromComponents:components];
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / 3600);
}
//获取本周一和周日
- (NSArray *)fetchWeekDays{
    // 本周的起止日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:self];
    // 得到星期几
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 9 - weekDay - 1;
    }
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    [comp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:comp];
    
    [comp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:comp];
    
    return @[firstDayOfWeek,lastDayOfWeek];
}
//获取本月第一天 最后一天
- (NSArray *)fetchMonthDays{
    // 本周的起止日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:self];
    [comp setDay:1];
    NSDate *firstDay= [calendar dateFromComponents:comp];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    [comp setDay:range.length];
    NSDate *lastDay= [calendar dateFromComponents:comp];
    return @[firstDay,lastDay];
}
//获取本季第一天 最后一天
- (NSArray *)fetchQuarterDays{
    // 本周的起止日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitQuarter
                                         fromDate:self];
    NSLog(@"quarter(季度):%li", (long)comp.quarter);

    [comp setDay:1];
    NSDate *firstDay= [calendar dateFromComponents:comp];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitQuarter forDate:self];
    [comp setDay:range.length];
    NSDate *lastDay= [calendar dateFromComponents:comp];
    return @[firstDay,lastDay];
}

- (BOOL)isEqualToDate:(NSDate *)aDate{
    if (!aDate) {
        return false;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *componentsDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:aDate];
    return componentsDate.year == componentsSelf.year && componentsDate.month == componentsSelf.month && componentsDate.day == componentsSelf.day;
}

//比较相差超过一天
- (BOOL)isBigThanOneDate:(NSDate *)date{
    if (date == nil) {
        return false;
    }
    double time = [date timeIntervalSinceDate:self];
    return time <= -24*60*60;
}

//比较相差超过一天
- (BOOL)isSmallThanOneDate:(NSDate *)date{
    if (date == nil) {
        return false;
    }
    double time = [date timeIntervalSinceDate:self];
    return time >= 24*60*60;
}
@end
