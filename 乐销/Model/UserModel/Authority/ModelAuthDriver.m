//
//  ModelAuthDriver.m
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthDriver.h"


NSString *const kModelAuthDriverIdFaceUrl = @"idFaceUrl";
NSString *const kModelAuthDriverIdNumber = @"idNumber";
NSString *const kModelAuthDriverSubmitTime = @"submitTime";
NSString *const kModelAuthDriverReviewTime = @"reviewTime";
NSString *const kModelAuthDriverSubmitterId = @"submitterId";
NSString *const kModelAuthDriverVehicleUrl = @"vehiclePersonUrl";
NSString *const kModelAuthDriverReviewStatus = @"reviewStatus";
NSString *const kModelAuthDriverDriverUrl = @"dlUrl";
NSString *const kModelAuthDriverIdEmblemUrl = @"idEmblemUrl";
NSString *const kModelAuthDriverReviewerId = @"reviewerId";
NSString *const kModelAuthDriverName = @"realName";


@interface ModelAuthDriver ()
@end

@implementation ModelAuthDriver

@synthesize idFaceUrl = _idFaceUrl;
@synthesize idNumber = _idNumber;
@synthesize submitTime = _submitTime;
@synthesize reviewTime = _reviewTime;
@synthesize submitterId = _submitterId;
@synthesize vehicleUrl = _vehicleUrl;
@synthesize reviewStatus = _reviewStatus;
@synthesize driverUrl = _driverUrl;
@synthesize idEmblemUrl = _idEmblemUrl;
@synthesize reviewerId = _reviewerId;
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
            self.idFaceUrl = [dict stringValueForKey:kModelAuthDriverIdFaceUrl];
            self.idNumber = [dict stringValueForKey:kModelAuthDriverIdNumber];
            self.submitTime = [dict doubleValueForKey:kModelAuthDriverSubmitTime];
            self.reviewTime = [dict doubleValueForKey:kModelAuthDriverReviewTime];
            self.submitterId = [dict doubleValueForKey:kModelAuthDriverSubmitterId];
            self.vehicleUrl = [dict stringValueForKey:kModelAuthDriverVehicleUrl];
            self.reviewStatus = [dict doubleValueForKey:kModelAuthDriverReviewStatus];
            self.driverUrl = [dict stringValueForKey:kModelAuthDriverDriverUrl];
            self.idEmblemUrl = [dict stringValueForKey:kModelAuthDriverIdEmblemUrl];
            self.reviewerId = [dict doubleValueForKey:kModelAuthDriverReviewerId];
            self.name = [dict stringValueForKey:kModelAuthDriverName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.idFaceUrl forKey:kModelAuthDriverIdFaceUrl];
    [mutableDict setValue:self.idNumber forKey:kModelAuthDriverIdNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelAuthDriverSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelAuthDriverReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitterId] forKey:kModelAuthDriverSubmitterId];
    [mutableDict setValue:self.vehicleUrl forKey:kModelAuthDriverVehicleUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewStatus] forKey:kModelAuthDriverReviewStatus];
    [mutableDict setValue:self.driverUrl forKey:kModelAuthDriverDriverUrl];
    [mutableDict setValue:self.idEmblemUrl forKey:kModelAuthDriverIdEmblemUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerId] forKey:kModelAuthDriverReviewerId];
    [mutableDict setValue:self.name forKey:kModelAuthDriverName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
