//
//  RequestApi+Location.m
//  Driver
//
//  Created by 隋林栋 on 2019/6/5.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+Location.h"

@implementation RequestApi (Location)
/**
 添加车辆地理位置
 */
+(void)requestAddLocationWithLng:(double)lng
                                   addr:(NSString *)addr
                                    lat:(double)lat
                                    spd:(long)spd
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSString * plateNumber = [GlobalMethod readStrFromUser:LOCAL_PLATE_NUMBER];
    NSDictionary *dic = @{
                          @"lng":NSNumber.dou(lng),
                          @"addr":UnPackStr(addr),
                          @"lat":NSNumber.dou(lat),
                          @"spd":NSNumber.lon(spd),
                          @"terminalType":@4,
                          @"writeType":@2,
                          @"plateNumber":isStr(plateNumber)?plateNumber:[NSNull null]
                          };
    [self putUrl:@"/location/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 查询车辆地理位置
 */
+(void)requestCarLocationWithStartTime:(double)startTime
                                endTime:(double)endTime
                           orderNumber:(NSString *)orderNumber
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
                          @"startTime":NSNumber.lon(startTime),
                          @"endTime":NSNumber.lon(endTime),
                          @"orderNumber":RequestStrKey(orderNumber),
                          @"sortCreateTime":@3,
                          @"displayTypes":@2
                          };
    [self getUrl:@"/location/trail/order/2_2_0/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 添加车辆地理位置
 */
+(void)requestAddLocationsWithData:(NSString *)data
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"data":RequestStrKey(data),
                          @"writeType":@2,

    };
    [self postUrl:@"/location/trail/list" delegate:delegate parameters:dic success:success failure:failure];
}

@end
