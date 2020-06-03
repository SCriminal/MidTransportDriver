//
//  RequestApi+TransportPrice.m
//中车运
//
//  Created by 隋林栋 on 2018/11/6.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi+TransportPrice.h"

@implementation RequestApi (TransportPrice)
/**
 - 地区获取
 */
+(void)requestFetchRegionWithId:(NSString *)id//地域上级id
delegate:(_Nullable id <RequestDelegate>) delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":UnPackStr(id)};
    [self postUrl:@"/region/get" delegate:delegate parameters:dic success:success failure:failure];
}

@end
