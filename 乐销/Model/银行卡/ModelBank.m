//
//  ModelBank.m
//
//  Created by 林栋 隋 on 2019/9/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelBank.h"


NSString *const kModelBankAccountNumber = @"accountNumber";
NSString *const kModelBankBankName = @"bankName";
NSString *const kModelBankIdNumber = @"idNumber";
NSString *const kModelBankId = @"id";
NSString *const kModelBankBankNumber = @"bankNumber";
NSString *const kModelBankAccountType = @"accountType";
NSString *const kModelBankAccountName = @"accountName";
NSString *const kModelBankCityName = @"cityName";
NSString *const kModelBankIsInterbank = @"isInterbank";


@interface ModelBank ()
@end

@implementation ModelBank

@synthesize accountNumber = _accountNumber;
@synthesize bankName = _bankName;
@synthesize idNumber = _idNumber;
@synthesize iDProperty = _iDProperty;
@synthesize bankNumber = _bankNumber;
@synthesize accountType = _accountType;
@synthesize accountName = _accountName;
@synthesize cityName = _cityName;
@synthesize isInterbank = _isInterbank;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.accountNumber = [dict stringValueForKey:kModelBankAccountNumber];
            self.bankName = [dict stringValueForKey:kModelBankBankName];
            self.idNumber = [dict stringValueForKey:kModelBankIdNumber];
            self.iDProperty = [dict doubleValueForKey:kModelBankId];
            self.bankNumber = [dict stringValueForKey:kModelBankBankNumber];
            self.accountType = [dict doubleValueForKey:kModelBankAccountType];
            self.accountName = [dict stringValueForKey:kModelBankAccountName];
            self.cityName = [dict stringValueForKey:kModelBankCityName];
            self.isInterbank = [dict doubleValueForKey:kModelBankIsInterbank];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.accountNumber forKey:kModelBankAccountNumber];
    [mutableDict setValue:self.bankName forKey:kModelBankBankName];
    [mutableDict setValue:self.idNumber forKey:kModelBankIdNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelBankId];
    [mutableDict setValue:self.bankNumber forKey:kModelBankBankNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.accountType] forKey:kModelBankAccountType];
    [mutableDict setValue:self.accountName forKey:kModelBankAccountName];
    [mutableDict setValue:self.cityName forKey:kModelBankCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isInterbank] forKey:kModelBankIsInterbank];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
