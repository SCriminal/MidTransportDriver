//
//  RequestApi+Order.m
//中车运
//
//  Created by 隋林栋 on 2018/11/6.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi+Order.h"
#import "RequestApi+UserApi.h"

@implementation RequestApi (Order)

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
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
                          @"waybillNumber":RequestStrKey(waybillNumber),
                          @"categoryId":NSNumber.dou(categoryId),
                          @"states":RequestStrKey(state),
                          @"blNumber":RequestStrKey(blNumber),
                          @"shippingLineName":RequestStrKey(shippingLineName),
                          @"oceanVesel":RequestStrKey(oceanVesel),
                          @"voyageNumber":RequestStrKey(voyageNumber),
                          @"startContact":RequestStrKey(startContact),
                          @"startPhone":RequestStrKey(startPhone),
                          @"endContact":RequestStrKey(endContact),
                          @"endPhone":RequestStrKey(endPhone),
                          @"closingStartTime":NSNumber.dou(closingStartTime),
                          @"closingEndTime":NSNumber.dou(closingEndTime),
                          @"placeEnvName":RequestStrKey(placeEnvName),
                          @"placeStartTime":NSNumber.dou(placeStartTime),
                          @"placeEndTime":NSNumber.dou(placeEndTime),
                          @"placeContact":RequestStrKey(placeContact),
                          @"createStartTime":NSNumber.dou(createStartTime),
                          @"createEndTime":NSNumber.dou(createEndTime),
                          @"acceptStartTime":NSNumber.dou(acceptStartTime),
                          @"acceptEndTime":NSNumber.dou(acceptEndTime),
                          @"finishStartTime":NSNumber.dou(finishStartTime),
                          @"finishEndTime":NSNumber.dou(finishEndTime),
                          @"stuffStartTime":NSNumber.dou(stuffStartTime),
                          @"stuffEndTime":NSNumber.dou(stuffEndTime),
                          @"toFactoryStartTime":NSNumber.dou(toFactoryStartTime),
                          @"toFactoryEndTime":NSNumber.dou(toFactoryEndTime),
                          @"handleStartTime":NSNumber.dou(handleStartTime),
                          @"handleEndTime":NSNumber.dou(handleEndTime),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"entId":NSNumber.dou(entId),
                          @"sortAcceptTime":[NSNumber numberWithInt:sortAcceptTime],
                          @"sortFinishTime":[NSNumber numberWithInt:sortFinishTime],
                          @"sortCreateTime":[NSNumber numberWithInt:sortCreateTime]
                          };
    [self getUrl:@"/zhongcheyun/waybill/3/list/carrier/total/sort" delegate:delegate parameters:dic success:success failure:failure];
}


//司机操作
+ (void)requestOperateOrder:(double)identytiy
                operateType:(ENUM_ORDER_OPERATE_TYPE)operateType
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    /*
     ENUM_ORDER_OPERATE_WAIT_RECEIVE,//接单
     ENUM_ORDER_OPERATE_BACK_PACKAGE,//提箱
     ENUM_ORDER_OPERATE_ARRIVE_FACTORY,//装卸货
     ENUM_ORDER_OPERATE_LOAD_COMPLETE,//装卸货完成
     ENUM_ORDER_OPERATE_RETURN_PACKAGE//还箱
     */

    ModelAddress * modelAddressItem = [ModelAddress lastLocation];

    double lng = modelAddressItem.lng;
    double lat = modelAddressItem.lat;
    NSString * add  = modelAddressItem.desc;
    if (lat == 0) {
        [GlobalMethod showAlert:@"暂未获得地理位置，请稍后重试"];
        return;
    }
    switch (operateType) {
        case ENUM_ORDER_OPERATE_WAIT_RECEIVE:
            [self requestOperateAcceptWithSelectids:@"" lng:lng lat:lat addr:add id:identytiy delegate:delegate success:success failure:failure];
            break;
        case ENUM_ORDER_OPERATE_BACK_PACKAGE:
            [self requestOperateLoadPackageWithLng:lng lat:lat addr:add id:identytiy delegate:delegate success:success failure:failure];
            break;
        case ENUM_ORDER_OPERATE_ARRIVE_FACTORY:
            [self requestOperateArriveFactoryWithLng:lng lat:lat addr:add id:identytiy delegate:delegate success:success failure:failure];
            break;
        case ENUM_ORDER_OPERATE_LOAD_COMPLETE:
            [self requestOperateUnloadGoodsWithLng:lng lat:lat addr:add id:identytiy delegate:delegate success:success failure:failure];
            break;
        case ENUM_ORDER_OPERATE_RETURN_PACKAGE:
            [self requestOperateReturnPackageWithLng:lng lat:lat addr:add id:identytiy delegate:delegate success:success failure:failure];
            break;
            
        default:
            break;
    }
}
/**
 司机到厂
 */
+(void)requestOperateArriveFactoryWithLng:(double)lng
                                      lat:(double)lat
                                     addr:(NSString *)addr
                                       id:(double)identity
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"addr":RequestStrKey(addr),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/waybill/3/604/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 司机接单
 */
+(void)requestOperateAcceptWithSelectids:(NSString *)selectIds
                                     lng:(double)lng
                                     lat:(double)lat
                                    addr:(NSString *)addr
                                      id:(double)identity
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"selectIds":RequestStrKey(selectIds),
                          @"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"addr":RequestStrKey(addr),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/waybill/3/602/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 司机提箱
 */
+(void)requestOperateLoadPackageWithLng:(double)lng
                                    lat:(double)lat
                                   addr:(NSString *)addr
                                     id:(double)identity
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"addr":RequestStrKey(addr),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/waybill/3/603/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 司机装卸货
 */
+(void)requestOperateUnloadGoodsWithLng:(double)lng
                                    lat:(double)lat
                                   addr:(NSString *)addr
                                     id:(double)identity
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"addr":RequestStrKey(addr),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/waybill/3/605/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 司机还箱
 */
+(void)requestOperateReturnPackageWithLng:(double)lng
                                      lat:(double)lat
                                     addr:(NSString *)addr
                                       id:(double)identity
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"addr":RequestStrKey(addr),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/waybill/3/610/{id}" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 详情
 */
+(void)requestOrderDetailWithId:(double)identity
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/zhongcheyun/waybill/detail/{id}" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 状态时间轨迹列表（派车单）
 */
+(void)requestDriverOrderTimeAxleWithFormid:(double)formId
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"formId":NSNumber.dou(formId),
                          @"entId":NSNumber.dou(entId)};
    [self getUrl:@"/zhongcheyun/waybill/state/trajectory/driver" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 运单货物列表
 */
+(void)requestGoosListWithId:(double)identity
                       entID:(double)entID
                    delegate:(id <RequestDelegate>)delegate
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"page":NSNumber.dou(1),
                          @"count":NSNumber.dou(100),
                          @"entId":NSNumber.dou(entID)};
    [self getUrl:@"/zhongcheyun/waybill/container/waybillCargo/driver/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 录入箱号，铅封号
 */
+(void)requestInputPackageNumWithWaybillcargoid:(double)waybillCargoId
                                containerNumber:(NSString *)containerNumber
                                     sealNumber:(NSString *)sealNumber
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"cargoId":NSNumber.dou(waybillCargoId),
                          @"containerNumber":UnPackStr(containerNumber),
                          @"sealNumber":UnPackStr(sealNumber)};
    [self patchUrl:@"/zhongcheyun/waybill/container" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 删除记账本
 */
+(void)requestDeleteAccountWithId:(NSString *)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(identity)};
    [self deleteUrl:@"/zhongcheyun/pocketbook" delegate:delegate parameters:dic success:success failure:failure];
}
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
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"waybillId":NSNumber.dou(waybillId),
                          @"type":RequestStrKey(type),
                          @"fee":NSNumber.dou(fee),
                          @"description":RequestStrKey(description),
                          @"entId":NSNumber.dou(entId)};
    [self postUrl:@"/zhongcheyun/pocketbook" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 记账本列表
 */
+(void)requestAccountListWithEntid:(double)entId
                     waybillNumber:(NSString *)waybillNumber
                        billNumber:(NSString *)billNumber
                              type:(NSString *)type
                              page:(double)page
                             count:(double)count
                         startTime:(double)startTime
                           endTime:(double)endTime
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"entId":NSNumber.dou(entId),
                                                                               @"waybillNumber":RequestStrKey(waybillNumber),
                                                                               @"billNumber":RequestStrKey(billNumber),
                                                                               @"type":RequestStrKey(type),
                                                                               @"page":NSNumber.dou(page),
                                                                               @"count":NSNumber.dou(count)}] ;
    if (startTime) {
        [dic setObject:NSNumber.lon(startTime) forKey:@"startTime"];
    }
    if (endTime) {
        [dic setObject:NSNumber.lon(endTime) forKey:@"endTime"];
    }
    [self getUrl:@"/zhongcheyun/pocketbook/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 记账本编辑
 */
+(void)requestEditAccountWithType:(double)type
                              fee:(double)fee
                      description:(NSString *)description
                               id:(double)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"type":NSNumber.dou(type),
                          @"fee":NSNumber.dou(fee),
                          @"description":RequestStrKey(description),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/pocketbook/{id}" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 列表
 */
+(void)requestAccessoryListWithFormid:(double)formId
                             formType:(double)formType
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"formId":NSNumber.dou(formId),
                          @"formType":NSNumber.dou(formType),
                          @"entId":NSNumber.dou(entId)};
    [self getUrl:@"/zhongcheyun/waybill/attachment/list" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 有效车辆列表（司机）
 */
+(void)requestValidCarListWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/vehicle/1_0_65/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车辆列表（司机）
 */
+(void)requestPersonalCarWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/vehicle/1_0_101/pool" delegate:delegate parameters:dic success:success failure:failure];
}
//
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
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    
    NSDictionary *dic = @{@"vin":RequestStrKey(vin),
                          @"engineNumber":RequestStrKey(engineNumber),
                          @"vehicleNumber":RequestStrKey(vehicleNumber),
                          @"licenceType":RequestLongKey(licenceType),
                          @"trailerNumber":RequestStrKey(trailerNumber),
                          @"vehicleLicense":RequestStrKey(vehicleLicense),
                          @"vehicleLength":RequestLongKey(vehicleLength),
                          @"vehicleType":RequestLongKey(vehicleType),
                          @"vehicleLoad":RequestLongKey(vehicleLoad),
                          @"axle":RequestLongKey(axle),
                          @"vehicleOwner":RequestStrKey(vehicleOwner),
                          @"drivingLicenseFrontUrl":RequestStrKey(drivingLicenseFrontUrl),
                          @"drivingLicenseNegativeUrl":RequestStrKey(drivingLicenseNegativeUrl),
                          @"vehicleInsuranceUrl":RequestStrKey(vehicleInsuranceUrl),
                          @"vehicleTripartiteInsuranceUrl":RequestStrKey(vehicleTripartiteInsuranceUrl),
                          @"trailerInsuranceUrl":RequestStrKey(trailerInsuranceUrl),
                          @"trailerTripartiteInsuranceUrl":RequestStrKey(trailerTripartiteInsuranceUrl),
                          @"trailerGoodsInsuranceUrl":RequestStrKey(trailerGoodsInsuranceUrl),
                          @"vehiclePhotoUrl":RequestStrKey(vehiclePhotoUrl),
                          @"managementLicenseUrl":RequestStrKey(managementLicenseUrl),
                          };
    [self postUrl:@"/zhongcheyun/vehicle/1_0_100/driver/submit" delegate:delegate parameters:dic success:success failure:failure];
}
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
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"vin":RequestStrKey(vin),
                          @"engineNumber":RequestStrKey(engineNumber),
                          @"vehicleNumber":RequestStrKey(vehicleNumber),
                          @"licenceType":RequestLongKey(licenceType),
                          @"trailerNumber":RequestStrKey(trailerNumber),
                          @"vehicleLicense":RequestStrKey(vehicleLicense),
                          @"vehicleLength":RequestLongKey(vehicleLength),
                          @"vehicleType":RequestLongKey(vehicleType),
                          @"vehicleLoad":RequestLongKey(vehicleLoad),
                          @"axle":RequestLongKey(axle),
                          @"id":RequestLongKey(identity),
                          @"vehicleOwner":RequestStrKey(vehicleOwner),
                          @"drivingLicenseFrontUrl":RequestStrKey(drivingLicenseFrontUrl),
                          @"drivingLicenseNegativeUrl":RequestStrKey(drivingLicenseNegativeUrl),
                          @"vehicleInsuranceUrl":RequestStrKey(vehicleInsuranceUrl),
                          @"vehicleTripartiteInsuranceUrl":RequestStrKey(vehicleTripartiteInsuranceUrl),
                          @"trailerInsuranceUrl":RequestStrKey(trailerInsuranceUrl),
                          @"trailerTripartiteInsuranceUrl":RequestStrKey(trailerTripartiteInsuranceUrl),
                          @"trailerGoodsInsuranceUrl":RequestStrKey(trailerGoodsInsuranceUrl),
                          @"vehiclePhotoUrl":RequestStrKey(vehiclePhotoUrl),
                          @"managementLicenseUrl":RequestStrKey(managementLicenseUrl),
                          };
    [self patchUrl:@"/zhongcheyun/vehicle/1_0_100/driver/submit/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车辆审核记录列表
 */
+(void)requestCarAuditListWithId:(double)vehicleId
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"vehicleId":NSNumber.dou(vehicleId)};
    [self getUrl:@"/zhongcheyun/vehicle/qulification/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车辆详情
 */
+(void)requestCarDetailWithId:(double)identity
                        entId:(double)entId
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"entId":NSNumber.dou(entId)};
    [self getUrl:@"/zhongcheyun/vehicle/1_0_10/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车队列表（带总数）
 */
+(void)requestAttachCompanyWithName:(NSString *)name
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"name":RequestStrKey(name)};
    [self getUrl:@"/zhongcheyun/ent/1_0_75/list/fleet/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 申请挂靠（司机）
 */
+(void)requestApplyAttachWithEntid:(double)entId
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"entId":NSNumber.dou(entId)};
    [self postUrl:@"/zhongcheyun/driverdependent/1_0_75" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 删除车辆
 */
+(void)requestDeleteCarWithId:(double)identity
                        entId:(double)entId
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"entId":NSNumber.dou(entId)};
    [self deleteUrl:@"/zhongcheyun/vehicle/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
@end
