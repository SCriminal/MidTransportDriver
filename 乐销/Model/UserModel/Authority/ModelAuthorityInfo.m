//
//  ModelAuthorityInfo.m
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthorityInfo.h"


NSString *const kModelAuthorityInfoStatus = @"status";
NSString *const kModelAuthorityInfoUserId = @"userId";
NSString *const kModelAuthorityInfoReviewTime = @"reviewTime";
NSString *const kModelAuthorityInfoId = @"id";
NSString *const kModelAuthorityInfoExplain = @"explain";
NSString *const kModelAuthorityInfoSubmitTime = @"submitTime";
NSString *const kModelAuthorityInfoReviewId = @"reviewId";


@interface ModelAuthorityInfo ()
@end

@implementation ModelAuthorityInfo

@synthesize status = _status;
@synthesize userId = _userId;
@synthesize reviewTime = _reviewTime;
@synthesize iDProperty = _iDProperty;
@synthesize explain = _explain;
@synthesize submitTime = _submitTime;
@synthesize reviewId = _reviewId;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [dict doubleValueForKey:kModelAuthorityInfoStatus];
            self.userId = [dict doubleValueForKey:kModelAuthorityInfoUserId];
            self.reviewTime = [dict doubleValueForKey:kModelAuthorityInfoReviewTime];
            self.iDProperty = [dict doubleValueForKey:kModelAuthorityInfoId];
            self.explain = [dict stringValueForKey:kModelAuthorityInfoExplain];
            self.submitTime = [dict doubleValueForKey:kModelAuthorityInfoSubmitTime];
            self.reviewId = [dict doubleValueForKey:kModelAuthorityInfoReviewId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelAuthorityInfoStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelAuthorityInfoUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelAuthorityInfoReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAuthorityInfoId];
    [mutableDict setValue:self.explain forKey:kModelAuthorityInfoExplain];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelAuthorityInfoSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewId] forKey:kModelAuthorityInfoReviewId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
