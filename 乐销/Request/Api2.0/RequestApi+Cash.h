//
//  RequestApi+Cash.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/26.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Cash)
/**
列表
*/
+(void)requestCardListWithPage:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
新增
*/
+(void)requestAddCardWithAccountnumber:(NSString *)accountNumber
                bankId:(double)bankId
                accountName:(NSString *)accountName
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

/**
编辑
*/
+(void)requestEditCardWithAccountnumber:(NSString *)accountNumber
                bankId:(double)bankId
                accountName:(NSString *)accountName
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
删除
*/
+(void)requestDeleteCardWithAccountnumber:(NSString *)accountNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
/**
详情
*/
+(void)requestCardDetailWithAccountnumber:(NSString *)accountNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
