//
//  RequestApi+Schedule.m
//  Driver
//
//  Created by 隋林栋 on 2019/11/25.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+Schedule.h"

@implementation RequestApi (Schedule)
/**
 详情（分享）
 */
+(void)requestScheduleDetailWithNumber:(NSString *)number
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"number":RequestStrKey(number)};
    [self getUrl:@"/zhongcheyun/cargoplan/1_0_65/simple" delegate:delegate parameters:dic returnALL:true success:success failure:failure];
}


/**
 扫码列表(司机)
 */
+(void)requestScheduleListWithPlannumber:(NSString *)planNumber
                           waybillNumber:(NSString *)waybillNumber
                              driverName:(NSString *)driverName
                             driverPhone:(NSString *)driverPhone
                           vehicleNumber:(NSString *)vehicleNumber
                               startTime:(double)startTime
                                 endTime:(double)endTime
                                  states:(NSString *)states
                                    page:(double)page
                                   count:(double)count
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"planNumber":RequestStrKey(planNumber),
                          @"waybillNumber":RequestStrKey(waybillNumber),
                          @"driverName":RequestStrKey(driverName),
                          @"driverPhone":RequestStrKey(driverPhone),
                          @"vehicleNumber":RequestStrKey(vehicleNumber),
                          @"startTime":NSNumber.dou(startTime),
                          @"endTime":NSNumber.dou(endTime),
                          @"states":RequestStrKey(states),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/zhongcheyun/bulkcargotempwaybill/1_0_65/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 司机扫码下单
 */
+(void)requestScheduleConfirmWithPlannumber:(NSString *)planNumber
                                  vehicleId:(double)vehicleId
                                driverPhone:(NSString *)driverPhone
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"planNumber":RequestStrKey(planNumber),
                          @"vehicleId":NSNumber.dou(vehicleId),
                          @"driverPhone":RequestStrKey(driverPhone)};
    [self postUrl:@"/zhongcheyun/bulkcargotempwaybill/1_0_65" delegate:delegate parameters:dic success:success failure:failure];
}
@end
