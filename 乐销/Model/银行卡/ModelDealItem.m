//
//  ModelDealItem.m
//
//  Created by 林栋 隋 on 2021/1/30
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelDealItem.h"


NSString *const kModelDealItemDescription = @"description";
NSString *const kModelDealItemFlowTime = @"flowTime";
NSString *const kModelDealItemIdNumber = @"idNumber";
NSString *const kModelDealItemRealName = @"realName";
NSString *const kModelDealItemCellphone = @"cellphone";
NSString *const kModelDealItemSrcNumber = @"srcNumber";
NSString *const kModelDealItemAmt = @"amt";
NSString *const kModelDealItemAccountType = @"accountType";
NSString *const kModelDealItemUserId = @"userId";
NSString *const kModelDealItemRemainAmt = @"remainAmt";
NSString *const kModelDealItemChargeType = @"chargeType";
NSString *const kModelDealItemDirection = @"direction";
NSString *const kModelDealItemFlowNumber = @"flowNumber";


@interface ModelDealItem ()
@end

@implementation ModelDealItem

@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize flowTime = _flowTime;
@synthesize idNumber = _idNumber;
@synthesize realName = _realName;
@synthesize cellphone = _cellphone;
@synthesize srcNumber = _srcNumber;
@synthesize amt = _amt;
@synthesize accountType = _accountType;
@synthesize userId = _userId;
@synthesize remainAmt = _remainAmt;
@synthesize chargeType = _chargeType;
@synthesize direction = _direction;
@synthesize flowNumber = _flowNumber;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.internalBaseClassDescription = [dict stringValueForKey:kModelDealItemDescription];
            self.flowTime = [dict doubleValueForKey:kModelDealItemFlowTime];
            self.idNumber = [dict stringValueForKey:kModelDealItemIdNumber];
            self.realName = [dict stringValueForKey:kModelDealItemRealName];
            self.cellphone = [dict stringValueForKey:kModelDealItemCellphone];
            self.srcNumber = [dict stringValueForKey:kModelDealItemSrcNumber];
            self.amt = [dict doubleValueForKey:kModelDealItemAmt];
            self.accountType = [dict doubleValueForKey:kModelDealItemAccountType];
            self.userId = [dict doubleValueForKey:kModelDealItemUserId];
            self.remainAmt = [dict doubleValueForKey:kModelDealItemRemainAmt];
            self.chargeType = [dict doubleValueForKey:kModelDealItemChargeType];
            self.direction = [dict doubleValueForKey:kModelDealItemDirection];
            self.flowNumber = [dict stringValueForKey:kModelDealItemFlowNumber];
//        1充值提现2借款还款3冻结解冻4运费消费5其他消费
        switch ((int)self.chargeType) {
            case 1:
                self.chargeTypeShow = @"充值提现";
                break;
            case 2:
                self.chargeTypeShow = @"借款还款";
                break;
            case 3:
                self.chargeTypeShow = @"冻结解冻";
                break;
            case 4:
                self.chargeTypeShow = @"运费消费";
                break;
            case 5:
                self.chargeTypeShow = @"其他消费";
                break;
            default:
                break;
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelDealItemDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.flowTime] forKey:kModelDealItemFlowTime];
    [mutableDict setValue:self.idNumber forKey:kModelDealItemIdNumber];
    [mutableDict setValue:self.realName forKey:kModelDealItemRealName];
    [mutableDict setValue:self.cellphone forKey:kModelDealItemCellphone];
    [mutableDict setValue:self.srcNumber forKey:kModelDealItemSrcNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.amt] forKey:kModelDealItemAmt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.accountType] forKey:kModelDealItemAccountType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelDealItemUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.remainAmt] forKey:kModelDealItemRemainAmt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.chargeType] forKey:kModelDealItemChargeType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.direction] forKey:kModelDealItemDirection];
    [mutableDict setValue:self.flowNumber forKey:kModelDealItemFlowNumber];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
