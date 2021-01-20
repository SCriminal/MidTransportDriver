//
//  RequestApi+Dic.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/19.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi+Dic.h"

@implementation RequestApi (Dic)
/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/area/1/1/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/zhongcheyun/area/1/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/zhongcheyun/area/1/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 ocr
 */
+(void)requestOCRIdentityWithurl:(NSString *)url
                            side:(NSString *)side
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"url":UnPackStr(url),
                          @"side":UnPackStr(side)
    };
    [self getUrl:@"/oss/ocr/id" delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestOCRDriverWithurl:(NSString *)url
                          side:(NSString *)side
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"url":UnPackStr(url),
                          @"side":UnPackStr(side)
    };
    [self getUrl:@"/oss/ocr/driver" delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestOCRBusinessWithurl:(NSString *)url
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"url":UnPackStr(url),
                          @"side":@"face"
    };
    [self getUrl:@"/oss/ocr/biz" delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestOCRDrivingWithurl:(NSString *)url
                          side:(NSString *)side
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"url":UnPackStr(url),
                          @"side":UnPackStr(side)
    };
    [self getUrl:@"/oss/ocr/driving" delegate:delegate parameters:dic success:success failure:failure];
}
@end
