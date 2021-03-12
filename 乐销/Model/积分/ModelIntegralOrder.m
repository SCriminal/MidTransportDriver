//
//  ModelIntegralOrder.m
//
//  Created by 林栋 隋 on 2021/2/2
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelIntegralOrder.h"


NSString *const kModelIntegralOrderContacter = @"contacter";
NSString *const kModelIntegralOrderSkuCoverUrl = @"skuCoverUrl";
NSString *const kModelIntegralOrderAreaId = @"areaId";
NSString *const kModelIntegralOrderSkuPoint = @"skuPoint";
NSString *const kModelIntegralOrderSkuName = @"skuName";
NSString *const kModelIntegralOrderOrderTime = @"orderTime";
NSString *const kModelIntegralOrderContactPhone = @"contactPhone";
NSString *const kModelIntegralOrderCityName = @"cityName";
NSString *const kModelIntegralOrderCountyName = @"countyName";
NSString *const kModelIntegralOrderAddr = @"addr";
NSString *const kModelIntegralOrderReply = @"reply";
NSString *const kModelIntegralOrderLat = @"lat";
NSString *const kModelIntegralOrderQty = @"qty";
NSString *const kModelIntegralOrderSkuNumber = @"skuNumber";
NSString *const kModelIntegralOrderUserId = @"userId";
NSString *const kModelIntegralOrderPoint = @"point";
NSString *const kModelIntegralOrderProvinceName = @"provinceName";
NSString *const kModelIntegralOrderLng = @"lng";
NSString *const kModelIntegralOrderOrderNumber = @"orderNumber";


@interface ModelIntegralOrder ()
@end

@implementation ModelIntegralOrder

@synthesize contacter = _contacter;
@synthesize skuCoverUrl = _skuCoverUrl;
@synthesize areaId = _areaId;
@synthesize skuPoint = _skuPoint;
@synthesize skuName = _skuName;
@synthesize orderTime = _orderTime;
@synthesize contactPhone = _contactPhone;
@synthesize cityName = _cityName;
@synthesize countyName = _countyName;
@synthesize addr = _addr;
@synthesize reply = _reply;
@synthesize lat = _lat;
@synthesize qty = _qty;
@synthesize skuNumber = _skuNumber;
@synthesize userId = _userId;
@synthesize point = _point;
@synthesize provinceName = _provinceName;
@synthesize lng = _lng;
@synthesize orderNumber = _orderNumber;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.contacter = [dict stringValueForKey:kModelIntegralOrderContacter];
            self.skuCoverUrl = [dict stringValueForKey:kModelIntegralOrderSkuCoverUrl];
            self.areaId = [dict doubleValueForKey:kModelIntegralOrderAreaId];
            self.skuPoint = [dict doubleValueForKey:kModelIntegralOrderSkuPoint];
            self.skuName = [dict stringValueForKey:kModelIntegralOrderSkuName];
            self.orderTime = [dict doubleValueForKey:kModelIntegralOrderOrderTime];
            self.contactPhone = [dict stringValueForKey:kModelIntegralOrderContactPhone];
            self.cityName = [dict stringValueForKey:kModelIntegralOrderCityName];
            self.countyName = [dict stringValueForKey:kModelIntegralOrderCountyName];
            self.addr = [dict stringValueForKey:kModelIntegralOrderAddr];
            self.reply = [dict stringValueForKey:kModelIntegralOrderReply];
            self.lat = [dict doubleValueForKey:kModelIntegralOrderLat];
            self.qty = [dict doubleValueForKey:kModelIntegralOrderQty];
            self.skuNumber = [dict stringValueForKey:kModelIntegralOrderSkuNumber];
            self.userId = [dict doubleValueForKey:kModelIntegralOrderUserId];
            self.point = [dict doubleValueForKey:kModelIntegralOrderPoint];
            self.provinceName = [dict stringValueForKey:kModelIntegralOrderProvinceName];
            self.lng = [dict doubleValueForKey:kModelIntegralOrderLng];
            self.orderNumber = [dict stringValueForKey:kModelIntegralOrderOrderNumber];

        self.addrShow = [NSString stringWithFormat:@"%@%@%@%@",UnPackStr(self.provinceName),[self.cityName isEqualToString:self.provinceName]?@"":UnPackStr(self.cityName),UnPackStr(self.countyName),UnPackStr(self.addr)];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.contacter forKey:kModelIntegralOrderContacter];
    [mutableDict setValue:self.skuCoverUrl forKey:kModelIntegralOrderSkuCoverUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaId] forKey:kModelIntegralOrderAreaId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.skuPoint] forKey:kModelIntegralOrderSkuPoint];
    [mutableDict setValue:self.skuName forKey:kModelIntegralOrderSkuName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderTime] forKey:kModelIntegralOrderOrderTime];
    [mutableDict setValue:self.contactPhone forKey:kModelIntegralOrderContactPhone];
    [mutableDict setValue:self.cityName forKey:kModelIntegralOrderCityName];
    [mutableDict setValue:self.countyName forKey:kModelIntegralOrderCountyName];
    [mutableDict setValue:self.addr forKey:kModelIntegralOrderAddr];
    [mutableDict setValue:self.reply forKey:kModelIntegralOrderReply];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelIntegralOrderLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qty] forKey:kModelIntegralOrderQty];
    [mutableDict setValue:self.skuNumber forKey:kModelIntegralOrderSkuNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelIntegralOrderUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.point] forKey:kModelIntegralOrderPoint];
    [mutableDict setValue:self.provinceName forKey:kModelIntegralOrderProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelIntegralOrderLng];
    [mutableDict setValue:self.orderNumber forKey:kModelIntegralOrderOrderNumber];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
