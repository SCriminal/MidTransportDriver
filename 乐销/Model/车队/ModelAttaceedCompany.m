//
//  ModelAttaceedCompany.m
//
//  Created by 林栋 隋 on 2019/12/11
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAttaceedCompany.h"


NSString *const kModelAttaceedCompanyId = @"id";
NSString *const kModelAttaceedCompanyCode = @"code";
NSString *const kModelAttaceedCompanyEntCode = @"entCode";
NSString *const kModelAttaceedCompanyEntId = @"entId";
NSString *const kModelAttaceedCompanyDate = @"date";
NSString *const kModelAttaceedCompanyEntName = @"entName";
NSString *const kModelAttaceedCompanyLabel = @"label";
NSString *const kModelAttaceedCompanyValue = @"value";
NSString *const kModelAttaceedCompanyName = @"name";
NSString *const kModelAttaceedCompanyVehicleNumber = @"vehicleNumber";
NSString *const kModelAttaceedCompanyCreateTime = @"createTime";
NSString *const kModelAttaceedCompanyApplyTime = @"applyTime";


@interface ModelAttaceedCompany ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *entName;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *entCode;
@end

@implementation ModelAttaceedCompany

@synthesize iDProperty = _iDProperty;
@synthesize code = _code;
@synthesize entId = _entId;
@synthesize date = _date;
@synthesize entName = _entName;
@synthesize label = _label;
@synthesize value = _value;
@synthesize name = _name;
@synthesize vehicleNumber = _vehicleNumber;


- (NSString *)codeShow{
    return isStr(self.code)?self.code:self.entCode;
}
- (NSString *)nameShow{
    return isStr(self.name)?self.name:self.entName;
}

#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDProperty = [dict doubleValueForKey:kModelAttaceedCompanyId];
            self.code = [dict stringValueForKey:kModelAttaceedCompanyCode];
            self.entId = [dict doubleValueForKey:kModelAttaceedCompanyEntId];
            self.date = [dict doubleValueForKey:kModelAttaceedCompanyDate];
            self.entName = [dict stringValueForKey:kModelAttaceedCompanyEntName];
            self.label = [dict stringValueForKey:kModelAttaceedCompanyLabel];
            self.value = [dict stringValueForKey:kModelAttaceedCompanyValue];
            self.name = [dict stringValueForKey:kModelAttaceedCompanyName];
            self.vehicleNumber = [dict stringValueForKey:kModelAttaceedCompanyVehicleNumber];
        self.createTime = [dict doubleValueForKey:kModelAttaceedCompanyCreateTime];
        self.entCode = [dict stringValueForKey:kModelAttaceedCompanyEntCode];
        self.applyTime = [dict doubleValueForKey:kModelAttaceedCompanyApplyTime];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAttaceedCompanyId];
    [mutableDict setValue:self.code forKey:kModelAttaceedCompanyCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelAttaceedCompanyEntId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kModelAttaceedCompanyDate];
    [mutableDict setValue:self.entName forKey:kModelAttaceedCompanyEntName];
    [mutableDict setValue:self.label forKey:kModelAttaceedCompanyLabel];
    [mutableDict setValue:self.value forKey:kModelAttaceedCompanyValue];
    [mutableDict setValue:self.name forKey:kModelAttaceedCompanyName];
    [mutableDict setValue:self.vehicleNumber forKey:kModelAttaceedCompanyVehicleNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelAttaceedCompanyCreateTime];
    [mutableDict setValue:self.entCode forKey:kModelAttaceedCompanyEntCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyTime] forKey:kModelAttaceedCompanyApplyTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
