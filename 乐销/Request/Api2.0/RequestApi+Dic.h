//
//  RequestApi+Dic.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/19.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Dic)

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
 ocr
 */
+(void)requestOCRIdentityWithurl:(NSString *)url
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestOCRDriverWithurl:(NSString *)url
                          side:(NSString *)side
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestOCRBusinessWithurl:(NSString *)url
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestOCRRunWithurl:(NSString *)url
                          side:(NSString *)side
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
