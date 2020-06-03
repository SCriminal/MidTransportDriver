//
//  ModelApns.m
//
//  Created by sld s on 2019/1/7
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelApns.h"


NSString *const kModelApnsId = @"id";
NSString *const kModelApnsType = @"type";
NSString *const kModelApnsDesc = @"desc";


@interface ModelApns ()
@end

@implementation ModelApns

@synthesize type = _type;
@synthesize desc = _desc;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.ids = [dict arrayValueForKey:kModelApnsId];
        self.type = [dict doubleValueForKey:kModelApnsType];
        self.desc = [[[dict dictionaryValueForKey:@"aps"] dictionaryValueForKey:@"alert"] stringValueForKey:@"body"];
        self.isSilent =  [[dict dictionaryValueForKey:@"aps"] doubleValueForKey:@"content-available"];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
   
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end

