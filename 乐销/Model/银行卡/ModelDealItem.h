//
//  ModelDealItem.h
//
//  Created by 林栋 隋 on 2021/1/30
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelDealItem : NSObject

@property (nonatomic, strong) NSString * internalBaseClassDescription;
@property (nonatomic, assign) double flowTime;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *cellphone;
@property (nonatomic, strong) NSString *srcNumber;
@property (nonatomic, assign) double amt;
@property (nonatomic, assign) double accountType;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double remainAmt;
@property (nonatomic, assign) double chargeType;
@property (nonatomic, assign) double direction;
@property (nonatomic, strong) NSString *flowNumber;
@property (nonatomic, strong) NSString *chargeTypeShow;//1充值提现2借款还款3冻结解冻4运费消费5其他消费
@property (nonatomic, strong) NSString *chargeTitleShow;//1充值提现2借款还款3冻结解冻4运费消费5其他消费
@property (nonatomic, strong) UIColor *chargeColorShow;//

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
