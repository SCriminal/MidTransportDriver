//
//  GlobalMethod+LocalDatas.m
//中车运
//
//  Created by 隋林栋 on 2017/1/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod+LocalDatas.h"
//global method origin
#import "GlobalMethod.h"

//exchange key to localKey has LOCAL_KEY prefix
#define EXCHANGE_LOCAL_KEY(key)         (key) = [(key) hasPrefix:LOCAL_KEY_HEAD]?(key):[NSString stringWithFormat:@"%@%@",LOCAL_KEY_HEAD,(key)]


@implementation GlobalMethod (LocalDatas)
#pragma mark clear user default
//clear local data of user
+ (void)clearUserDefault{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        if ([key isKindOfClass:[NSString class]] && [key hasPrefix:LOCAL_KEY_HEAD]) {
            [defs removeObjectForKey:key];
        }
    }
    [defs synchronize];
}

#pragma mark 存储本地数据
//model ary read write
+ (void)writeAry:(NSArray *)aryModels key:(NSString *)localKey{
    NSArray * aryFirm = [NSArray arrayWithArray:aryModels];
    NSMutableArray * aryMuDic = [NSMutableArray array];
    for (id model in aryFirm) {
        if ([model isKindOfClass:[NSDictionary class]]) {
            [aryMuDic addObject:model];
        }else{
            NSDictionary * dic = [GlobalMethod performSelector:@"dictionaryRepresentation" delegate:model object:nil isHasReturn:true];
            if (dic != nil) {
                [aryMuDic addObject:dic];
            }
        }
    }
    NSString * strJson = [GlobalMethod exchangeDicToJson:aryMuDic];
    [GlobalMethod writeStr:strJson forKey:localKey];
}
//读取model
+ (NSMutableArray *)readAry:(NSString *)localKey modelName:(NSString *)modelName{
    return [self readAry:localKey modelName:modelName exchangeToModel:nil];
}
+ (NSMutableArray *)readAry:(NSString *)localKey modelName:(NSString *)modelName exchangeToModel:(NSString *)returnModelName{
    NSMutableArray * aryReturn = [NSMutableArray array];
    NSString * strJson = [GlobalMethod readStrFromUser:localKey];
    if (!isStr(strJson)) {
        return  aryReturn;
    }
    NSArray * ary = [GlobalMethod exchangeStringToAry:strJson];
    if (!isAry(ary)) {
        return aryReturn;
    }
    NSMutableArray * aryModels = [GlobalMethod exchangeDic:ary toAryWithModelName:modelName];
    if (isStr(returnModelName)) {
        return [aryModels exchangeToModel:returnModelName];
    }
    return aryModels;
}
//model read  write
+ (void)writeModel:(id)model key:(NSString *)localKey{
    [self writeModel:model key:localKey exchange:true];
}
+ (void)writeModel:(id)model key:(NSString *)localKey exchange:(BOOL)exchange{
    if (!model) {
        [GlobalMethod writeStr:@"" forKey:localKey exchange:exchange];
        return;
    }
    NSDictionary * dic = model;
    if ([model respondsToSelector:NSSelectorFromString(@"dictionaryRepresentation")] ) {
        dic = [GlobalMethod performSelector:@"dictionaryRepresentation" delegate:model object:nil isHasReturn:true];
    }
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        NSString * strJson = [GlobalMethod exchangeDicToJson:dic];
        [GlobalMethod writeStr:strJson forKey:localKey exchange:exchange];
    }
}
+ (id)readModelForKey:(NSString *)localKey modelName:(NSString *)modelName{
    return [self readModelForKey:localKey modelName:modelName exchange:true];
}
+ (id)readModelForKey:(NSString *)localKey modelName:(NSString *)modelName exchange:(BOOL)exchange{
    NSString * strJson = [GlobalMethod readStrFromUser:localKey exchange:exchange];
    if (!isStr(strJson)) {
        return  nil;
    }
    NSDictionary * dicLocal = [GlobalMethod exchangeStringToDic:strJson];
    if (dicLocal && [dicLocal isKindOfClass:[NSDictionary class]]) {
        return [self exchangeDicToModel:dicLocal modelName:modelName];
    }
    return nil;
}

//str read write
+ (void)writeStr:(NSString *)strValue forKey:(NSString *)strKey{
    [self writeStr:strValue forKey:strKey exchange:true];
}
+ (void)writeStr:(NSString *)strValue forKey:(NSString *)strKey exchange:(BOOL)exchange{
    if (isStr(strKey) ) {
        if (exchange) {
            EXCHANGE_LOCAL_KEY(strKey);
        }
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:strValue  forKey:strKey];
        [user synchronize];
    }
}
+ (NSString *)readStrFromUser:(NSString *)strKey{
    return [self readStrFromUser:strKey exchange:true];
}
+ (NSString *)readStrFromUser:(NSString *)strKey exchange:(BOOL)exchange{
    if (isStr(strKey)) {
        if (exchange) {
            EXCHANGE_LOCAL_KEY(strKey);
        }
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * strValue = [user objectForKey:strKey];
        if (strValue != nil && [strValue isKindOfClass:[NSString class]]&& strValue.length>0) {
            return strValue;
        }
    }
    return @"";
}
//date read write
+ (void)writeDate:(NSDate *)date  forKey:(NSString *)strKey{
    EXCHANGE_LOCAL_KEY(strKey);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:date?date:@""  forKey:strKey];
    [user synchronize];
}
+ (NSDate *)readDateFromUser:(NSString *)strKey{
    EXCHANGE_LOCAL_KEY(strKey);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDate * dateLocal = [user objectForKey:strKey];
    return (dateLocal && [dateLocal isKindOfClass:[NSDate class]]) ?dateLocal:nil;
}

//data rea write
+ (void)writeDataToUser:(NSData *)data forKey:(NSString *)strKey{
    EXCHANGE_LOCAL_KEY(strKey);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:data  forKey:strKey];
    [user synchronize];
}
+ (NSData *)readDataFromUser:(NSString *)strKey{
    EXCHANGE_LOCAL_KEY(strKey);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSData * dataLocal = [user objectForKey:strKey];
    return dataLocal;
}
//bool read write
+ (void)writeBool:(BOOL)bol local:(NSString *)strKey{
    [self writeBool:bol local:strKey exchangeKey:true];
}
+ (void)writeBool:(BOOL)bol local:(NSString *)strKey exchangeKey:(BOOL)exchangeKey{
    if (!isStr(strKey)) return;
    if (exchangeKey) {
        EXCHANGE_LOCAL_KEY(strKey);
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:[NSNumber numberWithBool:bol] forKey:strKey];
    [user synchronize];
}
+ (BOOL)readBoolLocal:(NSString *)strKey{
    return [self readBoolLocal:strKey exchangeKey:true];
}
+ (BOOL)readBoolLocal:(NSString *)strKey exchangeKey:(BOOL)exchangeKey{
    if (!isStr(strKey)) return NO;
    if (exchangeKey) {
        EXCHANGE_LOCAL_KEY(strKey);
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [user objectForKey:strKey];
    if (num == nil) return NO;
    return [num boolValue];
}

//write to json file
+ (NSString *)writeToLocalFile:(id)response{
    if (!response) {
        return @"";
    }
    NSString * strJson = @"";
    if ([response isKindOfClass:NSDictionary.self]||[response isKindOfClass:NSArray.self]) {
        strJson = [GlobalMethod exchangeDicToJson:response];
    }
    if ([response isKindOfClass:NSString.self]) {
        strJson = (NSString *)response;
    }
    NSString * strPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"response.json"];
    [strJson writeToFile:strPath atomically:true encoding:NSUTF8StringEncoding error:nil];
    return strPath;
}

@end
