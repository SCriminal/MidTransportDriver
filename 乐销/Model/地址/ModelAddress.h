//
//  ModelAddress.h
//
//  Created by   on 2018/3/28
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//高德
#import <AMapLocationKit/AMapLocationKit.h>


@interface ModelAddress : NSObject

@property (nonatomic, strong) NSString *prov;
@property (nonatomic, assign) double provCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) double cityCode;
@property (nonatomic, strong) NSString *dist;
@property (nonatomic, assign) double distCode;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, assign) double townCode;
@property (nonatomic, strong) NSString *vil;
@property (nonatomic, assign) double vilCode;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) double sort;
@property (nonatomic, strong) NSString *door;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) double isDefault;
@property (nonatomic, strong) NSString *receiptAddress;
@property (nonatomic, assign) double dateRecord;
@property (nonatomic, assign) double companyNumber;
@property (nonatomic, assign) double sex;
@property (nonatomic, assign) double spd;


//sld_exchange
@property (nonatomic, assign) BOOL isStandardCode;//default is false
@property (nonatomic, readonly) double platformCode;//平台
@property (nonatomic, readonly) double standardCode;//标准
@property (nonatomic, readonly) NSString *address_sld;//市.详细地址
@property (nonatomic, readonly) NSString *addressAll;//省市区镇乡
@property (nonatomic, readonly) NSString *addressProvinceDesc;//省市区 详细地址
@property (nonatomic, readonly) NSString *addressProCityDist;//省市区
@property (nonatomic, readonly) NSString *requestJsonString;


#pragma mark method
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
#pragma mark sld _change
//根据谷歌定位数据返回model
+ (instancetype)initWithAMapLocationReGeocode: (AMapLocationReGeocode *)regeocode location:(CLLocation *)location;

//保存读取地址
+(ModelAddress *)lastLocation;
+ (void)saveLastLocation:(ModelAddress *)model;
@end
