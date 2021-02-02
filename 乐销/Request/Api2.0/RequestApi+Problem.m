//
//  RequestApi+Problem.m
//  Driver
//
//  Created by 隋林栋 on 2021/2/2.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi+Problem.h"

@implementation RequestApi (Problem)

/**
提交（司机）
*/
+(void)requestProblemWithProblemtype:(double)problemType
                type:(double)type
                description:(NSString *)description
                submitUrl1:(NSString *)submitUrl1
                submitUrl2:(NSString *)submitUrl2
                submitUrl3:(NSString *)submitUrl3
                waybillNumber:(NSString *)waybillNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"problemType":RequestLongKey(problemType),
                           @"type":RequestLongKey(type),
                           @"description":RequestStrKey(description),
                           @"submitUrl1":RequestStrKey(submitUrl1),
                           @"submitUrl2":RequestStrKey(submitUrl2),
                           @"submitUrl3":RequestStrKey(submitUrl3),
                           @"waybillNumber":RequestStrKey(waybillNumber)};
        [self postUrl:@"/zhongcheyun/ticket/status/1/driver" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表（司机）
*/
+(void)requestProblemListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":RequestLongKey(page),
                       @"count":RequestLongKey(count)};
        [self getUrl:@"/zhongcheyun/ticket/list/driver/total" delegate:delegate parameters:dic success:success failure:failure];
}
@end
