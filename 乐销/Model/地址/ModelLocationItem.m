//
//  ModelLocationItem.m
//
//  Created by 林栋 隋 on 2019/6/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelLocationItem.h"


NSString *const kModelLocationItemCollectTime = @"collectTime";
NSString *const kModelLocationItemId = @"id";
NSString *const kModelLocationItemAddr = @"addr";
NSString *const kModelLocationItemTerminalType = @"terminalType";
NSString *const kModelLocationItemLat = @"lat";
NSString *const kModelLocationItemLng = @"lng";
NSString *const kModelLocationItemTerminalNumber = @"terminalNumber";
NSString *const kModelLocationItemUploaderId = @"uploaderId";


@interface ModelLocationItem ()
@end

@implementation ModelLocationItem

@synthesize collectTime = _collectTime;
@synthesize iDProperty = _iDProperty;
@synthesize addr = _addr;
@synthesize terminalType = _terminalType;
@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize terminalNumber = _terminalNumber;
@synthesize uploaderId = _uploaderId;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.collectTime = [dict doubleValueForKey:kModelLocationItemCollectTime];
            self.iDProperty = [dict doubleValueForKey:kModelLocationItemId];
            self.addr = [dict stringValueForKey:kModelLocationItemAddr];
            self.terminalType = [dict doubleValueForKey:kModelLocationItemTerminalType];
            self.lat = [dict doubleValueForKey:kModelLocationItemLat];
            self.lng = [dict doubleValueForKey:kModelLocationItemLng];
            self.terminalNumber = [dict stringValueForKey:kModelLocationItemTerminalNumber];
            self.uploaderId = [dict doubleValueForKey:kModelLocationItemUploaderId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.collectTime] forKey:kModelLocationItemCollectTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelLocationItemId];
    [mutableDict setValue:self.addr forKey:kModelLocationItemAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.terminalType] forKey:kModelLocationItemTerminalType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelLocationItemLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelLocationItemLng];
    [mutableDict setValue:self.terminalNumber forKey:kModelLocationItemTerminalNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uploaderId] forKey:kModelLocationItemUploaderId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
