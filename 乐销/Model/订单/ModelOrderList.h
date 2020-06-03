//
//  ModelOrderList.h
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestApi+Order.h"

typedef NS_ENUM(NSUInteger, ENUM_ORDER_TYPE) {
    ENUM_ORDER_TYPE_ERROR,
    ENUM_ORDER_TYPE_INPUT,
    ENUM_ORDER_TYPE_OUTPUT,
};

@interface ModelOrderList : NSObject

@property (nonatomic, strong) NSString *endCyName;
@property (nonatomic, strong) NSString *placeDetailAddr;
@property (nonatomic, assign) double startCyId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *startCardAddr;
@property (nonatomic, strong) NSString *placePhone;
@property (nonatomic, assign) double toFactoryTime;
@property (nonatomic, assign) double state;
@property (nonatomic, assign) double endCyId;
@property (nonatomic, strong) NSString *startContact;
@property (nonatomic, strong) NSString *endPhone;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, assign) double acceptTime;
@property (nonatomic, strong) NSString *startCardPhone;
@property (nonatomic, strong) NSString *truckNumber;
@property (nonatomic, strong) NSString *endContact;
@property (nonatomic, strong) NSString *placeEnvName;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, strong) NSString *placeTownName;
@property (nonatomic, assign) double placeCityId;
@property (nonatomic, assign) double src;
@property (nonatomic, strong) NSString *startPhone;
@property (nonatomic, strong) NSString *voyageNumber;
@property (nonatomic, assign) double startProvinceId;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double afterSaleFormId;
@property (nonatomic, assign) double endProvinceId;
@property (nonatomic, assign) double endAreaId;
@property (nonatomic, assign) double startAreaId;
@property (nonatomic, assign) double closingTime;
@property (nonatomic, strong) NSString *placeContact;
@property (nonatomic, assign) double placeTime;
@property (nonatomic, assign) double finishTime;
@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, strong) NSString *placeCountyName;
@property (nonatomic, strong) NSString *carrierName;
@property (nonatomic, assign) double stuffTime;
@property (nonatomic, assign) double placeProvinceId;
@property (nonatomic, strong) NSString *shippingLineName;
@property (nonatomic, assign) double endPortId;
@property (nonatomic, strong) NSString *endProvinceName;
@property (nonatomic, strong) NSString *endPortName;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *waybillNumber;
@property (nonatomic, strong) NSString *oceanVessel;
@property (nonatomic, assign) double shipperId;
@property (nonatomic, strong) NSString *placeCityName;
@property (nonatomic, strong) NSString *blNumber;
@property (nonatomic, strong) NSString *endAreaName;
@property (nonatomic, strong) NSString *startAreaName;
@property (nonatomic, assign) double startPortId;
@property (nonatomic, assign) double placeCountyId;
@property (nonatomic, assign) double handleTime;
@property (nonatomic, assign) double carrierId;
@property (nonatomic, strong) NSString *shipperName;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *startCyName;
@property (nonatomic, assign) double placeTownId;
@property (nonatomic, strong) NSString *placeProvinceName;
@property (nonatomic, strong) NSString *startPortName;
@property (nonatomic, assign) double truckId;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, strong) NSString *startCardContact;
@property (nonatomic, strong) NSString *key;


@property (nonatomic, readonly) ENUM_ORDER_OPERATE_TYPE operateType;
@property (nonatomic, strong) NSString *closingTimeShow;//logical
@property (nonatomic, readonly) NSString * orderStatusShow;
@property (nonatomic, readonly) UIColor *colorStateShow;
@property (nonatomic, strong) NSString *shipperPhone;

//地理位置显示
@property (nonatomic, readonly) ENUM_ORDER_TYPE orderType;
@property (nonatomic, readonly) NSString *loadAddressShow;
@property (nonatomic, readonly) NSString *backPackageAddressShow;
@property (nonatomic, readonly) NSString *returnPackageAddressShow;

+ (NSString *)transformOrderStatusToName:(int)state orderType:(ENUM_ORDER_TYPE)orderType;
+ (NSString *)transformOrderStatusToCompleteName:(int)state orderType:(ENUM_ORDER_TYPE)orderType;
+ (ENUM_ORDER_TYPE)transformOrderType:(int)type;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
