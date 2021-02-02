//
//  RequestApi+Integral.h
//  Driver
//
//  Created by 隋林栋 on 2021/2/2.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Integral)
/**
每日签到[^/zhongcheyun/point/day$]
*/
+(void)requestSignWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
获取[^/zhongcheyun/point$]
*/
+(void)requestIntegralNumWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
列表（签到）[^/zhongcheyun/point/log/list/sign/total$]
*/
+(void)requestSignListDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
列表[^/zhongcheyun/point/sku/list/total$]
*/
+(void)requestIntegralProductListWithPage:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

/**
新增(兑换)
*/
+(void)requestExchangeProductWithSkuid:(NSString *)skuId
                qty:(double)qty
                addrId:(double)addrId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestIntegralOrderListWithPage:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
