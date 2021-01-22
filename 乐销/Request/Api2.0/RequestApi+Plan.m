//
//  RequestApi+Plan.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/21.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi+Plan.h"

@implementation RequestApi (Plan)
/**
智能匹配
*/
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
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"mode":RequestStrKey(mode),
                           @"startAreaId":RequestStrKey(startAreaId),
                           @"endAreaId":RequestStrKey(endAreaId),
                           @"createStartTime":RequestDoubleKey(createStartTime),
                           @"createEndTime":RequestDoubleKey(createEndTime),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                           @"lat":RequestStrKey(lat),
                           @"lng":RequestStrKey(lng),
                           @"sort":RequestLongKey(sort)};
        [self getUrl:@"/plan/plan/driver/match/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

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
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"startAreaId":NSNumber.dou(startAreaId),
                           @"endAreaId":NSNumber.dou(endAreaId),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                           @"vehicleTypeId":NSNumber.dou(vehicleTypeId),
                           @"mode":NSNumber.dou(mode),
                           @"lat":RequestStrKey(lat),
                           @"lng":RequestStrKey(lng),
                              @"vehicleTypeCode":RequestStrKey(vehicleTypeCode),
                           @"sort":NSNumber.dou(sort)};
        [self getUrl:@"/plan/plan/driver/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0 运单列表(司机)
*/
+(void)requestOrderListWithPage:(double)page
                count:(double)count
                orderNumber:(NSString *)orderNumber
                shipperName:(NSString *)shipperName
                plateNumber:(NSString *)plateNumber
                driverName:(NSString *)driverName
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                           @"orderNumber":RequestStrKey(orderNumber),
                           @"shipperName":RequestStrKey(shipperName),
                           @"plateNumber":RequestStrKey(plateNumber),
                           @"driverName":RequestStrKey(driverName)};
        [self getUrl:@"/loms/order/driver/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
计划单详情(司机)
*/
+(void)requestPlanDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"number":RequestStrKey(number)};
        [self getUrl:@"/plan/plan/driver/{number}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
扫码(抢单)
*/
+(void)requestPlanRobWithPlannumber:(NSString *)planNumber
                vehicleId:(double)vehicleId
                qty:(double)qty
                price:(double)price
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"planNumber":RequestStrKey(planNumber),
                           @"vehicleId":NSNumber.dou(vehicleId),
                           @"qty":NSNumber.dou(qty),
                           @"price":NSNumber.dou(price)};
        [self postUrl:@"/zhongcheyun/plan/match/1" delegate:delegate parameters:dic success:success failure:failure];
}

/**
扫码(报价)
*/
+(void)requestPlanPriceWithPlannumber:(NSString *)planNumber
                vehicleId:(double)vehicleId
                qty:(double)qty
                price:(double)price
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"planNumber":RequestStrKey(planNumber),
                           @"vehicleId":NSNumber.dou(vehicleId),
                           @"qty":NSNumber.dou(qty),
                           @"price":NSNumber.dou(price)};
        [self postUrl:@"/zhongcheyun/plan/match/2" delegate:delegate parameters:dic success:success failure:failure];
}
@end
