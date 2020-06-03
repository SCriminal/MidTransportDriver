//
//  NSNumber+Category.h
//中车运
//
//  Created by mengxi on 17/3/11.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Category)

@property (class,nonatomic, readonly) NSNumber * (^str)(NSString *);
@property (class,nonatomic, readonly) NSNumber * (^dou)(double);
@property (class,nonatomic, readonly) NSNumber * (^lon)(double);

@property (class,nonatomic, readonly) double (^douValue)(NSNumber *);


+(NSNumber *)exchangeStr:(NSString *)str;
+ (NSNumber *)numberWithString:(NSString *)string;
+ (NSNumber * (^)(NSString *))lonFromStr;
@end
