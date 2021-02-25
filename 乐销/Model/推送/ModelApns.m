//
//  ModelApns.m
//
//  Created by sld s on 2019/1/7
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelApns.h"
/*
 平台
 车辆审核通过/拒绝

 绑定车辆的司机
 您的车辆鲁V12345认证已审核通过！ 您的车辆鲁V12345认证审核不通过！
 APP通知
 认证消息

 {
 type:1
 }
 平台
 司机审核通过/拒绝

 司机
 您的身份认证已审核通过！ 您的身份认证审核未通过！
 APP通知
 认证消息

 {
 type:2
 }
 平台
 营运审核通过/拒绝

 司机
 您的营运认证已审核通过！您的营运认证审核未通过！
 APP通知
 认证消息

 {
 type:3
 }
 平台
 企业审核通过/拒绝

 企业
 您的企业认证已审核通过！您的企业认证审核未通过！
 APP通知
 认证消息

 {
 type:4
 }
 平台
 更新提交车辆认证信息

 绑定车辆的司机
 您的车辆鲁V12345认证已审核通过！ 您的车辆鲁V12345认证审核不通过！
 APP通知
 认证消息

 {
 type:5
 }
 平台
 更新提交司机认证信息

 司机
 您的身份认证已审核通过！ 您的身份认证审核未通过！
 APP通知
 认证消息

 {
 type:6
 }
 平台
 更新提交营运认证信息

 司机
 您的营运认证已审核通过！您的营运认证审核未通过！
 APP通知
 认证消息

 {
 type:7
 }
 平台
 更新提交企业认证信息

 企业
 您的企业认证已审核通过！您的企业认证审核未通过！
 APP通知
 认证消息

 {
 type:8
 }
 司机
 司机接单(熟车)

 托运人、运输公司
 运单202011021232230001，已接单！
 APP通知
 运单消息

 {
 type:9
 }
 托运人、运输公司
 托运人同意（报价与抢单）

 司机
 您的报价202011021232230001，已被同意，运单号202011021232230001！您的抢单202011021232230001，已被同意，运单号202011021232230001！您的报价202011021232230001，已被拒绝！
 APP通知
 运单消息

 {
 type:10
 }
 司机
 装车

 托运人、运输公司
 运单202011021232230001，已完成装车！
 APP通知
 运单消息

 {
 type:11
 }
 司机
 卸车

 托运人、运输公司
 运单202011021232230001，已完成卸车！
 APP通知
 运单消息

 {
 type:12
 }
 平台
 充值

 托运人、运输公司、司机
 您的账户于2020年12月12日 12:12:12充值了xxxx元！
 APP通知
 其他消息

 {
 type:13
 }
 平台
 消费

 托运人、运输公司、司机
 您的账户于2020年12月12日 12:12:12消费了xxxx元！
 APP通知
 其他消息

 {
 type:14
 }
 平台
 授信

 托运人、运输公司、司机
 您的授信额度调整为XXXXX元！
 APP通知
 其他消息

 {
 type:15
 }
 平台
 冻结

 托运人、运输公司、司机
 您的账户有xxx元已被冻结！您的账户有xxx元已被解冻！
 APP通知
 其他消息

 {
 type:16
 }
 平台
 费用账单核销

 托运人、运输公司、司机
 您的账单（2342423434）已生成！您的账单（2342423434）已核销！
 APP通知
 其他消息

 {
 type:17
 }
 托运人、运输公司
 发布运单后，后台服务匹配

 司机
 您附近有新的货源信息，赶快去看看把！
 APP通知
 配货消息

 {
 type:18
 }










 */

NSString *const kModelApnsId = @"id";
NSString *const kModelApnsType = @"type";
NSString *const kModelApnsDesc = @"desc";


@interface ModelApns ()
@end

@implementation ModelApns

@synthesize type = _type;
@synthesize desc = _desc;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.ids = [dict arrayValueForKey:kModelApnsId];
        self.type = [dict doubleValueForKey:kModelApnsType];
        self.desc = [[[dict dictionaryValueForKey:@"aps"] dictionaryValueForKey:@"alert"] stringValueForKey:@"body"];
        self.isSilent =  [[dict dictionaryValueForKey:@"aps"] doubleValueForKey:@"content-available"];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
   
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end

