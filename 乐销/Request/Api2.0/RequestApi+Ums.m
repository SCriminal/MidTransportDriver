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
    NSDictionary *dic = @{@"appId":RequestStrKey(appId),
                          @"phone":RequestStrKey(phone)};
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
    NSDictionary *dic = @{@"appId":RequestStrKey(appId),
                          @"phone":RequestStrKey(phone)};
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
    NSDictionary *dic = @{@"appId":RequestStrKey(appId),
                          @"phone":RequestStrKey(phone)};
    [self getUrl:@"/ums/sms/code/3" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 修改[^/ums/user$]
 */
+(void)requestResetUserInfoWithNickname:(NSString *)nickname
                                headUrl:(NSString *)headUrl
                                  email:(NSString *)email
                               birthday:(double)birthday
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"nickname":RequestStrKey(nickname),
                          @"headUrl":RequestStrKey(headUrl),
                          @"email":RequestStrKey(email),
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
    NSDictionary *dic = @{@"appId":RequestStrKey(appId),
                          @"oldCellphone":RequestStrKey(oldCellphone),
                          @"newCellphone":RequestStrKey(newCellphone),
                          @"code":RequestStrKey(code)};
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
    NSDictionary *dic = @{@"appId":RequestStrKey(appId),
                          @"clientId":RequestStrKey(clientId),
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
 提交司机信息[^/ums/identification/driver$]
 */
+(void)requestAuthDriverWithIdcardnationalemblemurl:(NSString *)idCardNationalEmblemUrl
                                      idCardFaceUrl:(NSString *)idCardFaceUrl
                                          driverUrl:(NSString *)driverUrl
                                   personVehicleUrl:(NSString *)personVehicleUrl
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
                                           delegate:(id <RequestDelegate>)delegate
                                            success:(void (^)(NSDictionary * response, id mark))success
                                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"idCardNationalEmblemUrl":RequestStrKey(idCardNationalEmblemUrl),
                          @"idCardFaceUrl":RequestStrKey(idCardFaceUrl),
                          @"driverUrl":RequestStrKey(driverUrl),
                          @"personVehicleUrl":RequestStrKey(personVehicleUrl),
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
    [self postUrl:@"/ums/identification/driver" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 提交车辆认证信息
 */
+(void)requestAuthCarWithPlatenumber:(NSString *)plateNumber
                         vehicleType:(double)vehicleType
                               owner:(NSString *)owner
                           grossMass:(NSString *)grossMass
                        approvedLoad:(NSString *)approvedLoad
                       vehicleLength:(NSString *)vehicleLength
                        vehicleWidth:(NSString *)vehicleWidth
                       vehicleHeight:(NSString *)vehicleHeight
                drivingLicenseOneUrl:(NSString *)drivingLicenseOneUrl
                drivingLicenseTwoUrl:(NSString *)drivingLicenseTwoUrl
              drivingLicenseThreeUrl:(NSString *)drivingLicenseThreeUrl
                          plateColor:(double)plateColor
                          energyType:(double)energyType
                        tractionMass:(NSString *)tractionMass
                      drivingEndTime:(NSString *)drivingEndTime
                        useCharacter:(NSString *)useCharacter
                         unladenMass:(NSString *)unladenMass
                                 vin:(NSString *)vin
                 drivingRegisterDate:(NSString *)drivingRegisterDate
                        engineNumber:(NSString *)engineNumber
                    drivingIssueDate:(NSString *)drivingIssueDate
                               model:(NSString *)model
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"plateNumber":RequestStrKey(plateNumber),
                          @"vehicleType":NSNumber.dou(vehicleType),
                          @"owner":RequestStrKey(owner),
                          @"grossMass":RequestStrKey(grossMass),
                          @"approvedLoad":RequestStrKey(approvedLoad),
                          @"vehicleLength":RequestStrKey(vehicleLength),
                          @"vehicleWidth":RequestStrKey(vehicleWidth),
                          @"vehicleHeight":RequestStrKey(vehicleHeight),
                          @"drivingLicenseOneUrl":RequestStrKey(drivingLicenseOneUrl),
                          @"drivingLicenseTwoUrl":RequestStrKey(drivingLicenseTwoUrl),
                          @"drivingLicenseThreeUrl":RequestStrKey(drivingLicenseThreeUrl),
                          @"plateColor":NSNumber.dou(plateColor),
                          @"energyType":NSNumber.dou(energyType),
                          @"tractionMass":RequestStrKey(tractionMass),
                          @"drivingEndTime":RequestStrKey(drivingEndTime),
                          @"useCharacter":RequestStrKey(useCharacter),
                          @"unladenMass":RequestStrKey(unladenMass),
                          @"vin":RequestStrKey(vin),
                          @"drivingRegisterDate":RequestStrKey(drivingRegisterDate),
                          @"engineNumber":RequestStrKey(engineNumber),
                          @"drivingIssueDate":RequestStrKey(drivingIssueDate),
                          @"model":RequestStrKey(model)};
    [self postUrl:@"/ums/identification/vehicle" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 司机认证详情（用户）[^/ums/identification/driver$]
 */
+(void)requestDriverAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/identification/driver" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车辆认证详情（用户）
 */
+(void)requestCarAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/identification/vehicle" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 用户认证详情（用户）[^/ums/identification/user$]
 */
+(void)requestUserAuthAllInfoWithDelegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/identification/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 司机审核记录列表
 */
+(void)requestDriverAuthListWithDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/identification/review/driver/log/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 营运审核记录列表
 */
+(void)requestBusinessAuthListWithDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/identification/review/service/log/list/total" delegate:delegate parameters:dic success:success failure:failure];
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
    [self getUrl:@"/ums/identification/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车辆审核记录列表
 */
+(void)requestCarAuthListWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/ums/identification/vehicle/review/list/total" delegate:delegate parameters:dic success:success failure:failure];
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
                         passAreaIds:(NSString *)passAreaIds
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"startAreaId":RequestStrKey(startAreaId),
                          @"endAreaId":RequestStrKey(endAreaId),
                          @"passAreaIds":RequestStrKey(passAreaIds)};
    [self postUrl:@"/ums/route" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 编辑
 */
+(void)requestEditPathWithStartareaid:(NSString *)startAreaId
                            endAreaId:(NSString *)endAreaId
                          passAreaIds:(NSString *)passAreaIds
id:(NSString *)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"startAreaId":RequestStrKey(startAreaId),
                          @"endAreaId":RequestStrKey(endAreaId),
                          @"passAreaIds":RequestStrKey(passAreaIds),
                          @"id":RequestStrKey(id)};
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
