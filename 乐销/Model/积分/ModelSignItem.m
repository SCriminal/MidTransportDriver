//
//  ModelSignItem.m
//
//  Created by 林栋 隋 on 2021/2/2
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelSignItem.h"


NSString *const kModelSignItemPointTime = @"pointTime";
NSString *const kModelSignItemChannel = @"channel";
NSString *const kModelSignItemDescription = @"description";
NSString *const kModelSignItemPoint = @"point";
NSString *const kModelSignItemDirection = @"direction";


@interface ModelSignItem ()
@property (nonatomic, assign) id internalBaseClassDescription;

@end

@implementation ModelSignItem

@synthesize pointTime = _pointTime;
@synthesize channel = _channel;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize point = _point;
@synthesize direction = _direction;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.pointTime = [dict doubleValueForKey:kModelSignItemPointTime];
            self.channel = [dict stringValueForKey:kModelSignItemChannel];
            self.internalBaseClassDescription = [dict objectForKey:kModelSignItemDescription];
            self.point = [dict doubleValueForKey:kModelSignItemPoint];
            self.direction = [dict doubleValueForKey:kModelSignItemDirection];

        NSDate * date =[GlobalMethod exchangeTimeStampToDate:self.pointTime];
        self.strWeekShow = date.weekdayStr_sld;
      
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pointTime] forKey:kModelSignItemPointTime];
    [mutableDict setValue:self.channel forKey:kModelSignItemChannel];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelSignItemDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.point] forKey:kModelSignItemPoint];
    [mutableDict setValue:[NSNumber numberWithDouble:self.direction] forKey:kModelSignItemDirection];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
