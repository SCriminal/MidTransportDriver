//
//  ModelShopAddress.m
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelShopAddress.h"


NSString *const kModelShopAddressDetail = @"detail";
NSString *const kModelShopAddressId = @"id";
NSString *const kModelShopAddressPhone = @"phone";
NSString *const kModelShopAddressContact = @"contact";
NSString *const kModelShopAddressCountyName = @"countyName";
NSString *const kModelShopAddressCityName = @"cityName";
NSString *const kModelShopAddressCountyId = @"countyId";
NSString *const kModelShopAddressUserId = @"userId";
NSString *const kModelShopAddressLat = @"lat";
NSString *const kModelShopAddressCreateTime = @"createTime";
NSString *const kModelShopAddressProvinceName = @"provinceName";
NSString *const kModelShopAddressLng = @"lng";
NSString *const kModelShopAddressProvinceId = @"provinceId";
NSString *const kModelShopAddressCityId = @"cityId";
NSString *const kModelShopAddressHailuoId = @"addressId";



@interface ModelShopAddress ()
@end

@implementation ModelShopAddress

@synthesize detail = _detail;
@synthesize iDProperty = _iDProperty;
@synthesize phone = _phone;
@synthesize contact = _contact;
@synthesize countyName = _countyName;
@synthesize cityName = _cityName;
@synthesize countyId = _countyId;
@synthesize userId = _userId;
@synthesize lat = _lat;
@synthesize createTime = _createTime;
@synthesize provinceName = _provinceName;
@synthesize lng = _lng;
@synthesize provinceId = _provinceId;
@synthesize cityId = _cityId;


-(NSString *)addressDetailShow{
    if (!_addressDetailShow) {
        _addressDetailShow = [NSString stringWithFormat:@"%@%@%@%@",UnPackStr(self.provinceName),UnPackStr(self.cityName),UnPackStr(self.countyName),UnPackStr(self.detail)];
    }
    return _addressDetailShow;
}
#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.detail = [dict stringValueForKey:kModelShopAddressDetail];
            self.iDProperty = [dict doubleValueForKey:kModelShopAddressId];
            self.phone = [dict stringValueForKey:kModelShopAddressPhone];
            self.contact = [dict stringValueForKey:kModelShopAddressContact];
            self.countyName = [dict stringValueForKey:kModelShopAddressCountyName];
            self.cityName = [dict stringValueForKey:kModelShopAddressCityName];
            self.countyId = [dict doubleValueForKey:kModelShopAddressCountyId];
            self.userId = [dict doubleValueForKey:kModelShopAddressUserId];
            self.lat = [dict doubleValueForKey:kModelShopAddressLat];
            self.createTime = [dict doubleValueForKey:kModelShopAddressCreateTime];
            self.provinceName = [dict stringValueForKey:kModelShopAddressProvinceName];
            self.lng = [dict doubleValueForKey:kModelShopAddressLng];
            self.provinceId = [dict doubleValueForKey:kModelShopAddressProvinceId];
            self.cityId = [dict doubleValueForKey:kModelShopAddressCityId];
        self.addressId = [dict doubleValueForKey:kModelShopAddressHailuoId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.detail forKey:kModelShopAddressDetail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelShopAddressId];
    [mutableDict setValue:self.phone forKey:kModelShopAddressPhone];
    [mutableDict setValue:self.contact forKey:kModelShopAddressContact];
    [mutableDict setValue:self.countyName forKey:kModelShopAddressCountyName];
    [mutableDict setValue:self.cityName forKey:kModelShopAddressCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelShopAddressCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelShopAddressUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelShopAddressLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelShopAddressCreateTime];
    [mutableDict setValue:self.provinceName forKey:kModelShopAddressProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelShopAddressLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelShopAddressProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelShopAddressCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addressId] forKey:kModelShopAddressHailuoId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
