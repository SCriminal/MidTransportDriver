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
提交认证信息（整合）
*/
+(void)requestAuthUpAllWithDriverjson:(NSString *)driverJson
                serviceJson:(NSString *)serviceJson
                vehicleJson:(NSString *)vehicleJson
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
提交司机信息[^/ums/identification/driver$]
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
                driverFirstIssueDate:(double)driverFirstIssueDate
                                                  idStartDate:(double)idStartDate
                                                    idEndDate:(double)idEndDate
                                                  dlStartDate:(double)dlStartDate
                                                    dlEndDate:(double)dlEndDate
                                                    isRequest:(BOOL)isRequest
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                            failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
提交营运认证信息[^/ums/identification/service$]
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
 检查车辆认证详情（用户）
 */
+(void)requestCarAuthCheckWithPlateNumber:(NSString *)plateNumber
                                      vin:(NSString *)vin
                                    owner:(NSString *)owner
                              vehicleType:(double)vehicleType
delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestBusinessAuthDetailWithDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 检查司机是否认证（用户）
 */
+(void)requestIdnumAuthCheckWithidNumber:(NSString *)idNumber
delegate:(id <RequestDelegate>)delegate
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
/**
 2.0评价列表
 */
+(void)requestCommentListWithUserIds:(NSString *)userIds
delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 2.0评价货主
 */
+(void)requestCommentOrderNumber:(NSString *)orderNumber
                         content:(NSString *)content
                           score:(double)score
                        delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 刷洗token
 */
+(void)requestRefreshTokenDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

/**
温馨提示
*/
+(void)requestOriginCarListWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
马上迁移
*/
+(void)requestOriginTransferWithVehicleId:(double)vehicleId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
