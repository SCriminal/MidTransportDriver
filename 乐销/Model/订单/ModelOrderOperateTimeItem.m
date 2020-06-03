//
//  ModelOrderOperateTimeItem.m
//
//  Created by sld s on 2019/5/24
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelOrderOperateTimeItem.h"


NSString *const kModelOrderOperateTimeItemFormId = @"formId";
NSString *const kModelOrderOperateTimeItemStateTime = @"stateTime";
NSString *const kModelOrderOperateTimeItemSrc = @"src";
NSString *const kModelOrderOperateTimeItemFormType = @"formType";
NSString *const kModelOrderOperateTimeItemAddr = @"addr";
NSString *const kModelOrderOperateTimeItemOperatorName = @"operatorName";
NSString *const kModelOrderOperateTimeItemLat = @"lat";
NSString *const kModelOrderOperateTimeItemOperatorEmpId = @"operatorEmpId";
NSString *const kModelOrderOperateTimeItemFormState = @"formState";
NSString *const kModelOrderOperateTimeItemStateSort = @"stateSort";
NSString *const kModelOrderOperateTimeItemOperatorEmpName = @"operatorEmpName";
NSString *const kModelOrderOperateTimeItemOperatorId = @"operatorId";
NSString *const kModelOrderOperateTimeItemLng = @"lng";


@interface ModelOrderOperateTimeItem ()
@end

@implementation ModelOrderOperateTimeItem

@synthesize formId = _formId;
@synthesize stateTime = _stateTime;
@synthesize src = _src;
@synthesize formType = _formType;
@synthesize addr = _addr;
@synthesize operatorName = _operatorName;
@synthesize lat = _lat;
@synthesize operatorEmpId = _operatorEmpId;
@synthesize formState = _formState;
@synthesize stateSort = _stateSort;
@synthesize operatorEmpName = _operatorEmpName;
@synthesize operatorId = _operatorId;
@synthesize lng = _lng;

#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.formId = [dict doubleValueForKey:kModelOrderOperateTimeItemFormId];
            self.stateTime = [dict doubleValueForKey:kModelOrderOperateTimeItemStateTime];
            self.src = [dict doubleValueForKey:kModelOrderOperateTimeItemSrc];
            self.formType = [dict doubleValueForKey:kModelOrderOperateTimeItemFormType];
            self.addr = [dict stringValueForKey:kModelOrderOperateTimeItemAddr];
            self.operatorName = [dict stringValueForKey:kModelOrderOperateTimeItemOperatorName];
            self.lat = [dict doubleValueForKey:kModelOrderOperateTimeItemLat];
            self.operatorEmpId = [dict doubleValueForKey:kModelOrderOperateTimeItemOperatorEmpId];
            self.formState = [dict doubleValueForKey:kModelOrderOperateTimeItemFormState];
            self.stateSort = [dict doubleValueForKey:kModelOrderOperateTimeItemStateSort];
            self.operatorEmpName = [dict stringValueForKey:kModelOrderOperateTimeItemOperatorEmpName];
            self.operatorId = [dict doubleValueForKey:kModelOrderOperateTimeItemOperatorId];
            self.lng = [dict doubleValueForKey:kModelOrderOperateTimeItemLng];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.formId] forKey:kModelOrderOperateTimeItemFormId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stateTime] forKey:kModelOrderOperateTimeItemStateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.src] forKey:kModelOrderOperateTimeItemSrc];
    [mutableDict setValue:[NSNumber numberWithDouble:self.formType] forKey:kModelOrderOperateTimeItemFormType];
    [mutableDict setValue:self.addr forKey:kModelOrderOperateTimeItemAddr];
    [mutableDict setValue:self.operatorName forKey:kModelOrderOperateTimeItemOperatorName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelOrderOperateTimeItemLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.operatorEmpId] forKey:kModelOrderOperateTimeItemOperatorEmpId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.formState] forKey:kModelOrderOperateTimeItemFormState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stateSort] forKey:kModelOrderOperateTimeItemStateSort];
    [mutableDict setValue:self.operatorEmpName forKey:kModelOrderOperateTimeItemOperatorEmpName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.operatorId] forKey:kModelOrderOperateTimeItemOperatorId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelOrderOperateTimeItemLng];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
