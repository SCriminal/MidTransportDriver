//
//  RequestApi+Integral.m
//  Driver
//
//  Created by 隋林栋 on 2021/2/2.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi+Integral.h"
#import "NSDate+Format.h"
#import "NSDate+YYAdd.h"

@implementation RequestApi (Integral)
/**
每日签到[^/zhongcheyun/point/day$]
*/
+(void)requestSignWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{};
        [self postUrl:@"/zhongcheyun/point/day" delegate:delegate parameters:dic success:success failure:failure];
}
/**
获取[^/zhongcheyun/point$]
*/
+(void)requestIntegralNumWithDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{};
        [self getUrl:@"/zhongcheyun/point" delegate:delegate parameters:dic success:success failure:failure];
}

/**
列表（签到）[^/zhongcheyun/point/log/list/sign/total$]
*/
+(void)requestSignListDelegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSString * strFirst = [NSDate currentScopeWeek:2 dateFormat:TIME_DAY_SHOW];
    NSDate * dateFirst = [GlobalMethod exchangeStringToDate:strFirst formatter:TIME_DAY_SHOW];
    NSDate * dateEnd = [dateFirst dateByAddingDays:7];
        NSDictionary *dic = @{@"startPointTime":NSNumber.lon(dateFirst.timeIntervalSince1970),
                           @"endPointTime":NSNumber.lon(dateEnd.timeIntervalSince1970),
                           @"page":NSNumber.dou(1),
                           @"count":NSNumber.dou(100)};
        [self getUrl:@"/zhongcheyun/point/log/list/sign/total" delegate:delegate parameters:dic success:success failure:failure];
}



@end
