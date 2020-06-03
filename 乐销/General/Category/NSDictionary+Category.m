//
//  NSDictionary+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/2/17.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSDictionary+Category.h"
#import "NSObject+Catrgory.h"

@implementation NSDictionary (Category)
+ (void)load{
    [self SwizzlingMethod:@"initWithObjects:forKeys:count:" systemClassString:@"__NSPlaceholderDictionary" toSafeMethodString:@"initWithObjects_st:forKeys:count:" targetClassString:@"NSDictionary"];
}
-(instancetype)initWithObjects_st:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }else{
            rightCount++;
        }
    }
    self = [self initWithObjects_st:objects forKeys:keys count:rightCount];
    return self;
}


@end
