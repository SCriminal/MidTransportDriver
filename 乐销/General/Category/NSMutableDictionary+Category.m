//
//  NSMutableDictionary+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/2/7.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSMutableDictionary+Category.h"
#import <objc/runtime.h>
#import "NSObject+Catrgory.h"

@implementation NSMutableDictionary (Category)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self SwizzlingMethod:@"setValue:forKey:" systemClassString:@"__NSDictionaryM" toSafeMethodString:@"sldSetValue:forKey:" targetClassString:@"NSMutableDictionary"];

                [self SwizzlingMethod:@"setObject:forKey:" systemClassString:@"__NSDictionaryM" toSafeMethodString:@"sldSetObject:forKey:" targetClassString:@"NSMutableDictionary"];
    });
}

- (void)sldSetValue:(id)value forKey:(NSString *)key{
    if (value == nil || key == nil) {
        return;
    }
    [self sldSetValue:value forKey:key];
}
- (void)sldSetObject:(id)value forKey:(NSString *)key{
    if (value == nil || key == nil) {
        return;
    }
    [self sldSetObject:value forKey:key];
}


@end
