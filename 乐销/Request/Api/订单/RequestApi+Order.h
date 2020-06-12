//
//  RequestApi+Order.h
//中车运
//
//  Created by 隋林栋 on 2018/11/6.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Order)

typedef NS_ENUM(NSUInteger, ENUM_ORDER_OPERATE_TYPE) {
    ENUM_ORDER_OPERATE_COMPLETE = 0,
    ENUM_ORDER_OPERATE_WAIT_RECEIVE,//接单
    ENUM_ORDER_OPERATE_BACK_PACKAGE,//提箱
    ENUM_ORDER_OPERATE_ARRIVE_FACTORY,//装卸货
    ENUM_ORDER_OPERATE_LOAD_COMPLETE,//装卸货完成
    ENUM_ORDER_OPERATE_RETURN_PACKAGE//还箱
};//


/**
 列表：承运人端
 */
+(void)requestOrderListWithWaybillnumber:(NSString *)waybillNumber
                              categoryId:(double)categoryId
                                   state:(NSString *)state
                                blNumber:(NSString *)blNumber
                        shippingLineName:(NSString *)shippingLineName
                              oceanVesel:(NSString *)oceanVesel
                            voyageNumber:(NSString *)voyageNumber
                            startContact:(NSString *)startContact
                              startPhone:(NSString *)startPhone
                              endContact:(NSString *)endContact
                                endPhone:(NSString *)endPhone
                        closingStartTime:(double)closingStartTime
                          closingEndTime:(double)closingEndTime
                            placeEnvName:(NSString *)placeEnvName
                          placeStartTime:(double)placeStartTime
                            placeEndTime:(double)placeEndTime
                            placeContact:(NSString *)placeContact
                         createStartTime:(double)createStartTime
                           createEndTime:(double)createEndTime
                         acceptStartTime:(double)acceptStartTime
                           acceptEndTime:(double)acceptEndTime
                         finishStartTime:(double)finishStartTime
                           finishEndTime:(double)finishEndTime
                          stuffStartTime:(double)stuffStartTime
                            stuffEndTime:(double)stuffEndTime
                      toFactoryStartTime:(double)toFactoryStartTime
                        toFactoryEndTime:(double)toFactoryEndTime
                         handleStartTime:(double)handleStartTime
                           handleEndTime:(double)handleEndTime
                                    page:(double)page
                                   count:(double)count
                                   entId:(double)entId
                          sortAcceptTime:(int)sortAcceptTime
                          sortFinishTime:(int)sortFinishTime
                          sortCreateTime:(int)sortCreateTime
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

+ (void)requestOperateOrder:(double)identytiy
                operateType:(ENUM_ORDER_OPERATE_TYPE)operateType
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestOrderDetailWithId:(double)identity
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 状态时间轨迹列表（派车单）
 */
+(void)requestDriverOrderTimeAxleWithFormid:(double)formId
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 运单货物列表
 */
+(void)requestGoosListWithId:(double)idp
                       entID:(double)entID
                    delegate:(id <RequestDelegate>)delegate
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 录入箱号，铅封号
 */
+(void)requestInputPackageNumWithWaybillcargoid:(double)waybillCargoId
                                containerNumber:(NSString *)containerNumber
                                     sealNumber:(NSString *)sealNumber
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 删除记账本
 */
+(void)requestDeleteAccountWithId:(NSString *)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增记账本
 */
+(void)requestAddAccountWithWaybillid:(double)waybillId
                                 type:(NSString *)type
                                  fee:(double)fee
                          description:(NSString *)description
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 记账本列表
 */
+(void)requestAccountListWithEntid:(double)entId
                     waybillNumber:(NSString *)waybillNumber
                        billNumber:(NSString *)billNumber
                              type:(NSString *)type
                              page:(double)page
                             count:(double)count
                         startTime:(double)stratTime
                           endTime:(double)endTime
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 记账本编辑
 */
+(void)requestEditAccountWithType:(double)type
                              fee:(double)fee
                      description:(NSString *)description
                               id:(double)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 列表
 */
+(void)requestAccessoryListWithFormid:(double)formId
                             formType:(double)formType
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 有效车辆列表（司机）
 */
+(void)requestValidCarListWithDelegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 车辆列表（司机）
 */
+(void)requestPersonalCarWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增车辆
 */
+(void)requestAddCarWithVin:(NSString *)vin
               engineNumber:(NSString *)engineNumber
              vehicleNumber:(NSString *)vehicleNumber
                licenceType:(double)licenceType
              trailerNumber:(NSString *)trailerNumber
             vehicleLicense:(NSString *)vehicleLicense
              vehicleLength:(double)vehicleLength
                vehicleType:(double)vehicleType
                vehicleLoad:(double)vehicleLoad
                       axle:(double)axle
               vehicleOwner:(NSString *)vehicleOwner
     drivingLicenseFrontUrl:(NSString *)drivingLicenseFrontUrl
  drivingLicenseNegativeUrl:(NSString *)drivingLicenseNegativeUrl
        vehicleInsuranceUrl:(NSString *)vehicleInsuranceUrl
vehicleTripartiteInsuranceUrl:(NSString *)vehicleTripartiteInsuranceUrl
        trailerInsuranceUrl:(NSString *)trailerInsuranceUrl
trailerTripartiteInsuranceUrl:(NSString *)trailerTripartiteInsuranceUrl
   trailerGoodsInsuranceUrl:(NSString *)trailerGoodsInsuranceUrl
            vehiclePhotoUrl:(NSString *)vehiclePhotoUrl
       managementLicenseUrl:(NSString *)managementLicenseUrl
driving2NegativeUrl:(NSString *)driving2NegativeUrl
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 resubmit车辆
 */
+(void)requestResubmitCarWithVin:(NSString *)vin
               engineNumber:(NSString *)engineNumber
              vehicleNumber:(NSString *)vehicleNumber
                licenceType:(double)licenceType
              trailerNumber:(NSString *)trailerNumber
             vehicleLicense:(NSString *)vehicleLicense
              vehicleLength:(double)vehicleLength
                vehicleType:(double)vehicleType
                vehicleLoad:(double)vehicleLoad
                       axle:(double)axle
                        id:(double)identity
               vehicleOwner:(NSString *)vehicleOwner
     drivingLicenseFrontUrl:(NSString *)drivingLicenseFrontUrl
  drivingLicenseNegativeUrl:(NSString *)drivingLicenseNegativeUrl
        vehicleInsuranceUrl:(NSString *)vehicleInsuranceUrl
vehicleTripartiteInsuranceUrl:(NSString *)vehicleTripartiteInsuranceUrl
        trailerInsuranceUrl:(NSString *)trailerInsuranceUrl
trailerTripartiteInsuranceUrl:(NSString *)trailerTripartiteInsuranceUrl
   trailerGoodsInsuranceUrl:(NSString *)trailerGoodsInsuranceUrl
            vehiclePhotoUrl:(NSString *)vehiclePhotoUrl
       managementLicenseUrl:(NSString *)managementLicenseUrl
    driving2NegativeUrl:(NSString *)driving2NegativeUrl
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 车辆审核记录列表
 */
+(void)requestCarAuditListWithId:(double)vehicleId
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 车辆详情
 */
+(void)requestCarDetailWithId:(double)identity
                        entId:(double)entId
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 车队列表（带总数）
 */
+(void)requestAttachCompanyWithName:(NSString *)name
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 申请挂靠（司机）
 */
+(void)requestApplyAttachWithEntid:(double)entId
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 删除车辆
 */
+(void)requestDeleteCarWithId:(double)identity
                        entId:(double)entId
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
