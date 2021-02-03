//
//  ModelMsgItem.m
//
//  Created by 林栋 隋 on 2021/2/3
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelMsgItem.h"


NSString *const kModelMsgItemNumber = @"number";
NSString *const kModelMsgItemIsRead = @"isRead";
NSString *const kModelMsgItemChannel = @"channel";
NSString *const kModelMsgItemPushTime = @"pushTime";
NSString *const kModelMsgItemTitle = @"title";
NSString *const kModelMsgItemTotal = @"total";


@interface ModelMsgItem ()
@end

@implementation ModelMsgItem

@synthesize number = _number;
@synthesize isRead = _isRead;
@synthesize channel = _channel;
@synthesize pushTime = _pushTime;
@synthesize title = _title;
@synthesize total = _total;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.number = [dict stringValueForKey:kModelMsgItemNumber];
            self.isRead = [dict doubleValueForKey:kModelMsgItemIsRead];
            self.channel = [dict stringValueForKey:kModelMsgItemChannel];
            self.pushTime = [dict doubleValueForKey:kModelMsgItemPushTime];
            self.title = [dict stringValueForKey:kModelMsgItemTitle];
            self.total = [dict doubleValueForKey:kModelMsgItemTotal];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.number forKey:kModelMsgItemNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isRead] forKey:kModelMsgItemIsRead];
    [mutableDict setValue:self.channel forKey:kModelMsgItemChannel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pushTime] forKey:kModelMsgItemPushTime];
    [mutableDict setValue:self.title forKey:kModelMsgItemTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kModelMsgItemTotal];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
