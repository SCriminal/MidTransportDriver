//
//  UIColor+Category.h
//中车运
//
//  Created by 刘惠萍 on 2017/7/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)
 +(UIColor *)colorWithHexString:(NSString *)str;
 +(UIColor *)colorWithHexString:(NSString *)str alpha:(double)alpha;
@end
