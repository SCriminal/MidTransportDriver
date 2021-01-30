//
//  RequestApi+Cash.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/26.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi+Cash.h"

@implementation RequestApi (Cash)
/**
列表
*/
+(void)requestCardListWithPage:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count)};
        [self getUrl:@"/cash/bank/card/user/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
新增
*/
+(void)requestAddCardWithAccountnumber:(NSString *)accountNumber
                bankId:(double)bankId
                accountName:(NSString *)accountName
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"accountNumber":RequestStrKey(accountNumber),
                           @"bankId":NSNumber.dou(bankId),
                           @"accountName":RequestStrKey(accountName)};
        [self postUrl:@"/cash/bank/card/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
编辑
*/
+(void)requestEditCardWithAccountnumber:(NSString *)accountNumber
                bankId:(double)bankId
                accountName:(NSString *)accountName
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"accountNumber":RequestStrKey(accountNumber),
                           @"bankId":NSNumber.dou(bankId),
                           @"accountName":RequestStrKey(accountName)};
        [self putUrl:@"/cash/bank/card/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
删除
*/
+(void)requestDeleteCardWithAccountnumber:(NSString *)accountNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"accountNumber":RequestStrKey(accountNumber)};
        [self deleteUrl:@"/cash/bank/card/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
详情
*/
+(void)requestCardDetailWithAccountnumber:(NSString *)accountNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"accountNumber":RequestStrKey(accountNumber)};
        [self getUrl:@"/cash/bank/card/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
详情(司机)
*/
+(void)requestPocketWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{};
        [self getUrl:@"/cash/cash/driver" delegate:delegate parameters:dic success:success failure:failure];
}

/**
交易列表(司机)
*/
+(void)requestDealListWithFlownumber:(NSString *)flowNumber
                srcNumber:(NSString *)srcNumber
                startTime:(double)startTime
                endTime:(double)endTime
                chargeTypes:(NSString *)chargeTypes
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"flowNumber":RequestStrKey(flowNumber),
                           @"srcNumber":RequestStrKey(srcNumber),
                           @"startTime":RequestLongKey(startTime),
                           @"endTime":RequestLongKey(endTime),
                           @"chargeTypes":RequestStrKey(chargeTypes),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count)};
        [self getUrl:@"/cash/flow/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
}
@end
