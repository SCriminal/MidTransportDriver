//
//  RequestApi+Plan.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/21.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Plan)

+(void)requestAutoOrderListWithMode:(NSString *)mode
                startAreaId:(NSString *)startAreaId
                endAreaId:(NSString *)endAreaId
                createStartTime:(double)createStartTime
                createEndTime:(double)createEndTime
                page:(double)page
                count:(double)count
                lat:(NSString *)lat
                lng:(NSString *)lng
                sort:(double)sort
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
最新货源
*/
+(void)requestNewOrderListWithStartareaid:(double)startAreaId
                endAreaId:(double)endAreaId
                page:(double)page
                count:(double)count
                vehicleTypeId:(double)vehicleTypeId
                mode:(double)mode
                lat:(NSString *)lat
                lng:(NSString *)lng
                sort:(double)sort
                          vehicleTypeCode:(NSString *)vehicleTypeCode
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestOrderListWithPage:(double)page
                count:(double)count
                orderNumber:(NSString *)orderNumber
                shipperName:(NSString *)shipperName
                plateNumber:(NSString *)plateNumber
                driverName:(NSString *)driverName
                      startTime:(double)startTime
                        endTime:(double)endTime
                   orderStatues:(NSString *)orderStatues
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;


+(void)requestLocationOrderDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestOrderDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;
/**
计划单详情(司机)
*/
+(void)requestPlanDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
我的报价列表
*/
+(void)requestMyScheduleOrderListWithPage:(double)page
                count:(double)count
                                   number:(NSString *)number
                             matchStatues:(NSString *)matchStatues
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 取消报价
*/
+(void)requestDismissPriceOrderNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
扫码(报价)
*/
+(void)requestPlanPriceWithPlannumber:(NSString *)planNumber
                vehicleId:(double)vehicleId
                qty:(double)qty
                price:(double)price
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
抢单(报价)
*/
+(void)requestRobWithPlannumber:(NSString *)planNumber
                vehicleId:(double)vehicleId
                qty:(double)qty
                price:(double)price
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;
/**
2.0接单
*/
+(void)requestAcceptWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
2.0装车
*/
+(void)requestLoadWithUrls:(NSString *)urls
                number:(NSString *)number
               description:(NSString *)description
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                   failure:(void (^)(NSString * errorStr, id mark))failure;
/**
2.0卸车
*/
+(void)requestUnloadWithUrls:(NSString *)urls
                number:(NSString *)number
                 description:(NSString *)description
                delayReasoon:(NSString *)delayReasoon
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure;

/**
2.0拒单
*/
+(void)requestRejectOrderumber:(NSString *)orderNumber
                        reason:(NSString *)reason
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;


/**
2.0接单-自有运单
*/
+(void)requestAcceptSelfPossessOrderWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
2.0装车-自有运单
*/
+(void)requestLoadSelfPossessOrderWithUrls:(NSString *)urls
                number:(NSString *)number
                               description:(NSString *)description
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;
/**
2.0卸车-自有运单
*/
+(void)requestUnloadSelfPossessOrderWithUrls:(NSString *)urls
                number:(NSString *)orderNumber
                                 description:(NSString *)description
                                delayReasoon:(NSString *)delayReasoon
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;

/**
2.0拒单-自有运单
*/
+(void)requestRejectSelfPossessOrderumber:(NSString *)number
                        reason:(NSString *)reason
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

/**
2.0 运单列表(司机)-自有运单
*/
+(void)requestSelfPossessOrderListWithPage:(double)page
                count:(double)count
                orderNumber:(NSString *)orderNumber
                shipperName:(NSString *)shipperName
                plateNumber:(NSString *)plateNumber
                driverName:(NSString *)driverName
                      startTime:(double)startTime
                        endTime:(double)endTime
                   orderStatues:(NSString *)orderStatues
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;
/**
2.0 运单详情(司机)-自有运单
*/
+(void)requestSelfPossessOrderDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;

@end

NS_ASSUME_NONNULL_END
