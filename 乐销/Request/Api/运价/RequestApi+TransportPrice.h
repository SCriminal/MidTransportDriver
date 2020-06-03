//
//  RequestApi+TransportPrice.h
//中车运
//
//  Created by 隋林栋 on 2018/11/6.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (TransportPrice)
/**
 - 地区获取
 */
+(void)requestFetchRegionWithId:(NSString *)id//地域上级id
delegate:(_Nullable id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;

@end

NS_ASSUME_NONNULL_END
