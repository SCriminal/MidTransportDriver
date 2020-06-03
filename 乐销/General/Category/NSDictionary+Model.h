//
//  NSDictionary+Model.h
//中车运
//
//  Created by liuhuiping on 2017/11/29.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Model)
- (double)doubleValueForKey:(NSString *)key;
- (int)intValueForKey:(NSString *)key;
- (BOOL)boolValueForKey:(NSString *)key;
- (NSNumber *)numberValueForKey:(NSString *)key;
- (NSString *)stringValueForKey:(NSString *)key;
- (NSArray *)arrayValueForKey:(NSString *)key;
- (NSDictionary *)dictionaryValueForKey:(NSString *)key;
@end
