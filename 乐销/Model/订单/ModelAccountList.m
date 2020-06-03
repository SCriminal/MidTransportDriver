//
//  ModelAccountList.m
//
//  Created by sld s on 2019/6/6
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAccountList.h"


NSString *const kModelAccountListWaybillId = @"waybillId";
NSString *const kModelAccountListDataState = @"dataState";
NSString *const kModelAccountListCreateTime = @"createTime";
NSString *const kModelAccountListId = @"id";
NSString *const kModelAccountListUserId = @"userId";
NSString *const kModelAccountListBillNumber = @"billNumber";
NSString *const kModelAccountListEntId = @"entId";
NSString *const kModelAccountListWaybillNumber = @"waybillNumber";
NSString *const kModelAccountListFee = @"fee";
NSString *const kModelAccountListDescription = @"description";
NSString *const kModelAccountListType = @"type";


@interface ModelAccountList ()
@end

@implementation ModelAccountList

@synthesize waybillId = _waybillId;
@synthesize dataState = _dataState;
@synthesize iDProperty = _iDProperty;
@synthesize userId = _userId;
@synthesize billNumber = _billNumber;
@synthesize entId = _entId;
@synthesize waybillNumber = _waybillNumber;
@synthesize fee = _fee;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize type = _type;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.waybillId = [dict doubleValueForKey:kModelAccountListWaybillId];
            self.dataState = [dict doubleValueForKey:kModelAccountListDataState];
            self.createTime = [dict doubleValueForKey:kModelAccountListCreateTime];
            self.iDProperty = [dict doubleValueForKey:kModelAccountListId];
            self.userId = [dict doubleValueForKey:kModelAccountListUserId];
            self.billNumber = [dict stringValueForKey:kModelAccountListBillNumber];
            self.entId = [dict doubleValueForKey:kModelAccountListEntId];
            self.waybillNumber = [dict stringValueForKey:kModelAccountListWaybillNumber];
            self.fee = [dict doubleValueForKey:kModelAccountListFee];
            self.iDPropertyDescription = [dict stringValueForKey:kModelAccountListDescription];
            self.type = [dict doubleValueForKey:kModelAccountListType];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waybillId] forKey:kModelAccountListWaybillId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataState] forKey:kModelAccountListDataState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelAccountListCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAccountListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelAccountListUserId];
    [mutableDict setValue:self.billNumber forKey:kModelAccountListBillNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelAccountListEntId];
    [mutableDict setValue:self.waybillNumber forKey:kModelAccountListWaybillNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fee] forKey:kModelAccountListFee];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelAccountListDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelAccountListType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
