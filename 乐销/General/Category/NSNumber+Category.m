//
//  NSNumber+Category.m
//中车运
//
//  Created by mengxi on 17/3/11.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSNumber+Category.h"

@implementation NSNumber (Category)
+(NSNumber *)exchangeStr:(NSString *)str{
    if (isStr(str)) {
        if ([str doubleValue]) {
            return [NSDecimalNumber numberWithDouble:[str doubleValue]];
        }
    }
    return @0;
    
}

+ (NSNumber * (^)(NSString *))str{
    return ^(NSString *str){
        if (isStr(str)) {
            if ([str doubleValue]) {
                return [NSDecimalNumber numberWithDouble:[str doubleValue]];
            }
        }
        return @0;
    };
}
+ (NSNumber * (^)(NSString *))lonFromStr{
    return ^(NSString *str){
        if (isStr(str)) {
            if ([str doubleValue]) {
                return [NSDecimalNumber numberWithLong:[str longLongValue]];
            }
        }
        return @0;
    };
}
+ (NSNumber *(^)(double))dou{
    return ^(double num){
        return [NSDecimalNumber numberWithDouble:num];
    };
}
+ (NSNumber *(^)(double))lon{
    return ^(double num){
        return [NSDecimalNumber numberWithLong:num];
    };
}
+ (double (^)(NSNumber *))douValue{
    return ^(NSNumber * num){
        if (isNum(num)) {
            return [num doubleValue];
        }
        return 0.;
    };
}

+ (NSNumber *)numberWithString:(NSString *)string {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *str = [[string stringByTrimmingCharactersInSet:set] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{@"true" :   @(YES),
                @"yes" :    @(YES),
                @"false" :  @(NO),
                @"no" :     @(NO),
                @"nil" :    [NSNull null],
                @"null" :   [NSNull null],
                @"<null>" : [NSNull null]};
    });
    id num = dic[str];
    if (num) {
        if (num == [NSNull null]) return nil;
        return num;
    }
    
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}
@end
