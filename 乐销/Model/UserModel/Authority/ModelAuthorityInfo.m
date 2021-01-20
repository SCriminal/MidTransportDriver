//
//  ModelAuthorityInfo.m
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthorityInfo.h"


NSString *const kModelAuthorityInfoVehicleDescription = @"vehicleDescription";
NSString *const kModelAuthorityInfoDriverReviewTime = @"driverReviewTime";
NSString *const kModelAuthorityInfoDriverSubmitTime = @"driverSubmitTime";
NSString *const kModelAuthorityInfoVehicleReviewTime = @"vehicleReviewTime";
NSString *const kModelAuthorityInfoVehicleSubmitTime = @"vehicleSubmitTime";
NSString *const kModelAuthorityInfoBizSubmitTime = @"bizSubmitTime";
NSString *const kModelAuthorityInfoDriverStatus = @"driverStatus";
NSString *const kModelAuthorityInfoUserId = @"userId";
NSString *const kModelAuthorityInfoVehicleStatus = @"vehicleStatus";
NSString *const kModelAuthorityInfoBizDescription = @"bizDescription";
NSString *const kModelAuthorityInfoDriverDescription = @"driverDescription";
NSString *const kModelAuthorityInfoBizReviewTime = @"bizReviewTime";
NSString *const kModelAuthorityInfoBizStatus = @"bizStatus";


@interface ModelAuthorityInfo ()
@end

@implementation ModelAuthorityInfo

@synthesize vehicleDescription = _vehicleDescription;
@synthesize driverReviewTime = _driverReviewTime;
@synthesize driverSubmitTime = _driverSubmitTime;
@synthesize vehicleReviewTime = _vehicleReviewTime;
@synthesize vehicleSubmitTime = _vehicleSubmitTime;
@synthesize bizSubmitTime = _bizSubmitTime;
@synthesize driverStatus = _driverStatus;
@synthesize userId = _userId;
@synthesize vehicleStatus = _vehicleStatus;
@synthesize bizDescription = _bizDescription;
@synthesize driverDescription = _driverDescription;
@synthesize bizReviewTime = _bizReviewTime;
@synthesize bizStatus = _bizStatus;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.vehicleDescription = [dict objectForKey:kModelAuthorityInfoVehicleDescription];
            self.driverReviewTime = [dict doubleValueForKey:kModelAuthorityInfoDriverReviewTime];
            self.driverSubmitTime = [dict doubleValueForKey:kModelAuthorityInfoDriverSubmitTime];
            self.vehicleReviewTime = [dict doubleValueForKey:kModelAuthorityInfoVehicleReviewTime];
            self.vehicleSubmitTime = [dict doubleValueForKey:kModelAuthorityInfoVehicleSubmitTime];
            self.bizSubmitTime = [dict doubleValueForKey:kModelAuthorityInfoBizSubmitTime];
            self.driverStatus = [dict doubleValueForKey:kModelAuthorityInfoDriverStatus];
            self.userId = [dict doubleValueForKey:kModelAuthorityInfoUserId];
            self.vehicleStatus = [dict doubleValueForKey:kModelAuthorityInfoVehicleStatus];
            self.bizDescription = [dict objectForKey:kModelAuthorityInfoBizDescription];
            self.driverDescription = [dict objectForKey:kModelAuthorityInfoDriverDescription];
            self.bizReviewTime = [dict doubleValueForKey:kModelAuthorityInfoBizReviewTime];
            self.bizStatus = [dict doubleValueForKey:kModelAuthorityInfoBizStatus];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.vehicleDescription forKey:kModelAuthorityInfoVehicleDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverReviewTime] forKey:kModelAuthorityInfoDriverReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverSubmitTime] forKey:kModelAuthorityInfoDriverSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleReviewTime] forKey:kModelAuthorityInfoVehicleReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleSubmitTime] forKey:kModelAuthorityInfoVehicleSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizSubmitTime] forKey:kModelAuthorityInfoBizSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverStatus] forKey:kModelAuthorityInfoDriverStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelAuthorityInfoUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleStatus] forKey:kModelAuthorityInfoVehicleStatus];
    [mutableDict setValue:self.bizDescription forKey:kModelAuthorityInfoBizDescription];
    [mutableDict setValue:self.driverDescription forKey:kModelAuthorityInfoDriverDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizReviewTime] forKey:kModelAuthorityInfoBizReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizStatus] forKey:kModelAuthorityInfoBizStatus];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

- (BOOL)isAuthed{
    if (self.bizStatus>1) {
        return true;
    }
    if (self.driverStatus>1) {
        return true;
    }
    if (self.vehicleStatus>1) {
        return true;
    }
    return false;
}
//1未提交 2审核中 10通过 11未通过

+(UIColor *)statusColor:(int)status{
    switch (status) {
        case 1:
            return COLOR_ORANGE;
            break;
        case 2:
            return COLOR_ORANGE;
            break;
        case 10:
            return COLOR_GREEN;
            break;
        case 11:
            return COLOR_RED;
            break;
        default:
            break;
    }
    return COLOR_BLUE;
}
+(NSString *)statusTitle:(int)status{
    switch (status) {
        case 1:
            return @"未提交";
            break;
        case 2:
            return @"审核中";
            break;
        case 10:
            return @"审核通过";
            break;
        case 11:
            return @"审核未通过";
            break;
        default:
            break;
    }
    return @"未提交";
}
@end
