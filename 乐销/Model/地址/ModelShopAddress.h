//
//  ModelShopAddress.h
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelShopAddress : NSObject

@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double addressId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, assign) double countyId;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *addressDetailShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
