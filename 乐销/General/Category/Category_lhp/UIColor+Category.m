//
//  UIColor+Category.m
//中车运
//
//  Created by 刘惠萍 on 2017/7/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)
+(UIColor *)colorWithHexString:(NSString *)str{
    return [self colorWithHexString:str alpha:1.0f];
}

+(UIColor *)colorWithHexString:(NSString *)str alpha:(double)alpha{
    
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor clearColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
    
}
@end
