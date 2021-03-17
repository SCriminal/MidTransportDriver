//
//  ModelTransportOrder.h
//
//  Created by 林栋 隋 on 2021/1/23
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelTransportOrder : NSObject

@property (nonatomic, strong) NSString *rtbpNumber;
@property (nonatomic, strong) NSString *plateNumber;
@property (nonatomic, assign) double platformTime;
@property (nonatomic, assign) double startCityId;
@property (nonatomic, strong) NSString *endCountyCode;
@property (nonatomic, assign) double mode;
@property (nonatomic, strong) NSString *endPhone;
@property (nonatomic, assign) double confirmTime;
@property (nonatomic, strong) NSString *startAddr;
@property (nonatomic, assign) double acceptTime;
@property (nonatomic, assign) double bizOrderTime;
@property (nonatomic, assign) double isShipperEvaluation;
@property (nonatomic, assign) double transportQty;
@property (nonatomic, assign) double priceUnit;
@property (nonatomic, assign) double cargoTypeClass;
@property (nonatomic, strong) NSString *startContacter;
@property (nonatomic, strong) NSString *startCountyName;
@property (nonatomic, strong) NSString *startPhone;
@property (nonatomic, assign) double startProvinceId;
@property (nonatomic, strong) NSString *cargoName;
@property (nonatomic, assign) double cargoWeight;
@property (nonatomic, assign) double endProvinceId;
@property (nonatomic, assign) double unloadTime;
@property (nonatomic, assign) double driverId;
@property (nonatomic, strong) NSString *endCityName;
@property (nonatomic, strong) NSString *endCountyName;
@property (nonatomic, assign) double vehicleId;
@property (nonatomic, assign) double vehicle1Id;
@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, assign) double finishTime;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, assign) double endCityId;
@property (nonatomic, assign) double orderStatus;
@property (nonatomic, assign) double startCountyId;
@property (nonatomic, strong) NSString *endProvinceName;
@property (nonatomic, strong) NSString *startCountyCode;
@property (nonatomic, strong) NSString *planNumber;
@property (nonatomic, assign) double shipperId;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double shipperPrice;
@property (nonatomic, strong) NSArray *loadUrls;
@property (nonatomic, strong) NSString *endAddr;
@property (nonatomic, assign) double isDriverEvaluation;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, assign) double endTime;

@property (nonatomic, assign) double endCountyId;
@property (nonatomic, strong) NSArray *unloadUrls;
@property (nonatomic, strong) NSString *shipperName;
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *endContacter;
@property (nonatomic, assign) double loadTime;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, assign) double unitPrice;
@property (nonatomic, strong) NSString *evaluateContent;
@property (nonatomic, assign) double evaluateScore;

//logical
@property (nonatomic, strong) NSString * orderStatusShow;
@property (nonatomic, strong) UIColor *colorStateShow;
@property (nonatomic, strong) NSString *unitShow;
@property (nonatomic, strong) NSString *qtyShow;

@property (nonatomic, assign) double priceShow;

@property (nonatomic, assign) double startAreaId;
@property (nonatomic, assign) double endAreaId;

@property (nonatomic, assign) double endLng;
@property (nonatomic, assign) double endLat;
@property (nonatomic, assign) BOOL isSelected;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
- (BOOL)isOutOfTime;
+(NSString *)statusTransport:(double)state;
+(UIColor *)statusColorTransport:(double)state;

@end
