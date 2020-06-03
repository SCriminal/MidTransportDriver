//
//  ModelMotrocadeList.m
//
//  Created by 林栋 隋 on 2019/6/13
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelMotrocadeList.h"


NSString *const kModelMotrocadeListEntName = @"entName";
NSString *const kModelMotrocadeListVehicleNumber = @"vehicleNumber";
NSString *const kModelMotrocadeListEntId = @"entId";
NSString *const kModelMotrocadeListDate = @"date";
NSString *const kModelMotrocadeListCode = @"code";


@interface ModelMotrocadeList ()
@end

@implementation ModelMotrocadeList

@synthesize entName = _entName;
@synthesize vehicleNumber = _vehicleNumber;
@synthesize entId = _entId;
@synthesize date = _date;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.entName = [dict stringValueForKey:kModelMotrocadeListEntName];
        self.vehicleNumber = [dict stringValueForKey:kModelMotrocadeListVehicleNumber];
        self.entId = [dict doubleValueForKey:kModelMotrocadeListEntId];
        self.date = [dict doubleValueForKey:kModelMotrocadeListDate];
        self.code = [dict stringValueForKey:kModelMotrocadeListCode];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.entName forKey:kModelMotrocadeListEntName];
    [mutableDict setValue:self.vehicleNumber forKey:kModelMotrocadeListVehicleNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelMotrocadeListEntId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kModelMotrocadeListDate];
    [mutableDict setValue:self.code forKey:kModelMotrocadeListCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
