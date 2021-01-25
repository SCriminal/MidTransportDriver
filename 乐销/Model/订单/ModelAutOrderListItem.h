//
//  ModelAutOrderListItem.h
//
//  Created by 林栋 隋 on 2021/1/22
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAutOrderListItem : NSObject

@property (nonatomic, assign) double endProvinceId;
@property (nonatomic, strong) NSString *endCityName;
@property (nonatomic, assign) double startLng;
@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, assign) double priceUnit;
@property (nonatomic, strong) NSString *vehicleDescription;
@property (nonatomic, assign) double startLat;
@property (nonatomic, strong) NSString *endCountyName;
@property (nonatomic, strong) NSString *planNumber;
@property (nonatomic, assign) double endCityId;
@property (nonatomic, assign) double endTime;
@property (nonatomic, strong) NSString *cargoName;
@property (nonatomic, assign) double storageQty;
@property (nonatomic, assign) double endCountyId;
@property (nonatomic, assign) double endLat;
@property (nonatomic, assign) double driverId;
@property (nonatomic, assign) double endLng;
@property (nonatomic, strong) NSString *endProvinceName;
@property (nonatomic, assign) double qty;
@property (nonatomic, assign) double shipperId;
@property (nonatomic, assign) double startCityId;
@property (nonatomic, assign) double startCountyId;
@property (nonatomic, strong) NSString *startCountyName;
@property (nonatomic, assign) double startProvinceId;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, assign) double unitPrice;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double mode;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, assign) double lengthMax;
@property (nonatomic, assign) double lengthMin;
@property (nonatomic, assign) double transportQty;
@property (nonatomic, strong) NSString *endAddr;
@property (nonatomic, strong) NSString *startAddr;
@property (nonatomic, strong) NSString *endContacter;
@property (nonatomic, assign) double planStatus;
@property (nonatomic, strong) NSString *startContacter;
@property (nonatomic, strong) NSString *endPhone;
@property (nonatomic, strong) NSString *startPhone;
@property (nonatomic, assign) double orderQty;
@property (nonatomic, assign) double matchQty;
@property (nonatomic, assign) double unitWeight;
@property (nonatomic, assign) double loadQty;

//logical
@property (nonatomic, strong) NSString *unitShow;
@property (nonatomic, assign) double qtyShow;
@property (nonatomic, assign) double remainShow;
@property (nonatomic, assign) double priceShow;
@property (nonatomic, strong) NSString *distanceShow;
@property (nonatomic, strong) NSString *carLenthSHow;
@property (nonatomic, strong) NSString *comment;

- (double)exchangeRequestQty:(double)qty;
- (double)exchangeQtyShow:(double)qty;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
