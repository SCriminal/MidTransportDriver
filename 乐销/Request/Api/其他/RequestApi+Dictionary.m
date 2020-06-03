//
//  RequestApi+Dictionary.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/29.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+Dictionary.h"

@implementation RequestApi (Dictionary)
/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/dict/containerarea/1/1/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/zhongcheyun/dict/containerarea/1/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/zhongcheyun/dict/containerarea/1/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
}




/**
 添加反馈
 */
+(void)requestAddFeedbackWithBetter:(NSString *)better
                                bad:(NSString *)bad
                                app:(NSString *)app
                        teminalType:(double)teminalType
                             userId:(double)userId
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"better":RequestStrKey(better),
                          @"bad":RequestStrKey(bad),
                          @"app":@"1",
                          @"terminalType":@1,
                          @"userId":NSNumber.dou(userId)};
    [self postUrl:@"/zhongcheyun/feedback" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 箱型下拉列表
 */
+(void)requestPackageTypeWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/dict/containertype/list/option" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        NSMutableArray * aryModels = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageType"];
        [GlobalMethod writeAry:aryModels key:LOCAL_PACKAGE_TYPE];
    } failure:failure];
}
/**
 银行列表
 */
+(void)requestBankListWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/dict/bank/1_0_35/label/list" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 删除
 */
+(void)requestDeleteBankCardWithId:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(id)};
    [self deleteUrl:@"/zhongcheyun/bankaccount/user/1_0_25/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增
 */
+(void)requestAddBankCardWithAccountNumber:(NSString *)accountNumber
                                bankName:(NSString *)bankName
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
                          @"accountNumber":RequestStrKey(accountNumber),
                          @"bankName":RequestStrKey(bankName)};
    [self postUrl:@"/zhongcheyun/bankaccount/user/1_0_25" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 更新
 */
+(void)requestEditBankCardWithAccountnumber:(NSString *)accountNumber
                                   bankName:(NSString *)bankName
                                         id:(double)identity
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"accountNumber":RequestStrKey(accountNumber),
                          @"bankName":RequestStrKey(bankName),
                          @"id":NSNumber.dou(identity),
                          };
    [self patchUrl:@"/zhongcheyun/bankaccount/user/1_0_25/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取当前用户银行账户信息
 */
+(void)requestBankCardWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/bankaccount/user/1_0_25" delegate:delegate parameters:dic success:success failure:failure];
}


@end
