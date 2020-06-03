//
//  NSURL+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/6/30.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSURL+Category.h"

@implementation NSURL (Category)

//运行时 安全
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getClassMethod(self, @selector(URLWithString:)), class_getClassMethod(self, @selector(safeURLWithString:)));
    });
}

+ (NSURL *)safeURLWithString:(NSString *)string{
    if (isStr(string)) {
        return [self safeURLWithString:string];
    }else{
        return [self safeURLWithString:@""];
    }
}

@end
