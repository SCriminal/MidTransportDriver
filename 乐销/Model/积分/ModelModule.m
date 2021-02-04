//
//  ModelModule.m
//
//  Created by 林栋 隋 on 2021/2/4
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelModule.h"


NSString *const kModelModuleIsOpen = @"isOpen";
NSString *const kModelModuleAlias = @"alias";
NSString *const kModelModuleSort = @"sort";
NSString *const kModelModuleId = @"id";
NSString *const kModelModuleClientTypes = @"clientTypes";
NSString *const kModelModuleClientTypeDesc = @"clientTypeDesc";
NSString *const kModelModuleIconUrl = @"iconUrl";
NSString *const kModelModuleTitle = @"title";
NSString *const kModelModuleTo = @"to";
NSString *const kModelModuleCreateTime = @"createTime";
NSString *const kModelModuleName = @"name";


@interface ModelModule ()
@end

@implementation ModelModule

@synthesize isOpen = _isOpen;
@synthesize alias = _alias;
@synthesize sort = _sort;
@synthesize iDProperty = _iDProperty;
@synthesize clientTypes = _clientTypes;
@synthesize clientTypeDesc = _clientTypeDesc;
@synthesize iconUrl = _iconUrl;
@synthesize title = _title;
@synthesize to = _to;
@synthesize createTime = _createTime;
@synthesize name = _name;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isOpen = [dict doubleValueForKey:kModelModuleIsOpen];
            self.alias = [dict stringValueForKey:kModelModuleAlias];
            self.sort = [dict doubleValueForKey:kModelModuleSort];
            self.iDProperty = [dict doubleValueForKey:kModelModuleId];
            self.clientTypes =  [dict arrayValueForKey:kModelModuleClientTypes];
            self.clientTypeDesc = [dict stringValueForKey:kModelModuleClientTypeDesc];
            self.iconUrl = [dict stringValueForKey:kModelModuleIconUrl];
            self.title = [dict stringValueForKey:kModelModuleTitle];
            self.to = [dict stringValueForKey:kModelModuleTo];
            self.createTime = [dict doubleValueForKey:kModelModuleCreateTime];
            self.name = [dict stringValueForKey:kModelModuleName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isOpen] forKey:kModelModuleIsOpen];
    [mutableDict setValue:self.alias forKey:kModelModuleAlias];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kModelModuleSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelModuleId];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.clientTypes] forKey:kModelModuleClientTypes];
    [mutableDict setValue:self.clientTypeDesc forKey:kModelModuleClientTypeDesc];
    [mutableDict setValue:self.iconUrl forKey:kModelModuleIconUrl];
    [mutableDict setValue:self.title forKey:kModelModuleTitle];
    [mutableDict setValue:self.to forKey:kModelModuleTo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelModuleCreateTime];
    [mutableDict setValue:self.name forKey:kModelModuleName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
