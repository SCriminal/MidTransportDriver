//
//  RequestApi+Dictionary.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/29.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Dictionary)

/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;



/**
 添加反馈
 */
+(void)requestAddFeedbackWithBetter:(NSString *)better
                                bad:(NSString *)bad
                                app:(NSString *)app
                        teminalType:(double)teminalType
                             userId:(double)userId
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 箱型下拉列表
 */
+(void)requestPackageTypeWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 银行列表
 */
+(void)requestBankListWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 删除
 */
+(void)requestDeleteBankCardWithId:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 新增
 */
+(void)requestAddBankCardWithAccountNumber:(NSString *)accountNumber
                                  bankName:(NSString *)bankName
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 更新
 */
+(void)requestEditBankCardWithAccountnumber:(NSString *)accountNumber
                                   bankName:(NSString *)bankName
                                         id:(double)identity
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 获取当前用户银行账户信息
 */
+(void)requestBankCardWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

@end

NS_ASSUME_NONNULL_END
