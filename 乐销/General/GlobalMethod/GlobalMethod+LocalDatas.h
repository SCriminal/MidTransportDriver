//
//  GlobalMethod+LocalDatas.h
//中车运
//
//  Created by 隋林栋 on 2017/1/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod.h"

@interface GlobalMethod (LocalDatas)
//模块数据读存
+ (void)writeAry:(NSArray *)aryModels key:(NSString *)localKey;
//model数据读存
+ (void)writeModel:(id)model key:(NSString *)localKey;
+ (void)writeModel:(id)model key:(NSString *)localKey exchange:(BOOL)exchange;
+ (id)readModelForKey:(NSString *)localKey modelName:(NSString *)modelName;
+ (id)readModelForKey:(NSString *)localKey modelName:(NSString *)modelName exchange:(BOOL)exchange;

+ (NSMutableArray *)readAry:(NSString *)localKey modelName:(NSString *)modelName;
+ (NSMutableArray *)readAry:(NSString *)localKey modelName:(NSString *)modelName exchangeToModel:(NSString *)returnModelName;
+ (NSString *)writeToLocalFile:(id)response;
//清空本地数据
+ (void)clearUserDefault;

#pragma mark 存储本地数据
+ (void)writeStr:(NSString *)strValue forKey:(NSString *)strKey;
+ (void)writeStr:(NSString *)strValue forKey:(NSString *)strKey exchange:(BOOL)exchange;
+ (NSString *)readStrFromUser:(NSString *)strKey;
+ (NSString *)readStrFromUser:(NSString *)strKey exchange:(BOOL)exchange;
+ (void)writeDate:(NSDate *)date  forKey:(NSString *)strKey;
+ (void)writeBool:(BOOL)bol local:(NSString *)noti;
+ (void)writeBool:(BOOL)bol local:(NSString *)strKey exchangeKey:(BOOL)exchangeKey;
+ (BOOL)readBoolLocal:(NSString *)noti;
+ (BOOL)readBoolLocal:(NSString *)strKey exchangeKey:(BOOL)exchangeKey;
+ (NSDate *)readDateFromUser:(NSString *)strKey;
+ (void)writeDataToUser:(NSData *)data forKey:(NSString *)strKey;
+ (NSData *)readDataFromUser:(NSString *)strKey;

@end
