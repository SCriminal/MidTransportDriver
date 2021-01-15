//
//  RequestApi+Auth.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/11.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi+Auth.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import "RequestApi+Ums.h"

@implementation RequestApi (Auth)
/**
登出[^/auth/user/logout/token$]
*/
+(void)requestLogoutWithApp:(NSString *)app
                client:(NSString *)client
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"app":RequestStrKey(app),
                           @"client":RequestStrKey(client)};
        [self deleteUrl:@"/auth/user/logout/token" delegate:delegate parameters:dic success:success failure:failure];
}
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
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"app":RequestStrKey(app),
                           @"client":RequestStrKey(client),
                           @"password":RequestStrKey([password base64Encode]),
                           @"account":RequestStrKey(account),
                           @"terminalType":NSNumber.dou(terminalType),
                           @"terminalNumber":RequestStrKey([CloudPushSDK getDeviceId])
                              
        };
        [self postUrl:@"/auth/user/login/1" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
            if (!isDic(dic) || !isStr([response stringValueForKey:@"token"])) {
                if (failure) {
                    failure(nil,@"获取token失败");
                }
                return ;
            }
            [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
            [GlobalMethod writeStr:[GlobalMethod exchangeDate:[NSDate date] formatter:TIME_SEC_SHOW] forKey:LOCAL_LOGIN_TIME];

            [RequestApi requestUserInfo2WithDelegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [GlobalMethod requestLoginResponse:response  mark:mark success:success failure:failure];
            }  failure:failure];
        } failure:failure];
    
}


/**
修改密码[^/auth/password/1$]
*/
+(void)requestResetPwdWithOld:(NSString *)old
                new:(NSString *)new
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"old":RequestStrKey(old),
                           @"new":RequestStrKey(new)};
        [self putUrl:@"/auth/password/1" delegate:delegate parameters:dic success:success failure:failure];
}
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
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"app":RequestStrKey(app),
                           @"account":RequestStrKey(account),
                           @"smsCode":RequestStrKey(smsCode),
                           @"password":RequestStrKey(password),
                           @"userType":NSNumber.dou(userType)};
        [self putUrl:@"/auth/password/0" delegate:delegate parameters:dic success:success failure:failure];
}

/**
更新设备号
*/
+(void)requestRefreshDeviceWithApp:(NSString *)app
                client:(NSString *)client
                type:(double)type
                number:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"app":RequestStrKey(app),
                           @"client":RequestStrKey(client),
                           @"type":NSNumber.dou(type),
                           @"number":RequestStrKey(number)};
        [self putUrl:@"/auth/user/terminal/number" delegate:delegate parameters:dic success:success failure:failure];
}
/**
忘记密码验证码
*/
+(void)requestSmsForgetPwdWithApp:(NSString *)app
                account:(NSString *)account
                userType:(double)userType
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"app":RequestStrKey(app),
                           @"account":RequestStrKey(account),
                           @"userType":NSNumber.dou(userType)};
        [self postUrl:@"/auth/smscode" delegate:delegate parameters:dic success:success failure:failure];
}
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
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"userId":NSNumber.dou(userId),
                           @"headUrl":RequestStrKey(headUrl),
                           @"nickname":RequestStrKey(nickname),
                           @"account":RequestStrKey(account),
                           @"userType":NSNumber.dou(userType),
                           @"realName":RequestStrKey(realName),
                           @"ent":RequestStrKey(ent),
                           @"fleet":RequestStrKey(fleet)};
        [self putUrl:@"/auth/pvt/relation" delegate:delegate parameters:dic success:success failure:failure];
}


@end
