//
//  ModelValidCar.m
//
//  Created by 林栋 隋 on 2019/11/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelValidCar.h"


NSString *const kModelValidCarFleetId = @"fleetId";
NSString *const kModelValidCarVehicleId = @"vehicleId";
NSString *const kModelValidCarVehicleNumber = @"vehicleNumber";
NSString *const kModelValidCarFleetName = @"fleetName";
NSString *const kModelValidCarState = @"state";
NSString *const kModelValidCarId = @"id";


@interface ModelValidCar ()
@end

@implementation ModelValidCar

@synthesize fleetId = _fleetId;
@synthesize vehicleId = _vehicleId;
@synthesize vehicleNumber = _vehicleNumber;
@synthesize fleetName = _fleetName;


-(NSString *)nameShow{
    return [NSString stringWithFormat:@"%@(%@)",UnPackStr(self.vehicleNumber),UnPackStr(self.fleetName)];
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
            self.fleetId = [dict doubleValueForKey:kModelValidCarFleetId];
            self.vehicleId = [dict doubleValueForKey:kModelValidCarVehicleId];
            self.vehicleNumber = [dict stringValueForKey:kModelValidCarVehicleNumber];
            self.fleetName = [dict stringValueForKey:kModelValidCarFleetName];
        self.state = [dict doubleValueForKey:kModelValidCarState];
        self.iDProperty = [dict doubleValueForKey:kModelValidCarId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fleetId] forKey:kModelValidCarFleetId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleId] forKey:kModelValidCarVehicleId];
    [mutableDict setValue:self.vehicleNumber forKey:kModelValidCarVehicleNumber];
    [mutableDict setValue:self.fleetName forKey:kModelValidCarFleetName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelValidCarState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelValidCarId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
