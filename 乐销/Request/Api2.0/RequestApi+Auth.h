//
//  RequestApi+Auth.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/11.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Auth)
/**
登出[^/auth/user/logout/token$]
*/
+(void)requestLogoutWithApp:(NSString *)app
                client:(NSString *)client
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
登录（手机号、密码）-个人用户[^/auth/user/login/1$]
*/
+(void)requestLoginWithApp:(NSString *)app
                client:(NSString *)client
                password:(NSString *)password
                account:(NSString *)account
                terminalType:(double)terminalType
                terminalNumber:(NSString *)terminalNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestMatchCodeAccount:(NSString *)account
                          code:(NSString *)code
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
修改密码[^/auth/password/1$]
*/
+(void)requestResetPwdWithOld:(NSString *)old
                new:(NSString *)new
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
忘记密码[^/auth/password/0$]
*/
+(void)requestForgetPwdWithApp:(NSString *)app
                account:(NSString *)account
                smsCode:(NSString *)smsCode
                password:(NSString *)password
                userType:(double)userType
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
更新设备号
*/
+(void)requestRefreshDeviceWithApp:(NSString *)app
                client:(NSString *)client
                type:(double)type
                number:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
忘记密码验证码
*/
+(void)requestSmsForgetPwdWithApp:(NSString *)app
                account:(NSString *)account
                userType:(double)userType
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
修改用户信息
*/
+(void)requestResetUserInfoWithUserid:(double)userId
                headUrl:(NSString *)headUrl
                nickname:(NSString *)nickname
                account:(NSString *)account
                userType:(double)userType
                realName:(NSString *)realName
                ent:(NSString *)ent
                fleet:(NSString *)fleet
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 - 绑定设备
 */
+(void)requestBindDeviceIdWithDeviceID:(NSString *)device_id
                              delegate:(_Nullable id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

/**
校验
*/
+(void)requestVertifyImageCodeWithId:(double)id
                width:(double)width
                x:(double)x
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;

/**
获取
*/
+(void)requestFetchImageCodeWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
