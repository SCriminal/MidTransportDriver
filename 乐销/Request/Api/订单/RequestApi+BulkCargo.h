//
//  RequestApi+BulkCargo.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ENUM_BULKCARGO_ORDER_OPERATE_TYPE) {
    ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE = 0,
    ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE,//接单
    ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD,//装货
    ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD,//卸货
    ENUM_BULKCARGO_ORDER_OPERATE_CLOSE,//关闭
    ENUM_BULKCARGO_ORDER_OPERATE_ARRIVE,//到达
};


@interface RequestApi (BulkCargo)
/**
 散货单列表-总数-司机
 */
+(void)requestBulkCargoOrderListWithwaybillStates:(NSString *)waybillState
                                            page:(double)page
                                           count:(double)count
                                   sortAcceptTime:(int)sortAcceptTime
                                   sortFinishTime:(int)sortFinishTime
                                   sortCreateTime:(int)sortCreateTime
                                        delegate:(id <RequestDelegate>)delegate
                                         success:(void (^)(NSDictionary * response, id mark))success
                                         failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 散货单详情-用户（司机）
 */
+(void)requestBulkCargoDetailWithId:(NSString *)identity
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;




/**
 拒单-司机（用户）
 */
+(void)requestOperateBulkCargoRejectWithReason:(NSString *)reason
                                            id:(double)identity 
                                      delegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;
//司机操作
+ (void)requestOperateBulkCargoOrder:(double)identytiy
                         operateType:(ENUM_BULKCARGO_ORDER_OPERATE_TYPE)operateType
                                 url:(NSString *)url
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
