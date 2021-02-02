//
//  ModelIntegralOrder.h
//
//  Created by 林栋 隋 on 2021/2/2
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelIntegralOrder : NSObject

@property (nonatomic, assign) id contacter;
@property (nonatomic, strong) NSString *skuCoverUrl;
@property (nonatomic, assign) double areaId;
@property (nonatomic, assign) double skuPoint;
@property (nonatomic, strong) NSString *skuName;
@property (nonatomic, assign) double orderTime;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, assign) id reply;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double qty;
@property (nonatomic, strong) NSString *skuNumber;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double point;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double lng;
@property (nonatomic, strong) NSString *orderNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
