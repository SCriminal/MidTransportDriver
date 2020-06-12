//
//  RequestApi+UserApi.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/16.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+UserApi.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
@implementation RequestApi (UserApi)

/**
 用户注册
 */
+(void)requestRegisterWithApp:(NSString *)app
                    cellPhone:(NSString *)cellPhone
                     password:(NSString *)password
                         code:(NSString *)code
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"cellPhone":RequestStrKey(cellPhone),
                          @"password":RequestStrKey(password),
                          @"code":RequestStrKey(code)};
    [self postUrl:@"/ums/user/register/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 验证码登陆
 */
+(void)requestLoginCodeWithApp:(NSString *)app
                         scene:(NSString *)scene
                     cellPhone:(NSString *)cellPhone
                          code:(NSString *)code
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"scene":@"1",
                          @"cellPhone":RequestStrKey(cellPhone),
                          @"code":RequestStrKey(code),
                          @"terminalType":@1,
                          @"terminalNumber":RequestStrKey( [CloudPushSDK getDeviceId])
                          };
    [self postUrl:@"/ums/user/login/code" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        if (!isDic(dic) || !isStr([response stringValueForKey:@"token"])) {
            if (failure) {
                failure(nil,@"获取token失败");
            }
            return ;
        }
        [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];

        [self requestUserInfoWithDelegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod requestLoginResponse:response mark:mark success:success failure:failure];
        }  failure:failure];
    } failure:failure];
}
/**
 获取审核信息
 */
+(void)requestUserAuthorityInfoWithDelegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/user/review/1_8_4/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取审核通过的信息
 */
+(void)requestUserAuthoritySuccessInfoWithDelegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/user/review/1_8_28/1/3" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 提交审核信息
 */
+(void)requestSubmitAuthorityInfoWithDriverlicenseurl:(NSString *)driverLicenseUrl
                                       idCardFrontUrl:(NSString *)idCardFrontUrl
                                        idCardBackUrl:(NSString *)idCardBackUrl
                                      idCardHandelUrl:( NSString *_Nullable)idCardHandelUrl
                                             realName:(NSString *)realName
                                             idNumber:(NSString *)idNumber
                                             delegate:(id <RequestDelegate>)delegate
                                              success:(void (^)(NSDictionary * response, id mark))success
                                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"driverLicenseUrl":RequestStrKey(driverLicenseUrl),
                          @"idCardFrontUrl":RequestStrKey(idCardFrontUrl),
                          @"idCardBackUrl":RequestStrKey(idCardBackUrl),
                          @"idCardHandelUrl":RequestStrKey(idCardHandelUrl),
                          @"realName":RequestStrKey(realName),
                          @"idNumber":RequestStrKey(idNumber),
                          };
    [self postUrl:@"/ums/user/review/1_8_27/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 修改基础信息
 */
+(void)requestChangeUserInfoWithNickname:(NSString *)nickname
                                 headUrl:(NSString *)headUrl
                                  gender:(NSString *)gender
                                birthday:(NSString *)birthday
                            contactPhone:(NSString *)contactPhone
                                  areaId:(NSString *)areaId
                                 address:(NSString *)address
                                   email:(NSString *)email
                                  weChat:(NSString *)weChat
                               introduce:(NSString *)introduce
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"nickname":RequestStrKey(nickname),
                          @"headUrl":RequestStrKey(headUrl),
                          @"gender":RequestStrKey(gender),
                          @"birthday":RequestStrKey(birthday),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"areaId":RequestStrKey(areaId),
                          @"address":RequestStrKey(address),
                          @"email":RequestStrKey(email),
                          @"weChat":RequestStrKey(weChat),
                          @"introduce":RequestStrKey(introduce)};
    [self patchUrl:@"/ums/user/common/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取基础信息
 */
+(void)requestUserInfoWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/user/common/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取验证码
 */
+(void)requestFetchCodeWithApp:(NSString *)app
                     cellPhone:(NSString *)cellPhone
                       smsType:(NSString *)smsType
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"cellPhone":RequestStrKey(cellPhone),
                          @"smsType":RequestStrKey(smsType)};
    [self postUrl:@"/ums/user/sms/code" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 版本升级
 */
+(void)requestVersionWithDelegate:(_Nullable id<RequestDelegate> )delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"terminalType":@1,
                          @"versionNumber":[GlobalMethod getVersion]};
    [self getUrl:@"/zhongcheyun/version/new" delegate:delegate parameters:dic success:success failure:failure];
    
}

/**
 添加版本信息
 */
+(void)requestAddVersionWithForceUpdate:(BOOL)ForceUpdate
                          versionNumber:(NSString *)versionNumber
                            description:(NSString *)description
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"1",
                          @"terminalType":@1,
                          @"versionType":ForceUpdate?@2:@1,
                          @"bundleId":[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"],
                          @"downloadUrl":@"https://apps.apple.com/cn/app/中车运司机端/id1440250870?l=zh&ls=1",
                          @"versionNumber":RequestStrKey(versionNumber),
                          @"releaseTime":NSNumber.lon([[NSDate date]timeIntervalSince1970]),
                          @"description":RequestStrKey(description)};
    [self postUrl:@"/zhongcheyun/version" delegate:delegate parameters:dic success:success failure:failure];
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
    NSDictionary *dic = @{@"app":@"1",
                          @"scene":@"1",
                          @"type":@1,
                          @"number":deviceID};
    [self patchUrl:@"/ums/user/terminal/number" delegate:delegate parameters:dic success:success failure:failure];
    
}

/**
 车队列表（司机）
 */
+(void)requestMotorcadeListWithDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/ent/driver/fleet/list/option" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 我的车队列表（司机端）
 */
+(void)requestAttachedCompanyListWithPage:(double)page
                                    count:(double)count
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/zhongcheyun/ent/1_0_75/list/driver/fleet/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 挂靠申请列表（司机）
 */
+(void)requestAttacApplyCompanyListWithPage:(double)page
                                      count:(double)count
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"state":@1,
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/zhongcheyun/driverdependent/1_0_75/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 token登录/时效延长
 */
+(void)requestExtendTokenSuccess:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    if (!isStr([GlobalData sharedInstance].GB_Key)) {
        return;
    }
    NSDictionary *dic = @{@"app":@"1",
                          @"scene":@"1",
                          @"token":[GlobalData sharedInstance].GB_Key
                          };
    [self postUrl:@"/ums/auth/token/1_8_17/login" delegate:nil parameters:dic success:success failure:failure];
}

@end
