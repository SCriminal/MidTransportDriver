//
//  ModelAuditRecord.m
//
//  Created by 林栋 隋 on 2020/6/8
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelAuditRecord.h"


NSString *const kModelAuditRecordSubmitterName = @"submitterName";
NSString *const kModelAuditRecordState = @"state";
NSString *const kModelAuditRecordSubmitTime = @"submitTime";
NSString *const kModelAuditRecordId = @"id";
NSString *const kModelAuditRecordSubmitterId = @"submitterId";
NSString *const kModelAuditRecordVehicleId = @"vehicleId";
NSString *const kModelAuditRecordDescription = @"description";
NSString *const kModelAuditRecordReviewerId = @"reviewerId";
NSString *const kModelAuditRecordCreateTime = @"createTime";


@interface ModelAuditRecord ()
@end

@implementation ModelAuditRecord

@synthesize submitterName = _submitterName;
@synthesize state = _state;
@synthesize submitTime = _submitTime;
@synthesize iDProperty = _iDProperty;
@synthesize submitterId = _submitterId;
@synthesize vehicleId = _vehicleId;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize reviewerId = _reviewerId;
@synthesize createTime = _createTime;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.submitterName = [dict stringValueForKey:kModelAuditRecordSubmitterName];
            self.state = [dict doubleValueForKey:kModelAuditRecordState];
            self.submitTime = [dict doubleValueForKey:kModelAuditRecordSubmitTime];
            self.iDProperty = [dict doubleValueForKey:kModelAuditRecordId];
            self.submitterId = [dict doubleValueForKey:kModelAuditRecordSubmitterId];
            self.vehicleId = [dict doubleValueForKey:kModelAuditRecordVehicleId];
            self.iDPropertyDescription = [dict stringValueForKey:kModelAuditRecordDescription];
            self.reviewerId = [dict doubleValueForKey:kModelAuditRecordReviewerId];
            self.createTime = [dict doubleValueForKey:kModelAuditRecordCreateTime];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.submitterName forKey:kModelAuditRecordSubmitterName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelAuditRecordState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelAuditRecordSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAuditRecordId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitterId] forKey:kModelAuditRecordSubmitterId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleId] forKey:kModelAuditRecordVehicleId];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelAuditRecordDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerId] forKey:kModelAuditRecordReviewerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelAuditRecordCreateTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
