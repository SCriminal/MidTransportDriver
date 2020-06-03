//
//  NSDateFormatter+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/3/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)
+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}
@end
