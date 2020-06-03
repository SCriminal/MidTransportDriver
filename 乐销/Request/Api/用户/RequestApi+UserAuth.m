//
//  RequestApi+UserAuth.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/16.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+UserAuth.h"
#import "RequestApi+UserApi.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
@implementation RequestApi (UserAuth)

/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"scene":@"1"};
    [self deleteUrl:@"/ums/auth/logout" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
        
    } failure: ^(NSString * errorStr, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
    }];
}
/**
 登录
 */
+(void)requestLoginPwdWithPassword:(NSString *)password
                           account:(NSString *)account
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"scene":@"1",
                          @"password":RequestStrKey([password base64Encode]),
                          @"mode":@1,
                          @"account":RequestStrKey(account),
                          @"terminalType":@1,
                          @"terminalNumber":RequestStrKey([CloudPushSDK getDeviceId])
                          };
    [self postUrl:@"/ums/auth/login" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        if (!isDic(dic) || !isStr([response stringValueForKey:@"token"])) {
            if (failure) {
                failure(nil,@"获取token失败");
            }
            return ;
        }
        [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
        
        [RequestApi requestUserInfoWithDelegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod requestLoginResponse:response  mark:mark success:success failure:failure];
        }  failure:failure];
    } failure:failure];
}
/**
 修改密码
 */
+(void)requestChangePwdWithOldpassword:(NSString *)oldPassword
                           newPassword:(NSString *)newPassword
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"oldPassword":RequestStrKey([oldPassword base64Encode]),
                          @"newPassword":RequestStrKey([newPassword base64Encode])};
    [self patchUrl:@"/ums/auth/password" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 忘记密码
 */
+(void)requestForgetPwdWithApp:(NSString *)app
                       account:(NSString *)account
                          code:(NSString *)code
                      password:(NSString *)password
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"account":RequestStrKey(account),
                          @"code":RequestStrKey(code),
                          @"password":RequestStrKey([password base64Encode])};
    [self patchUrl:@"/ums/auth/password/forget" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 匹配验证码
 */
+(void)requestMatchCodeWithApp:(NSString *)app
                         phone:(NSString *)phone
                          code:(NSString *)code
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"phone":RequestStrKey(phone),
                          @"code":RequestStrKey(code)};
    [self postUrl:@"/ums/user/sms/verification/code" delegate:delegate parameters:dic success:success failure:failure];
}

@end
