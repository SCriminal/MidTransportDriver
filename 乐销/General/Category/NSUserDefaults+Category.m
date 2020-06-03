//
//  NSUserDefaults+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/6/30.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSUserDefaults+Category.h"
#import <objc/runtime.h>

@implementation NSUserDefaults (Category)
//运行时 安全
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(setObject:forKey:)), class_getInstanceMethod(self, @selector(safeSetObject:forKey:)));

    });
}


- (void)safeSetObject:(id)value forKey:(NSString *)key{
    if (key && [key isKindOfClass:[NSString class]]) {
        if (!value || [value isEqual:[NSNull null]]) {
            //如果为value 为空
            id valueOrigin = [self objectForKey:key];
            if (!valueOrigin) {
                return;
            }else if ([valueOrigin isKindOfClass:[NSString class]]) {
                [self safeSetObject:@"" forKey:key];
            }else if ([valueOrigin isKindOfClass:[NSNumber class]]) {
                [self safeSetObject:[NSNumber numberWithInt:0] forKey:key];
            }else if ([valueOrigin isKindOfClass:[NSArray class]]) {
                [self safeSetObject:@[] forKey:key];
            }else if ([valueOrigin isKindOfClass:[NSDictionary class]]) {
                [self safeSetObject:@{} forKey:key];
            }
        }else{
            [self safeSetObject:value forKey:key];
        }
    }
}


@end
