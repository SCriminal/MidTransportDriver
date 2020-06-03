//
//  ModelAddress.m
//
//  Created by   on 2018/3/28
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "ModelAddress.h"


NSString *const kModelAddressProv = @"prov";
NSString *const kModelAddressDist = @"dist";
NSString *const kModelAddressDistCode = @"distCode";
NSString *const kModelAddressDesc = @"desc";
NSString *const kModelAddressCityCode = @"cityCode";
NSString *const kModelAddressVil = @"vil";
NSString *const kModelAddressTown = @"town";
NSString *const kModelAddressLat = @"lat";
NSString *const kModelAddressCity = @"city";
NSString *const kModelAddressVilCode = @"vilCode";
NSString *const kModelAddressTownCode = @"townCode";
NSString *const kModelAddressLng = @"lng";
NSString *const kModelAddressProvCode = @"provCode";
NSString *const kModelAddressName = @"name";
NSString *const kModelAddressPhone = @"phone";
NSString *const kModelAddressSort = @"sort";
NSString *const kModelAddressDoor = @"door";
NSString *const kModelAddressRemark = @"remark";
NSString *const kModelAddressIsDefault = @"isDefault";
NSString *const kModelAddressReceiptAddress = @"receiptAddress";
NSString *const kModelAddressNumber = @"dateRecord";
NSString *const kModelAddressCompanyNumber = @"companyNumber";
NSString *const kModelAddressSex = @"sex";
NSString *const kModelAddressSpeed = @"spd";

//sld_change
NSString *const kModelAddressIsStandardCode = @"isStandardCode";

@interface ModelAddress ()
@end

@implementation ModelAddress

@synthesize prov = _prov;
@synthesize dist = _dist;
@synthesize distCode = _distCode;
@synthesize desc = _desc;
@synthesize cityCode = _cityCode;
@synthesize vil = _vil;
@synthesize town = _town;
@synthesize lat = _lat;
@synthesize city = _city;
@synthesize vilCode = _vilCode;
@synthesize townCode = _townCode;
@synthesize lng = _lng;
@synthesize provCode = _provCode;
@synthesize name = _name;
@synthesize phone = _phone;
@synthesize sort = _sort;
@synthesize door = _door;
@synthesize remark = _remark;
@synthesize isDefault = _isDefault;
@synthesize receiptAddress = _receiptAddress;
@synthesize dateRecord = _number;
@synthesize companyNumber = _companyNumber;
@synthesize sex = _sex;

#pragma mark get
- (double)platformCode{
    if (!self.isStandardCode) {
        if (self.vilCode) {
            return self.vilCode;
        }
        if (self.townCode) {
            return self.townCode;
        }
        if (self.distCode) {
            return self.distCode;
        }
        if (self.cityCode) {
            return self.cityCode;
        }
        if (self.provCode) {
            return self.provCode;
        }
    }
    return 0;
}
- (double)standardCode{
    if (self.isStandardCode) {
        if (self.vilCode) {
            return self.vilCode;
        }
        if (self.townCode) {
            return self.townCode;
        }
        if (self.distCode) {
            return self.distCode;
        }
        if (self.cityCode) {
            return self.cityCode;
        }
        if (self.provCode) {
            return self.provCode;
        }
    }
    return 0;
}
- (NSString *)requestJsonString{
    return [GlobalMethod exchangeDicToJson:@{@"receiverName":UnPackStr(self.name),
                                             @"receiverPhone":UnPackStr(self.phone),
                                             @"desc":UnPackStr(self.desc),
                                               @"distStdCode":NSNumber.dou(self.standardCode),
                                               @"distPlatCode":NSNumber.dou(self.platformCode),
                                               @"lng":NSNumber.dou(self.lng),
                                               @"lat":NSNumber.dou(self.lat)}];
}
- (NSString *)address_sld{
    NSString * detailStr = [NSString stringWithFormat:@"%@%@%@",UnPackStr(self.city),isStr(self.city)&&isStr(self.desc)?@"·":@"",UnPackStr(self.desc)];
    return detailStr;
}
- (NSString *)addressAll{
    NSString * detailStr = [NSString stringWithFormat:@"%@%@%@%@%@",UnPackStr(self.prov),UnPackStr(self.city),UnPackStr(self.dist),UnPackStr(self.town),UnPackStr(self.vil)];
    return detailStr;
}
- (NSString *)addressProvinceDesc{
    return [NSString stringWithFormat:@"%@%@%@%@",UnPackStr(self.prov),[self.city isEqualToString:self.prov]?@"":UnPackStr(self.city),UnPackStr(self.dist),UnPackStr(self.desc)];
}
- (NSString *)addressProCityDist{
    return [NSString stringWithFormat:@"%@%@%@",UnPackStr(self.prov),[self.city isEqualToString:self.prov]?@"":UnPackStr(self.city),UnPackStr(self.dist)];
    
}
#pragma mark sld _change
//根据谷歌定位数据返回model
+ (instancetype)initWithAMapLocationReGeocode: (AMapLocationReGeocode *)regeocode location:(CLLocation *)location{
    ModelAddress * model = [ModelAddress new];
    model.prov = regeocode.province;
    model.city = regeocode.city?:regeocode.province;
    model.cityCode = regeocode.citycode.doubleValue;
    model.dist = regeocode.district;
    model.distCode = regeocode.adcode.doubleValue;
    model.desc = regeocode.POIName;
    model.lat = location.coordinate.latitude;
    model.lng = location.coordinate.longitude;
    model.spd = location.speed>0?(location.speed*100.0):0;
    model.dateRecord = [[NSDate date]timeIntervalSince1970];
    
    return model;
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
        self.prov = [dict stringValueForKey:kModelAddressProv];
        self.dist = [dict stringValueForKey:kModelAddressDist];
        self.distCode = [dict doubleValueForKey:kModelAddressDistCode];
        self.desc = [dict stringValueForKey:kModelAddressDesc];
        self.cityCode = [dict doubleValueForKey:kModelAddressCityCode];
        self.vil = [dict stringValueForKey:kModelAddressVil];
        self.town = [dict stringValueForKey:kModelAddressTown];
        self.lat = [dict doubleValueForKey:kModelAddressLat];
        self.city = [dict stringValueForKey:kModelAddressCity];
        self.vilCode = [dict doubleValueForKey:kModelAddressVilCode];
        self.townCode = [dict doubleValueForKey:kModelAddressTownCode];
        self.lng = [dict doubleValueForKey:kModelAddressLng];
        self.provCode = [dict doubleValueForKey:kModelAddressProvCode];
        self.name = [dict stringValueForKey:kModelAddressName];
        self.phone = [dict stringValueForKey:kModelAddressPhone];
        self.sort = [dict doubleValueForKey:kModelAddressSort];
        self.door = [dict stringValueForKey:kModelAddressDoor];
        self.remark = [dict stringValueForKey:kModelAddressRemark];
        self.isDefault = [dict doubleValueForKey:kModelAddressIsDefault];
        self.receiptAddress = [dict stringValueForKey:kModelAddressReceiptAddress];
        self.dateRecord = [dict doubleValueForKey:kModelAddressNumber];
        self.companyNumber = [dict doubleValueForKey:kModelAddressCompanyNumber];
        self.sex = [dict doubleValueForKey:kModelAddressSex];
        self.spd = [dict doubleValueForKey:kModelAddressSpeed];

        //sld_change
        self.isStandardCode = [dict doubleValueForKey:kModelAddressIsStandardCode];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.prov forKey:kModelAddressProv];
    [mutableDict setValue:self.dist forKey:kModelAddressDist];
    [mutableDict setValue:[NSNumber numberWithDouble:self.distCode] forKey:kModelAddressDistCode];
    [mutableDict setValue:self.desc forKey:kModelAddressDesc];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityCode] forKey:kModelAddressCityCode];
    [mutableDict setValue:self.vil forKey:kModelAddressVil];
    [mutableDict setValue:self.town forKey:kModelAddressTown];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelAddressLat];
    [mutableDict setValue:self.city forKey:kModelAddressCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vilCode] forKey:kModelAddressVilCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townCode] forKey:kModelAddressTownCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelAddressLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provCode] forKey:kModelAddressProvCode];
    [mutableDict setValue:self.name forKey:kModelAddressName];
    [mutableDict setValue:self.phone forKey:kModelAddressPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kModelAddressSort];
    [mutableDict setValue:self.door forKey:kModelAddressDoor];
    [mutableDict setValue:self.remark forKey:kModelAddressRemark];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDefault] forKey:kModelAddressIsDefault];
    [mutableDict setValue:self.receiptAddress forKey:kModelAddressReceiptAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dateRecord] forKey:kModelAddressNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.companyNumber] forKey:kModelAddressCompanyNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kModelAddressSex];
    [mutableDict setValue:[NSNumber numberWithDouble:self.spd] forKey:kModelAddressSpeed];

    //sld_change
    [mutableDict setValue:[NSNumber numberWithDouble:self.isStandardCode] forKey:kModelAddressIsStandardCode];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


//保存读取地址
+(ModelAddress *)lastLocation{
    return  [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
}
+ (void)saveLastLocation:(ModelAddress *)modelAddress{
    [GlobalMethod writeModel:modelAddress key:LOCAL_LOCATION_UPTODATE exchange:false];
}
@end
