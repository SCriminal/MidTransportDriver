//
//  ModelBulkCargoOrder.h
//
//  Created by 林栋 隋 on 2019/7/17
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestApi+BulkCargo.h"


@interface ModelBulkCargoOrder : NSObject

@property (nonatomic, assign) double proxyTaxState;
@property (nonatomic, strong) NSString *taxReceiptNumber;
@property (nonatomic, strong) NSString *endPhone;
@property (nonatomic, assign) double paymentPaymentChannel;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *fastMailNumber;
@property (nonatomic, assign) double fastMailChannel;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double taxState;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *endTownName;
@property (nonatomic, assign) double startProvinceId;
@property (nonatomic, assign) double proxyPaymentChannel;
@property (nonatomic, assign) double endTime;
@property (nonatomic, assign) double endCityId;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, assign) double paymentPaymentMethod;
@property (nonatomic, assign) double actualLoad;
@property (nonatomic, strong) NSString *paymentFinishTime;
@property (nonatomic, assign) double realityPrice;
@property (nonatomic, assign) double vehicleType;
@property (nonatomic, strong) NSString *taxEntName;
@property (nonatomic, strong) NSString *taxEntAddr;
@property (nonatomic, assign) double realityFeeRate;
@property (nonatomic, strong) NSString *taxNumber;
@property (nonatomic, strong) NSString *startTownName;
@property (nonatomic, strong) NSString *endCityName;
@property (nonatomic, strong) NSString *fleetName;
@property (nonatomic, strong) NSString *taxAppleTime;
@property (nonatomic, assign) double shipperId;
@property (nonatomic, assign) double servicePrice;
@property (nonatomic, assign) double waybillState;
@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, assign) double endTownId;
@property (nonatomic, strong) NSString *vehicleNumber;
@property (nonatomic, assign) double realityServicePrice;
@property (nonatomic, assign) double startTime;
@property (nonatomic, strong) NSString *taxBankName;
@property (nonatomic, strong) NSString *taxBankAccount;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, strong) NSString *cargoName;
@property (nonatomic, strong) NSString *startPhone;
@property (nonatomic, assign) double endProvinceId;
@property (nonatomic, assign) double startCountyId;
@property (nonatomic, strong) NSString *paymentAppleTime;
@property (nonatomic, strong) NSString *startAddr;
@property (nonatomic, assign) double startTownId;
@property (nonatomic, strong) NSString *taxPhone;
@property (nonatomic, strong) NSString *taxAuditTime;
@property (nonatomic, strong) NSString *proxySerialNumber;
@property (nonatomic, strong) NSString *unloadPoundUrl;
@property (nonatomic, strong) NSString *endAddr;
@property (nonatomic, strong) NSString *endEntName;
@property (nonatomic, strong) NSString *endCountyName;
@property (nonatomic, strong) NSString *loadUnit;
@property (nonatomic, assign) double standardLoad;
@property (nonatomic, strong) NSString *shipperPhone;
@property (nonatomic, strong) NSString *startCountyName;
@property (nonatomic, assign) double vehicleId;
@property (nonatomic, strong) NSString *waybillNumber;
@property (nonatomic, assign) double fleetId;
@property (nonatomic, strong) NSString *startContact;
@property (nonatomic, assign) double paymentState;
@property (nonatomic, strong) NSString *endProvinceName;
@property (nonatomic, strong) NSString *returnUrl;
@property (nonatomic, strong) NSString *loadPoundUrl;
@property (nonatomic, assign) double taxPaymentMethod;
@property (nonatomic, strong) NSString *proxyTime;
@property (nonatomic, assign) double serviceFeeRate;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double driverId;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, strong) NSString *paymentAuditTime;
@property (nonatomic, strong) NSString *fleetPhone;
@property (nonatomic, strong) NSString *taxFinishTime;
@property (nonatomic, assign) double vehicleLength;
@property (nonatomic, assign) double endCountyId;
@property (nonatomic, assign) double proxyPaymentMethod;
@property (nonatomic, assign) double startCityId;
@property (nonatomic, assign) double taxPaymentChannel;
@property (nonatomic, strong) NSString *shipperName;
@property (nonatomic, strong) NSString *endContact;
@property (nonatomic, strong) NSArray *loadUrlList;
@property (nonatomic, strong) NSArray *unloadUrlList;
@property (nonatomic, assign) double loadTime;
@property (nonatomic, assign) double unloadTime;
@property (nonatomic, assign) double rejectTime;
@property (nonatomic, assign) double acceptTime;
@property (nonatomic, assign) double finishTime;

@property (nonatomic, strong) NSString *key;

//logical state
@property (nonatomic, readonly) ENUM_BULKCARGO_ORDER_OPERATE_TYPE operateType;
@property (nonatomic, readonly) NSString * orderStatusShow;
@property (nonatomic, readonly) UIColor *colorStateShow;
@property (nonatomic, readonly) NSString *startAddressShow;
@property (nonatomic, readonly) NSString *endAddressShow;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
