//
//  RequestApi+UserAuth.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/16.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (UserAuth)


/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 登录
 */
+(void)requestLoginPwdWithPassword:(NSString *)password
                           account:(NSString *)account
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 修改密码
 */
+(void)requestChangePwdWithOldpassword:(NSString *)oldPassword
                           newPassword:(NSString *)newPassword
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 忘记密码
 */
+(void)requestForgetPwdWithApp:(NSString *)app
                       account:(NSString *)account
                          code:(NSString *)code
                      password:(NSString *)password
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 匹配验证码
 */
+(void)requestMatchCodeWithApp:(NSString *)app
                         phone:(NSString *)phone
                          code:(NSString *)code
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
