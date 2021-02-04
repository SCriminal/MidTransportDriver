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
        [self getUrl:@"/plan/plan/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
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
我的报价列表
*/
+(void)requestMyScheduleOrderListWithPage:(double)page
                count:(double)count
                                   number:(NSString *)number
                             matchStatues:(NSString *)matchStatues
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                           @"number":RequestStrKey(number),
                              @"matchStatues":RequestStrKey(matchStatues),

        };
        [self getUrl:@"/plan/plan/match/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 取消报价
*/
+(void)requestDismissPriceOrderNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{
                           @"number":RequestStrKey(number),
        };
        [self putUrl:@"/plan/plan/match/status/11/{number}" delegate:delegate parameters:dic success:success failure:failure];
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
        [self postUrl:@"/zhongcheyun/plan/match/mode/2" delegate:delegate parameters:dic success:success failure:failure];
}
/**
抢单(报价)
*/
+(void)requestRobWithPlannumber:(NSString *)planNumber
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
        [self postUrl:@"/zhongcheyun/plan/match/mode/1" delegate:delegate parameters:dic success:success failure:failure];
}


/**
2.0接单
*/
+(void)requestAcceptWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"number":RequestStrKey(number)};
        [self putUrl:@"/loms/order/status/2/{number}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0装车
*/
+(void)requestLoadWithUrls:(NSString *)urls
                number:(NSString *)number
               description:(NSString *)description
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"urls":RequestStrKey(urls),
                              @"description":RequestStrKey(description),
                           @"number":RequestStrKey(number)};
        [self putUrl:@"/loms/order/status/3/{number}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
2.0卸车
*/
+(void)requestUnloadWithUrls:(NSString *)urls
                 description:(NSString *)description
                number:(NSString *)orderNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"urls":RequestStrKey(urls),
                              @"description":RequestStrKey(description),
                           @"number":RequestStrKey(orderNumber)};
        [self putUrl:@"/zhongcheyun/loms/order/status/4" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0拒单
*/
+(void)requestRejectOrderumber:(NSString *)number
                        reason:(NSString *)reason
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"reason":RequestStrKey(reason),
                           @"number":RequestStrKey(number)};
        [self putUrl:@"/loms/order/status/99/driver/{number}" delegate:delegate parameters:dic success:success failure:failure];
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
                      startTime:(double)startTime
                        endTime:(double)endTime
                   orderStatues:(NSString *)orderStatues
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                           @"orderNumber":RequestStrKey(orderNumber),
                           @"shipperName":RequestStrKey(shipperName),
                           @"plateNumber":RequestStrKey(plateNumber),
                           @"driverName":RequestStrKey(driverName),
                              @"startTime":RequestDoubleKey(startTime),
                              @"endTime":RequestDoubleKey(endTime),
                              @"orderStatues":RequestStrKey(orderStatues),

        };
        [self getUrl:@"/loms/order/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0 运单详情(司机)
*/
+(void)requestOrderDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"number":RequestStrKey(number),};
        [self getUrl:@"/loms/order/driver/{number}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0接单-自有运单
*/
+(void)requestAcceptSelfPossessOrderWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"number":RequestStrKey(number)};
        [self putUrl:@"/tms/lo/status/2/{number}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0装车-自有运单
*/
+(void)requestLoadSelfPossessOrderWithUrls:(NSString *)urls
                number:(NSString *)number
                               description:(NSString *)description
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"urls":RequestStrKey(urls),
                              @"description":RequestStrKey(description),
                           @"number":RequestStrKey(number)};
        [self putUrl:@"/tms/lo/status/3/{number}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
2.0卸车-自有运单
*/
+(void)requestUnloadSelfPossessOrderWithUrls:(NSString *)urls
                number:(NSString *)orderNumber
                                 description:(NSString *)description
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"urls":RequestStrKey(urls),
                              @"description":RequestStrKey(description),
                           @"number":RequestStrKey(orderNumber)};
        [self putUrl:@"/tms/lo/status/4/{number}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0拒单-自有运单
*/
+(void)requestRejectSelfPossessOrderumber:(NSString *)number
                        reason:(NSString *)reason
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"reason":RequestStrKey(reason),
                           @"number":RequestStrKey(number)};
        [self putUrl:@"/tms/lo/status/99/driver/{number}" delegate:delegate parameters:dic success:success failure:failure];
}

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
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                           @"orderNumber":RequestStrKey(orderNumber),
                           @"shipperName":RequestStrKey(shipperName),
                           @"plateNumber":RequestStrKey(plateNumber),
                           @"driverName":RequestStrKey(driverName),
                              @"startTime":RequestDoubleKey(startTime),
                              @"endTime":RequestDoubleKey(endTime),
                              @"orderStatues":RequestStrKey(orderStatues),

        };
        [self getUrl:@"/tms/lo/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
2.0 运单详情(司机)-自有运单
*/
+(void)requestSelfPossessOrderDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"number":RequestStrKey(number),};
        [self getUrl:@"/tms/lo/driver/{number}" delegate:delegate parameters:dic success:success failure:failure];
}

@end
