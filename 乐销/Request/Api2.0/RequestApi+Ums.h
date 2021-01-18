//
//  RequestApi+Ums.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/11.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Ums)
/**
获取更换手机号[^/ums/sms/code/4$]
*/
+(void)requestResetPhoneCodeWithAppid:(NSString *)appId
                phone:(NSString *)phone
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
获取注册验证码[^/ums/sms/code/1$]
*/
+(void)requestResignCodeWithAppid:(NSString *)appId
                phone:(NSString *)phone
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
获取登录验证码[^/ums/sms/code/3$]
*/
+(void)requestLoginCodeWithAppid:(NSString *)appId
                phone:(NSString *)phone
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
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
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
更改手机号[^/ums/user/cellphone/3$]
*/
+(void)requestResetPhoneWithAppid:(NSString *)appId
                oldCellphone:(NSString *)oldCellphone
                newCellphone:(NSString *)newCellphone
                code:(NSString *)code
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
获取[^/ums/user$]
*/
+(void)requestUserInfo2WithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
验证码登录（个人）[^/ums/login/1$]
*/
+(void)requestLoginWithAppid:(NSString *)appId
                clientId:(NSString *)clientId
                phone:(NSString *)phone
                code:(NSString *)code
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
评价详情
*/
+(void)requestUserCommentDetailWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

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
                failure:(void (^)(NSString * errorStr, id mark))failure;
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
                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 司机认证详情（用户）[^/ums/identification/driver$]
*/
+(void)requestDriverAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
车辆认证详情（用户）
*/
+(void)requestCarAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
用户认证详情（用户）[^/ums/identification/user$]
*/
+(void)requestUserAuthAllInfoWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 司机审核记录列表
*/
+(void)requestDriverAuthListWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
营运审核记录列表
*/
+(void)requestBusinessAuthListWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
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
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
车辆审核记录列表
*/
+(void)requestCarAuthListWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
企业详情
*/
+(void)requestCompanyDetailWithId:(NSString *)id
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

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
                failure:(void (^)(NSString * errorStr, id mark))failure;
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
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
删除
*/
+(void)requestDeletePathWithId:(double)id
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
详情
*/
+(void)requestPathDetailWithId:(double)id
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestPathListDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
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
                failure:(void (^)(NSString * errorStr, id mark))failure;
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
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
删除
*/
+(void)requestDeleteAddressWithId:(NSString *)id
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
列表
*/
+(void)requestAddressListWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
