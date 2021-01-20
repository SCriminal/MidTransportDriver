//
//  RequestApi+Ums.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/11.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi+Ums.h"
#import <CloudPushSDK/CloudPushSDK.h>

@implementation RequestApi (Ums)
/**
 获取更换手机号[^/ums/sms/code/4$]
 */
+(void)requestResetPhoneCodeWithAppid:(NSString *)appId
                                phone:(NSString *)phone
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":RequestStrKey(appId),
                          @"phone":RequestStrKey(phone),
                          @"scope":@"1",

    };
    [self getUrl:@"/ums/sms/code/4" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取注册验证码[^/ums/sms/code/1$]
 */
+(void)requestResignCodeWithAppid:(NSString *)appId
                            phone:(NSString *)phone
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":RequestStrKey(appId),
                          @"phone":RequestStrKey(phone),
                          @"scope":@"1",

    };
    [self getUrl:@"/ums/sms/code/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取登录验证码[^/ums/sms/code/3$]
 */
+(void)requestLoginCodeWithAppid:(NSString *)appId
                           phone:(NSString *)phone
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":RequestStrKey(appId),
                          @"phone":RequestStrKey(phone),
                          @"scope":@"1",

    };
    [self getUrl:@"/ums/sms/code/3" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 修改[^/ums/user$]
 */
+(void)requestResetUserInfoWithNickname:(NSString *)nickname
                                headUrl:(NSString *)headUrl
                                  email:(NSString *)email
                               birthday:(double)birthday
                                 gender:(NSString *)gender
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"nickname":RequestStrKey(nickname),
                          @"headUrl":RequestStrKey(headUrl),
                          @"email":RequestStrKey(email),
                          @"gender":RequestStrKey(gender),
                          @"birthday":NSNumber.dou(birthday)};
    [self putUrl:@"/ums/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 更改手机号[^/ums/user/cellphone/3$]
 */
+(void)requestResetPhoneWithAppid:(NSString *)appId
                     oldCellphone:(NSString *)oldCellphone
                     newCellphone:(NSString *)newCellphone
                             code:(NSString *)code
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":RequestStrKey(appId),
                          @"oldCellphone":RequestStrKey(oldCellphone),
                          @"newCellphone":RequestStrKey(newCellphone),
                          @"code":RequestStrKey(code),
                          @"scope":@"1",

    };
    [self putUrl:@"/ums/user/cellphone/3" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取[^/ums/user$]
 */
+(void)requestUserInfo2WithDelegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 验证码登录（个人）[^/ums/login/1$]
 */
+(void)requestLoginWithAppid:(NSString *)appId
                    clientId:(NSString *)clientId
                       phone:(NSString *)phone
                        code:(NSString *)code
                    delegate:(id <RequestDelegate>)delegate
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":RequestStrKey(appId),
                          @"client":RequestStrKey(clientId),
                          @"phone":RequestStrKey(phone),
                          @"code":RequestStrKey(code),
                          @"terminalType":@1,
                          @"scope":@"1",
                          @"terminalNumber":RequestStrKey( [CloudPushSDK getDeviceId])
    };
    [self postUrl:@"/ums/login/1" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        if (!isDic(dic) || !isStr([response stringValueForKey:@"token"])) {
            if (failure) {
                failure(nil,@"获取token失败");
            }
            return ;
        }
        [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
        [GlobalData sharedInstance].GB_REFRESH_TOKEN = [response stringValueForKey:@"refreshToken"];
        [GlobalMethod writeStr:[GlobalMethod exchangeDate:[NSDate date] formatter:TIME_SEC_SHOW] forKey:LOCAL_LOGIN_TIME];
        [self requestUserInfo2WithDelegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod requestLoginResponse:response mark:mark success:success failure:failure];
        }  failure:failure];
    } failure:failure];
}

/**
 评价详情
 */
+(void)requestUserCommentDetailWithDelegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/evaluate" delegate:delegate parameters:dic success:success failure:failure];
}


/**
提交认证信息（整合）
*/
+(void)requestAuthUpAllWithDriverjson:(NSString *)driverJson
                serviceJson:(NSString *)serviceJson
                vehicleJson:(NSString *)vehicleJson
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"driver":RequestStrKey(driverJson),
                           @"service":RequestStrKey(serviceJson),
                           @"vehicle":RequestStrKey(vehicleJson)};
        [self postUrl:@"/ums/all" delegate:delegate parameters:dic success:success failure:failure];
}
/**
提交司机信息[^/ums/driver$]
*/
+(NSDictionary *)requestAuthDriverWithIdcardnationalemblemurl:(NSString *)idEmblemUrl
                idFaceUrl:(NSString *)idFaceUrl
                driverUrl:(NSString *)driverUrl
                vehicleUrl:(NSString *)vehicleUrl
                name:(NSString *)name
                idNumber:(NSString *)idNumber
                idBirthday:(NSString *)idBirthday
                idGender:(NSString *)idGender
                idNation:(NSString *)idNation
                idOrg:(NSString *)idOrg
                idAddr:(NSString *)idAddr
                driverNationality:(NSString *)driverNationality
                driverGender:(NSString *)driverGender
                driverBirthday:(NSString *)driverBirthday
                driverClass:(NSString *)driverClass
                driverArchivesNumber:(NSString *)driverArchivesNumber
                driverFirstIssueDate:(NSString *)driverFirstIssueDate
                                                    isRequest:(BOOL)isRequest
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"idEmblemUrl":RequestStrKey(idEmblemUrl),
                           @"idFaceUrl":RequestStrKey(idFaceUrl),
                           @"driverUrl":RequestStrKey(driverUrl),
                           @"vehicleUrl":RequestStrKey(vehicleUrl),
                           @"name":RequestStrKey(name),
                           @"idNumber":RequestStrKey(idNumber),
                           @"idBirthday":RequestStrKey(idBirthday),
                           @"idGender":RequestStrKey(idGender),
                           @"idNation":RequestStrKey(idNation),
                           @"idOrg":RequestStrKey(idOrg),
                           @"idAddr":RequestStrKey(idAddr),
                           @"driverNationality":RequestStrKey(driverNationality),
                           @"driverGender":RequestStrKey(driverGender),
                           @"driverBirthday":RequestStrKey(driverBirthday),
                           @"driverClass":RequestStrKey(driverClass),
                           @"driverArchivesNumber":RequestStrKey(driverArchivesNumber),
                           @"driverFirstIssueDate":RequestStrKey(driverFirstIssueDate)};
    if (isRequest) {
        [self postUrl:@"/ums/driver" delegate:delegate parameters:dic success:success failure:failure];
    }
    return dic;
}
/**
提交车辆认证信息
*/
+(NSDictionary *)requestAuthCarWithPlatenumber:(NSString *)plateNumber
                vehicleType:(double)vehicleType
                owner:(NSString *)owner
                grossMass:(double)grossMass
                approvedLoad:(double)approvedLoad
                vehicleLength:(double)vehicleLength
                vehicleWidth:(double)vehicleWidth
                vehicleHeight:(double)vehicleHeight
                driving1Url:(NSString *)driving1Url
                driving2Url:(NSString *)driving2Url
                driving3Url:(NSString *)driving3Url
                plateColor:(double)plateColor
                energyType:(double)energyType
                tractionMass:(double)tractionMass
                drivingEndTime:(double)drivingEndTime
                useCharacter:(NSString *)useCharacter
                unladenMass:(double)unladenMass
                vin:(NSString *)vin
                drivingRegisterDate:(double)drivingRegisterDate
                engineNumber:(NSString *)engineNumber
                drivingIssueDate:(double)drivingIssueDate
                model:(NSString *)model
                rtbpNumber:(NSString *)rtbpNumber
                                     isRequest:(BOOL)isRequest
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"plateNumber":RequestStrKey(plateNumber),
                           @"vehicleType":NSNumber.dou(vehicleType),
                           @"owner":RequestStrKey(owner),
                           @"grossMass":NSNumber.dou(grossMass/1000.0),
                           @"approvedLoad":NSNumber.dou(approvedLoad),
                           @"vehicleLength":NSNumber.lon(vehicleLength),
                           @"vehicleWidth":NSNumber.lon(vehicleWidth),
                           @"vehicleHeight":NSNumber.lon(vehicleHeight),
                           @"driving1Url":RequestStrKey(driving1Url),
                           @"driving2Url":RequestStrKey(driving2Url),
                           @"driving3Url":RequestStrKey(driving3Url),
                           @"plateColor":NSNumber.dou(plateColor),
                           @"energyType":NSNumber.dou(energyType),
                           @"tractionMass":NSNumber.dou(tractionMass),
                           @"drivingEndTime":NSNumber.dou(drivingEndTime),
                           @"useCharacter":RequestStrKey(useCharacter),
                           @"unladenMass":NSNumber.dou(unladenMass),
                           @"vin":RequestStrKey(vin),
                           @"drivingRegisterDate":NSNumber.dou(drivingRegisterDate),
                           @"engineNumber":RequestStrKey(engineNumber),
                           @"drivingIssueDate":NSNumber.dou(drivingIssueDate),
                           @"model":RequestStrKey(model),
                           @"rtbpNumber":RequestStrKey(rtbpNumber)};
    if (isRequest) {
        [self postUrl:@"http://192.168.20.27:10000/ums/vehicle" delegate:delegate parameters:dic success:success failure:failure];
    }
    return dic;
}
/**
提交营运认证信息[^/ums/service$]
*/
+(NSDictionary *)requestAuthBusinessWithQualificationurl:(NSString *)qualificationUrl
                roadUrl:(NSString *)roadUrl
                qualificationNumber:(NSString *)qualificationNumber
                roadNumber:(NSString *)roadNumber
                qcAddr:(NSString *)qcAddr
                qcIssueDate:(NSString *)qcIssueDate
                qcAgency:(NSString *)qcAgency
                qcNationality:(NSString *)qcNationality
                qcCategory:(NSString *)qcCategory
                qcName:(NSString *)qcName
                qcDriverClass:(NSString *)qcDriverClass
                qcGender:(NSString *)qcGender
                qcBirthday:(NSString *)qcBirthday
                rtpWord:(NSString *)rtpWord
                rtbpNumber:(NSString *)rtbpNumber
                qcEndDate:(double)qcEndDate
                rtpEndDate:(double)rtpEndDate
                                               isRequest:(BOOL)isRequest
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"qualificationUrl":RequestStrKey(qualificationUrl),
                           @"roadUrl":RequestStrKey(roadUrl),
                           @"qualificationNumber":RequestStrKey(qualificationNumber),
                           @"roadNumber":RequestStrKey(roadNumber),
                           @"qcAddr":RequestStrKey(qcAddr),
                           @"qcIssueDate":RequestStrKey(qcIssueDate),
                           @"qcAgency":RequestStrKey(qcAgency),
                           @"qcNationality":RequestStrKey(qcNationality),
                           @"qcCategory":RequestStrKey(qcCategory),
                           @"qcName":RequestStrKey(qcName),
                           @"qcDriverClass":RequestStrKey(qcDriverClass),
                           @"qcGender":RequestStrKey(qcGender),
                           @"qcBirthday":RequestStrKey(qcBirthday),
                           @"rtpWord":RequestStrKey(rtpWord),
                           @"rtbpNumber":RequestStrKey(rtbpNumber),
                           @"qcEndDate":NSNumber.dou(qcEndDate),
                           @"rtpEndDate":NSNumber.dou(rtpEndDate)};
    if (isRequest) {
        [self postUrl:@"/ums/service" delegate:delegate parameters:dic success:success failure:failure];
    }
    return dic;

}
/**
 司机认证详情（用户）[^/ums/driver$]
 */
+(void)requestDriverAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/driver" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车辆认证详情（用户）
 */
+(void)requestCarAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"http://192.168.20.27:10000/ums/vehicle" delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestBusinessAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/service" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 用户认证详情（用户）[^/ums/user$]
 */
+(void)requestUserAuthAllInfoWithDelegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/review/user" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 司机审核记录列表
 */
+(void)requestDriverAuthListWithDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/review/driver/log/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 营运审核记录列表
 */
+(void)requestBusinessAuthListWithDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/review/service/log/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 认证列表
 */
+(void)requestUserAuthListWithAccount:(NSString *)account
                           driverName:(NSString *)driverName
                          plateNumber:(NSString *)plateNumber
                         driverStatus:(NSString *)driverStatus
                        vehicleStatus:(NSString *)vehicleStatus
                            bizStatus:(NSString *)bizStatus
                                 page:(NSString *)page
                                count:(NSString *)count
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"account":RequestStrKey(account),
                          @"driverName":RequestStrKey(driverName),
                          @"plateNumber":RequestStrKey(plateNumber),
                          @"driverStatus":RequestStrKey(driverStatus),
                          @"vehicleStatus":RequestStrKey(vehicleStatus),
                          @"bizStatus":RequestStrKey(bizStatus),
                          @"page":RequestStrKey(page),
                          @"count":RequestStrKey(count)};
    [self getUrl:@"/ums/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车辆审核记录列表
 */
+(void)requestCarAuthListWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/vehicle/review/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 企业详情
 */
+(void)requestCompanyDetailWithId:(NSString *)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(id)};
    [self getUrl:@"/ums/ent/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 新增
 */
+(void)requestAddPathWithStartareaid:(NSString *)startAreaId
                           endAreaId:(NSString *)endAreaId
                        routePass1Id:(NSString *)routePass1Id
                        routePass2Id:(NSString *)routePass2Id
                        routePass3Id:(NSString *)routePass3Id
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSMutableDictionary *dic = @{@"startAreaId":RequestStrKey(startAreaId),
                          @"endAreaId":RequestStrKey(endAreaId),
    }.mutableCopy;
    if (isStr(routePass1Id)) {
        [dic setObject:routePass1Id forKey:@"routePass1Id"];
    }
    if (isStr(routePass2Id)) {
        [dic setObject:routePass2Id forKey:@"routePass2Id"];
    }
    if (isStr(routePass3Id)) {
        [dic setObject:routePass3Id forKey:@"routePass3Id"];
    }
    [self postUrl:@"/ums/route" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 编辑
 */
+(void)requestEditPathWithStartareaid:(NSString *)startAreaId
                            endAreaId:(NSString *)endAreaId
                         routePass1Id:(NSString *)routePass1Id
                         routePass2Id:(NSString *)routePass2Id
                         routePass3Id:(NSString *)routePass3Id
id:(NSString *)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSMutableDictionary *dic = @{@"startAreaId":RequestStrKey(startAreaId),
                          @"endAreaId":RequestStrKey(endAreaId),
                          @"id":RequestStrKey(id)}.mutableCopy;
    if (isStr(routePass1Id)) {
        [dic setObject:routePass1Id forKey:@"routePass1Id"];
    }
    if (isStr(routePass2Id)) {
        [dic setObject:routePass2Id forKey:@"routePass2Id"];
    }
    if (isStr(routePass3Id)) {
        [dic setObject:routePass3Id forKey:@"routePass3Id"];
    }
    [self putUrl:@"/ums/route/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 删除
 */
+(void)requestDeletePathWithId:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(id)};
    [self deleteUrl:@"/ums/route/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestPathDetailWithId:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(id)};
    [self getUrl:@"/ums/route/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
list
 */
+(void)requestPathListDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/route/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增
 */
+(void)requestAddAddressWithLng:(NSString *)lng
                            lat:(NSString *)lat
                         areaId:(double)areaId
                           addr:(NSString *)addr
                   contactPhone:(NSString *)contactPhone
                      contacter:(NSString *)contacter
                      isDefault:(NSString *)isDefault
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"areaId":NSNumber.dou(areaId),
                          @"addr":RequestStrKey(addr),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"contacter":RequestStrKey(contacter),
                          @"isDefault":RequestStrKey(isDefault)};
    [self postUrl:@"/ums/address" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 编辑
 */
+(void)requestEditAddressWithLng:(NSString *)lng
                             lat:(NSString *)lat
                          areaId:(double)areaId
                            addr:(NSString *)addr
                    contactPhone:(NSString *)contactPhone
                       contacter:(NSString *)contacter
                       isDefault:(NSString *)isDefault
id:(NSString *)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"areaId":NSNumber.dou(areaId),
                          @"addr":RequestStrKey(addr),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"contacter":RequestStrKey(contacter),
                          @"isDefault":RequestStrKey(isDefault),
                          @"id":RequestStrKey(id)};
    [self putUrl:@"/ums/address/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 删除
 */
+(void)requestDeleteAddressWithId:(NSString *)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(id)};
    [self deleteUrl:@"/ums/address/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表
 */
+(void)requestAddressListWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/address/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
@end
