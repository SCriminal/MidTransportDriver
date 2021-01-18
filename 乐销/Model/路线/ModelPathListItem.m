//
//  ModelPathListItem.m
//
//  Created by 林栋 隋 on 2021/1/18
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelPathListItem.h"


NSString *const kModelPathListItemEndProvinceId = @"endProvinceId";
NSString *const kModelPathListItemEndCityName = @"endCityName";
NSString *const kModelPathListItemStartCityName = @"startCityName";
NSString *const kModelPathListItemUserId = @"userId";
NSString *const kModelPathListItemRoutePass2Id = @"routePass2Id";
NSString *const kModelPathListItemEndCountyName = @"endCountyName";
NSString *const kModelPathListItemRoutePass3Id = @"routePass3Id";
NSString *const kModelPathListItemEndCityId = @"endCityId";
NSString *const kModelPathListItemRoutePass3 = @"routePass3";
NSString *const kModelPathListItemRoutePass2 = @"routePass2";
NSString *const kModelPathListItemEndCountyId = @"endCountyId";
NSString *const kModelPathListItemRoutePass1 = @"routePass1";
NSString *const kModelPathListItemStartProvinceId = @"startProvinceId";
NSString *const kModelPathListItemId = @"id";
NSString *const kModelPathListItemEndProvinceName = @"endProvinceName";
NSString *const kModelPathListItemStartCityId = @"startCityId";
NSString *const kModelPathListItemStartCountyId = @"startCountyId";
NSString *const kModelPathListItemStartCountyName = @"startCountyName";
NSString *const kModelPathListItemStartProvinceName = @"startProvinceName";
NSString *const kModelPathListItemCreateTime = @"createTime";
NSString *const kModelPathListItemRoutePass1Id = @"routePass1Id";


@interface ModelPathListItem ()
@end

@implementation ModelPathListItem

@synthesize endProvinceId = _endProvinceId;
@synthesize endCityName = _endCityName;
@synthesize startCityName = _startCityName;
@synthesize userId = _userId;
@synthesize routePass2Id = _routePass2Id;
@synthesize endCountyName = _endCountyName;
@synthesize routePass3Id = _routePass3Id;
@synthesize endCityId = _endCityId;
@synthesize routePass3 = _routePass3;
@synthesize routePass2 = _routePass2;
@synthesize endCountyId = _endCountyId;
@synthesize routePass1 = _routePass1;
@synthesize startProvinceId = _startProvinceId;
@synthesize iDProperty = _iDProperty;
@synthesize endProvinceName = _endProvinceName;
@synthesize startCityId = _startCityId;
@synthesize startCountyId = _startCountyId;
@synthesize startCountyName = _startCountyName;
@synthesize startProvinceName = _startProvinceName;
@synthesize createTime = _createTime;
@synthesize routePass1Id = _routePass1Id;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.endProvinceId = [dict doubleValueForKey:kModelPathListItemEndProvinceId];
            self.endCityName = [dict stringValueForKey:kModelPathListItemEndCityName];
            self.startCityName = [dict stringValueForKey:kModelPathListItemStartCityName];
            self.userId = [dict doubleValueForKey:kModelPathListItemUserId];
            self.routePass2Id = [dict doubleValueForKey:kModelPathListItemRoutePass2Id];
            self.endCountyName = [dict stringValueForKey:kModelPathListItemEndCountyName];
            self.routePass3Id = [dict doubleValueForKey:kModelPathListItemRoutePass3Id];
            self.endCityId = [dict doubleValueForKey:kModelPathListItemEndCityId];
            self.routePass3 = [dict stringValueForKey:kModelPathListItemRoutePass3];
            self.routePass2 = [dict stringValueForKey:kModelPathListItemRoutePass2];
            self.endCountyId = [dict doubleValueForKey:kModelPathListItemEndCountyId];
            self.routePass1 = [dict stringValueForKey:kModelPathListItemRoutePass1];
            self.startProvinceId = [dict doubleValueForKey:kModelPathListItemStartProvinceId];
            self.iDProperty = [dict doubleValueForKey:kModelPathListItemId];
            self.endProvinceName = [dict stringValueForKey:kModelPathListItemEndProvinceName];
            self.startCityId = [dict doubleValueForKey:kModelPathListItemStartCityId];
            self.startCountyId = [dict doubleValueForKey:kModelPathListItemStartCountyId];
            self.startCountyName = [dict stringValueForKey:kModelPathListItemStartCountyName];
            self.startProvinceName = [dict stringValueForKey:kModelPathListItemStartProvinceName];
            self.createTime = [dict doubleValueForKey:kModelPathListItemCreateTime];
            self.routePass1Id = [dict doubleValueForKey:kModelPathListItemRoutePass1Id];

        self.startShow = [NSString stringWithFormat:@"%@%@%@",self.startProvinceName,[self.startProvinceName isEqualToString:self.startCityName]?@"":self.startCityName,self.startCountyName];

        self.endShow = [NSString stringWithFormat:@"%@%@%@",self.endProvinceName,[self.endProvinceName isEqualToString:self.endCityName]?@"":self.endCityName,self.endCountyName];


    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endProvinceId] forKey:kModelPathListItemEndProvinceId];
    [mutableDict setValue:self.endCityName forKey:kModelPathListItemEndCityName];
    [mutableDict setValue:self.startCityName forKey:kModelPathListItemStartCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelPathListItemUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.routePass2Id] forKey:kModelPathListItemRoutePass2Id];
    [mutableDict setValue:self.endCountyName forKey:kModelPathListItemEndCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.routePass3Id] forKey:kModelPathListItemRoutePass3Id];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCityId] forKey:kModelPathListItemEndCityId];
    [mutableDict setValue:self.routePass3 forKey:kModelPathListItemRoutePass3];
    [mutableDict setValue:self.routePass2 forKey:kModelPathListItemRoutePass2];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCountyId] forKey:kModelPathListItemEndCountyId];
    [mutableDict setValue:self.routePass1 forKey:kModelPathListItemRoutePass1];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startProvinceId] forKey:kModelPathListItemStartProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelPathListItemId];
    [mutableDict setValue:self.endProvinceName forKey:kModelPathListItemEndProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCityId] forKey:kModelPathListItemStartCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCountyId] forKey:kModelPathListItemStartCountyId];
    [mutableDict setValue:self.startCountyName forKey:kModelPathListItemStartCountyName];
    [mutableDict setValue:self.startProvinceName forKey:kModelPathListItemStartProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelPathListItemCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.routePass1Id] forKey:kModelPathListItemRoutePass1Id];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
