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
        NSDictionary *dic = @{@"app":REQUEST_APP,
                           @"client":REQUEST_CLIENT};
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
                 captchaId:(double)captchaId
              captchaWidth:(double)captchaWidth
                  captchaX:(double)captchaX
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"app":REQUEST_APP,
                           @"client":REQUEST_CLIENT,
                           @"password":RequestStrKey([password base64Encode]),
                           @"phone":RequestStrKey(account),
                           @"terminalType":@4,
                           @"terminalNumber":RequestStrKey([CloudPushSDK getDeviceId]),
                              @"scope":@"1",
                              @"captchaId":RequestLongKey(captchaId),
                                             @"captchaWidth":RequestLongKey(captchaWidth),
                                             @"captchaX":RequestLongKey(captchaX),
        };
        [self postUrl:@"/ums/user/login/1" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
            if (!isDic(dic) || !isStr([response stringValueForKey:@"token"])) {
                if (failure) {
                    failure(nil,@"获取token失败");
                }
                return ;
            }
            [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
            [GlobalData sharedInstance].GB_REFRESH_TOKEN = [response stringValueForKey:@"refreshToken"];
            [GlobalMethod writeStr:[GlobalMethod exchangeDate:[NSDate date] formatter:TIME_SEC_SHOW] forKey:LOCAL_LOGIN_TIME];

            [RequestApi requestUserInfo2WithDelegate:delegate success:^(NSDictionary * _Nonnull responseUser, id  _Nonnull mark) {
                [GlobalMethod requestLoginResponse:responseUser                    isVehicle:[response doubleValueForKey:@"isVehicle"]
                                           isUser1:[response doubleValueForKey:@"isUser1"] user1Auth:[response doubleValueForKey:@"user1Auth"] 
 mark:mark  success:success failure:failure];
            }  failure:failure];
        } failure:failure];
    
}
/**
*/
+(void)requestMatchCodeAccount:(NSString *)account
                          code:(NSString *)code
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":REQUEST_APP,
                       @"account":RequestStrKey(account),
                       @"code":RequestStrKey(code),
                          @"scope":@"1"
    };
    [self getUrl:@"/auth/sms/code" delegate:delegate parameters:dic success:success failure:failure];
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
                           @"new":RequestStrKey(new),
                              @"scope":@"1"
        };
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
        NSDictionary *dic = @{@"app":REQUEST_APP,
                           @"account":RequestStrKey(account),
                           @"smsCode":RequestStrKey(smsCode),
                           @"password":RequestStrKey([password base64Encode]),
                           @"userType":NSNumber.dou(userType),
                              @"scope":@"1",
        };
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
        NSDictionary *dic = @{@"app":REQUEST_APP,
                           @"client":REQUEST_CLIENT,
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
        NSDictionary *dic = @{@"app":REQUEST_APP,
                           @"account":RequestStrKey(account),
                              @"scope":@"1",
                           @"userType":NSNumber.dou(userType)};
        [self getUrl:@"/auth/sms/code/2" delegate:delegate parameters:dic success:success failure:failure];
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

/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":REQUEST_APP,
                          @"client":REQUEST_CLIENT};
    [self deleteUrl:@"/auth/user/logout/token" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
        
    } failure: ^(NSString * errorStr, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
    }];
}

/**
 - 绑定设备
 */
+(void)requestBindDeviceIdWithDeviceID:(NSString *)device_id
                              delegate:(_Nullable id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    //
    NSString * deviceID = [CloudPushSDK getDeviceId];
    if (!isStr(deviceID)) {
        return;
    }
    NSDictionary *dic = @{@"app":REQUEST_APP,
                          @"client":REQUEST_CLIENT,
                          @"type":REQUEST_TERMINALTYPE,
                          @"number":deviceID};
    [self putUrl:@"/auth/user/terminal/number" delegate:delegate parameters:dic success:success failure:failure];
    
}

/**
校验
*/
+(void)requestVertifyImageCodeWithId:(double)identity
phone:(NSString *)phone
                width:(double)width
                x:(double)x
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{
            @"id":NSNumber.lon(identity),
                           @"width":NSNumber.lon(width),
                           @"x":NSNumber.lon(x),
                              @"scope":@"1",
                              @"phone":RequestStrKey(phone),
        };
        [self postUrl:@"/auth/captcha/2_0_5/3" delegate:delegate parameters:dic success:success failure:failure];
}
/**
获取
*/
+(void)requestFetchImageCodeWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{ @"method":@"",
                           @"scope":@"1",};
        [self getUrl:@"/auth/captcha/2_0_5/3" delegate:delegate parameters:dic success:success failure:failure];
}
@end
