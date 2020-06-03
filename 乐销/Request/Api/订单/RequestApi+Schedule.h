//
//  RequestApi+Schedule.h
//  Driver
//
//  Created by 隋林栋 on 2019/11/25.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Schedule)
/**
 详情（分享）
 */
+(void)requestScheduleDetailWithNumber:(NSString *)number
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

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
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 司机扫码下单
 */
+(void)requestScheduleConfirmWithPlannumber:(NSString *)planNumber
                                  vehicleId:(double)vehicleId
                                driverPhone:(NSString *)driverPhone
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
