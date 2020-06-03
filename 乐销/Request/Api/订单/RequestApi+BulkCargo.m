//
//  RequestApi+BulkCargo.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+BulkCargo.h"

@implementation RequestApi (BulkCargo)
/**
 散货单列表-总数-司机
 */
+(void)requestBulkCargoOrderListWithwaybillStates:(NSString *)waybillStates
                                            page:(double)page
                                           count:(double)count
                                   sortAcceptTime:(int)sortAcceptTime
                                   sortFinishTime:(int)sortFinishTime
                                   sortCreateTime:(int)sortCreateTime
                                        delegate:(id <RequestDelegate>)delegate
                                         success:(void (^)(NSDictionary * response, id mark))success
                                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
                          @"waybillStates":RequestStrKey(waybillStates),
                          @"sortAcceptTime":[NSNumber numberWithInt:sortAcceptTime],
                          @"sortUnloadTime":[NSNumber numberWithInt:sortFinishTime],
                          @"sortCreateTime":[NSNumber numberWithInt:sortCreateTime],
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/zhongcheyun/bulkcargo/waybill/list/1/total/sort" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 散货单详情-用户（司机）
 */
+(void)requestBulkCargoDetailWithId:(NSString *)identity
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(identity)};
    [self getUrl:@"/zhongcheyun/bulkcargo/waybill/1/{id}" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 拒单-司机（用户）
 */
+(void)requestOperateBulkCargoRejectWithReason:(NSString *)reason
                                            id:(double)identity
                                      delegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"reason":RequestStrKey(reason),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/bulkcargo/waybill/99/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
//司机操作
+ (void)requestOperateBulkCargoOrder:(double)identytiy
                         operateType:(ENUM_BULKCARGO_ORDER_OPERATE_TYPE)operateType
                                 url:(NSString *)url
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    /*
     ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE = 0,
     ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE,//接单
     ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD,//装货
     ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD,//卸货
     ENUM_BULKCARGO_ORDER_OPERATE_CLOSE,//关闭
     */
    
    ModelAddress * modelAddressItem = [ModelAddress lastLocation];

    double lng = modelAddressItem.lng;
    double lat = modelAddressItem.lat;
    NSString * add  = modelAddressItem.desc;
    if (lat == 0) {
        [GlobalMethod showAlert:@"暂未获得地理位置，请稍后重试"];
        return;
    }
    switch (operateType) {
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE:
            [self requestOperateBulkCargoAcceptWithId:identytiy lng:lng lat:lat add:add delegate:delegate success:success failure:failure];
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD:
            [self requestOperateBulkCargoLoadWithPoundurl:url id:identytiy lng:lng lat:lat add:add delegate:delegate success:success failure:failure];
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD:
            [self requestOperateBulkCargoUnloadWithReturnurl:url  id:identytiy lng:lng lat:lat add:add delegate:delegate success:success failure:failure];
            break;
            
            
        default:
            break;
    }
}

/**
 接单-司机（用户）
 */
+(void)requestOperateBulkCargoAcceptWithId:(double)identity
                                       lng:(double)lng
                                       lat:(double)lat
                                       add:(NSString *)add
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"id":NSNumber.dou(identity),
                          @"add":RequestStrKey(add)
                          };
    [self patchUrl:@"/zhongcheyun/bulkcargo/waybill/2/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 装车-司机（用户）
 */
+(void)requestOperateBulkCargoLoadWithPoundurl:(NSString *)poundUrl
                                            id:(double)identity
                                           lng:(double)lng
                                           lat:(double)lat
                                           add:(NSString *)add
                                      delegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"urls":RequestStrKey(poundUrl),
                          @"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"id":NSNumber.dou(identity),
                            @"add":RequestStrKey(add)
                          };
    [self patchUrl:@"/zhongcheyun/bulkcargo/waybill/3/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 卸车-司机（用户）
 */
+(void)requestOperateBulkCargoUnloadWithReturnurl:(NSString *)returnUrl
                                               id:(double)identity
                                              lng:(double)lng
                                              lat:(double)lat
                                              add:(NSString *)add
                                         delegate:(id <RequestDelegate>)delegate
                                          success:(void (^)(NSDictionary * response, id mark))success
                                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"urls":RequestStrKey(returnUrl),
                          @"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"id":NSNumber.dou(identity),
                            @"add":RequestStrKey(add)
                          };
    [self patchUrl:@"/zhongcheyun/bulkcargo/waybill/10/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

@end
