//
//  ModelBulkCargoOrder.m
//
//  Created by 林栋 隋 on 2019/7/17
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelBulkCargoOrder.h"


NSString *const kModelBulkCargoOrderProxyTaxState = @"proxyTaxState";
NSString *const kModelBulkCargoOrderTaxReceiptNumber = @"taxReceiptNumber";
NSString *const kModelBulkCargoOrderEndPhone = @"endPhone";
NSString *const kModelBulkCargoOrderPaymentPaymentChannel = @"paymentPaymentChannel";
NSString *const kModelBulkCargoOrderDescription = @"description";
NSString *const kModelBulkCargoOrderFastMailNumber = @"fastMailNumber";
NSString *const kModelBulkCargoOrderFastMailChannel = @"fastMailChannel";
NSString *const kModelBulkCargoOrderId = @"id";
NSString *const kModelBulkCargoOrderTaxState = @"taxState";
NSString *const kModelBulkCargoOrderPrice = @"price";
NSString *const kModelBulkCargoOrderEndTownName = @"endTownName";
NSString *const kModelBulkCargoOrderStartProvinceId = @"startProvinceId";
NSString *const kModelBulkCargoOrderProxyPaymentChannel = @"proxyPaymentChannel";
NSString *const kModelBulkCargoOrderEndTime = @"endTime";
NSString *const kModelBulkCargoOrderEndCityId = @"endCityId";
NSString *const kModelBulkCargoOrderDriverPhone = @"driverPhone";
NSString *const kModelBulkCargoOrderPaymentPaymentMethod = @"paymentPaymentMethod";
NSString *const kModelBulkCargoOrderActualLoad = @"actualLoad";
NSString *const kModelBulkCargoOrderPaymentFinishTime = @"paymentFinishTime";
NSString *const kModelBulkCargoOrderRealityPrice = @"realityPrice";
NSString *const kModelBulkCargoOrderVehicleType = @"vehicleType";
NSString *const kModelBulkCargoOrderAcceptTime = @"acceptTime";
NSString *const kModelBulkCargoOrderTaxEntName = @"taxEntName";
NSString *const kModelBulkCargoOrderTaxEntAddr = @"taxEntAddr";
NSString *const kModelBulkCargoOrderRealityFeeRate = @"realityFeeRate";
NSString *const kModelBulkCargoOrderTaxNumber = @"taxNumber";
NSString *const kModelBulkCargoOrderStartTownName = @"startTownName";
NSString *const kModelBulkCargoOrderEndCityName = @"endCityName";
NSString *const kModelBulkCargoOrderFleetName = @"fleetName";
NSString *const kModelBulkCargoOrderFinishTime = @"finishTime";
NSString *const kModelBulkCargoOrderTaxAppleTime = @"taxAppleTime";
NSString *const kModelBulkCargoOrderShipperId = @"shipperId";
NSString *const kModelBulkCargoOrderServicePrice = @"servicePrice";
NSString *const kModelBulkCargoOrderWaybillState = @"waybillState";
NSString *const kModelBulkCargoOrderStartCityName = @"startCityName";
NSString *const kModelBulkCargoOrderEndTownId = @"endTownId";
NSString *const kModelBulkCargoOrderVehicleNumber = @"vehicleNumber";
NSString *const kModelBulkCargoOrderRealityServicePrice = @"realityServicePrice";
NSString *const kModelBulkCargoOrderStartTime = @"startTime";
NSString *const kModelBulkCargoOrderTaxBankName = @"taxBankName";
NSString *const kModelBulkCargoOrderTaxBankAccount = @"taxBankAccount";
NSString *const kModelBulkCargoOrderStartProvinceName = @"startProvinceName";
NSString *const kModelBulkCargoOrderCargoName = @"cargoName";
NSString *const kModelBulkCargoOrderStartPhone = @"startPhone";
NSString *const kModelBulkCargoOrderEndProvinceId = @"endProvinceId";
NSString *const kModelBulkCargoOrderStartCountyId = @"startCountyId";
NSString *const kModelBulkCargoOrderPaymentAppleTime = @"paymentAppleTime";
NSString *const kModelBulkCargoOrderStartAddr = @"startAddr";
NSString *const kModelBulkCargoOrderStartTownId = @"startTownId";
NSString *const kModelBulkCargoOrderTaxPhone = @"taxPhone";
NSString *const kModelBulkCargoOrderTaxAuditTime = @"taxAuditTime";
NSString *const kModelBulkCargoOrderProxySerialNumber = @"proxySerialNumber";
NSString *const kModelBulkCargoOrderUnloadPoundUrl = @"unloadPoundUrl";
NSString *const kModelBulkCargoOrderEndAddr = @"endAddr";
NSString *const kModelBulkCargoOrderEndEntName = @"endEntName";
NSString *const kModelBulkCargoOrderEndCountyName = @"endCountyName";
NSString *const kModelBulkCargoOrderLoadUnit = @"loadUnit";
NSString *const kModelBulkCargoOrderStandardLoad = @"standardLoad";
NSString *const kModelBulkCargoOrderShipperPhone = @"shipperPhone";
NSString *const kModelBulkCargoOrderStartCountyName = @"startCountyName";
NSString *const kModelBulkCargoOrderVehicleId = @"vehicleId";
NSString *const kModelBulkCargoOrderWaybillNumber = @"waybillNumber";
NSString *const kModelBulkCargoOrderFleetId = @"fleetId";
NSString *const kModelBulkCargoOrderStartContact = @"startContact";
NSString *const kModelBulkCargoOrderPaymentState = @"paymentState";
NSString *const kModelBulkCargoOrderEndProvinceName = @"endProvinceName";
NSString *const kModelBulkCargoOrderReturnUrl = @"returnUrl";
NSString *const kModelBulkCargoOrderLoadPoundUrl = @"loadPoundUrl";
NSString *const kModelBulkCargoOrderTaxPaymentMethod = @"taxPaymentMethod";
NSString *const kModelBulkCargoOrderProxyTime = @"proxyTime";
NSString *const kModelBulkCargoOrderServiceFeeRate = @"serviceFeeRate";
NSString *const kModelBulkCargoOrderCreateTime = @"createTime";
NSString *const kModelBulkCargoOrderDriverId = @"driverId";
NSString *const kModelBulkCargoOrderReason = @"reason";
NSString *const kModelBulkCargoOrderDriverName = @"driverName";
NSString *const kModelBulkCargoOrderPaymentAuditTime = @"paymentAuditTime";
NSString *const kModelBulkCargoOrderFleetPhone = @"fleetPhone";
NSString *const kModelBulkCargoOrderTaxFinishTime = @"taxFinishTime";
NSString *const kModelBulkCargoOrderVehicleLength = @"vehicleLength";
NSString *const kModelBulkCargoOrderEndCountyId = @"endCountyId";
NSString *const kModelBulkCargoOrderProxyPaymentMethod = @"proxyPaymentMethod";
NSString *const kModelBulkCargoOrderStartCityId = @"startCityId";
NSString *const kModelBulkCargoOrderTaxPaymentChannel = @"taxPaymentChannel";
NSString *const kModelBulkCargoOrderShipperName = @"shipperName";
NSString *const kModelBulkCargoOrderEndContact = @"endContact";
NSString *const kModelBulkCargoOrderLoadUrlList = @"loadUrlList";
NSString *const kModelBulkCargoOrderUnloadUrlList = @"unloadUrlList";
NSString *const kModelBulkCargoOrderLoadTime = @"loadTime";
NSString *const kModelBulkCargoOrderRejectTime = @"rejectTime";
NSString *const kModelBulkCargoOrderUnloadTime = @"unloadTime";

NSString *const kModelBulkCargoOrderKey = @"key";

@interface ModelBulkCargoOrder ()

@end

@implementation ModelBulkCargoOrder

@synthesize proxyTaxState = _proxyTaxState;
@synthesize taxReceiptNumber = _taxReceiptNumber;
@synthesize endPhone = _endPhone;
@synthesize paymentPaymentChannel = _paymentPaymentChannel;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize fastMailNumber = _fastMailNumber;
@synthesize fastMailChannel = _fastMailChannel;
@synthesize iDProperty = _iDProperty;
@synthesize taxState = _taxState;
@synthesize price = _price;
@synthesize endTownName = _endTownName;
@synthesize startProvinceId = _startProvinceId;
@synthesize proxyPaymentChannel = _proxyPaymentChannel;
@synthesize endTime = _endTime;
@synthesize endCityId = _endCityId;
@synthesize driverPhone = _driverPhone;
@synthesize paymentPaymentMethod = _paymentPaymentMethod;
@synthesize actualLoad = _actualLoad;
@synthesize paymentFinishTime = _paymentFinishTime;
@synthesize realityPrice = _realityPrice;
@synthesize vehicleType = _vehicleType;
@synthesize acceptTime = _acceptTime;
@synthesize taxEntName = _taxEntName;
@synthesize taxEntAddr = _taxEntAddr;
@synthesize realityFeeRate = _realityFeeRate;
@synthesize taxNumber = _taxNumber;
@synthesize startTownName = _startTownName;
@synthesize endCityName = _endCityName;
@synthesize fleetName = _fleetName;
@synthesize finishTime = _finishTime;
@synthesize taxAppleTime = _taxAppleTime;
@synthesize shipperId = _shipperId;
@synthesize servicePrice = _servicePrice;
@synthesize waybillState = _waybillState;
@synthesize startCityName = _startCityName;
@synthesize endTownId = _endTownId;
@synthesize vehicleNumber = _vehicleNumber;
@synthesize realityServicePrice = _realityServicePrice;
@synthesize startTime = _startTime;
@synthesize taxBankName = _taxBankName;
@synthesize taxBankAccount = _taxBankAccount;
@synthesize startProvinceName = _startProvinceName;
@synthesize cargoName = _cargoName;
@synthesize startPhone = _startPhone;
@synthesize endProvinceId = _endProvinceId;
@synthesize startCountyId = _startCountyId;
@synthesize paymentAppleTime = _paymentAppleTime;
@synthesize loadTime = _loadTime;
@synthesize startAddr = _startAddr;
@synthesize startTownId = _startTownId;
@synthesize taxPhone = _taxPhone;
@synthesize taxAuditTime = _taxAuditTime;
@synthesize proxySerialNumber = _proxySerialNumber;
@synthesize unloadPoundUrl = _unloadPoundUrl;
@synthesize endAddr = _endAddr;
@synthesize endEntName = _endEntName;
@synthesize endCountyName = _endCountyName;
@synthesize loadUnit = _loadUnit;
@synthesize standardLoad = _standardLoad;
@synthesize shipperPhone = _shipperPhone;
@synthesize startCountyName = _startCountyName;
@synthesize vehicleId = _vehicleId;
@synthesize waybillNumber = _waybillNumber;
@synthesize fleetId = _fleetId;
@synthesize startContact = _startContact;
@synthesize paymentState = _paymentState;
@synthesize endProvinceName = _endProvinceName;
@synthesize returnUrl = _returnUrl;
@synthesize loadPoundUrl = _loadPoundUrl;
@synthesize taxPaymentMethod = _taxPaymentMethod;
@synthesize proxyTime = _proxyTime;
@synthesize serviceFeeRate = _serviceFeeRate;
@synthesize createTime = _createTime;
@synthesize driverId = _driverId;
@synthesize reason = _reason;
@synthesize driverName = _driverName;
@synthesize paymentAuditTime = _paymentAuditTime;
@synthesize fleetPhone = _fleetPhone;
@synthesize taxFinishTime = _taxFinishTime;
@synthesize vehicleLength = _vehicleLength;
@synthesize endCountyId = _endCountyId;
@synthesize proxyPaymentMethod = _proxyPaymentMethod;
@synthesize startCityId = _startCityId;
@synthesize taxPaymentChannel = _taxPaymentChannel;
@synthesize shipperName = _shipperName;
@synthesize endContact = _endContact;

- (ENUM_BULKCARGO_ORDER_OPERATE_TYPE)operateType{
    return [ModelBulkCargoOrder transformOrderOperateType:self.waybillState];
}
-(NSString *)orderStatusShow{
    return [ModelBulkCargoOrder transformOrderStatusToName:self.waybillState];
}
-(NSString *)startAddressShow{
    return [NSString stringWithFormat:@"%@%@%@ %@",UnPackStr(self.startProvinceName),[self.startCityName isEqualToString:self.startProvinceName]?@"":UnPackStr(self.startCityName),UnPackStr(self.startTownName),UnPackStr(self.startAddr)];
}
-(NSString *)endAddressShow{
    return [NSString stringWithFormat:@"%@%@%@ %@",UnPackStr(self.endProvinceName),[self.endCityName isEqualToString:self.endProvinceName]?@"":UnPackStr(self.endCityName),UnPackStr(self.endTownName),UnPackStr(self.endAddr)];
}
+ (NSString *)transformOrderStatusToName:(int)state {
    switch ((int)state) {
        case 1:
            return @"待接单";
            break;
        case 2:
            return @"待装车";
            break;
        case 3:
            return @"待完成";
            break;
        case 10:
            return @"已到达";//
            break;
        case 11:
            return @"已完成";//
            break;
 
        case 99:
            return @"已关闭";
            break;
        default:
            break;
    }
    return @"";
}
- (UIColor *)colorStateShow{
    switch (self.operateType) {
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE:
            return COLOR_BLUE;
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_ARRIVE:
            return [UIColor colorWithHexString:@"#F97A1B"];
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE:
            return COLOR_GREEN ;
            break;
        default:
            break;
    }
    return COLOR_RED;
}

+(ENUM_BULKCARGO_ORDER_OPERATE_TYPE)transformOrderOperateType:(int)status{
    switch (status) {
        case 1:
            return ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE;
            break;
        case 2:
            return ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD;
            break;
        case 3:
            return ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD;
            break;
        case 10:
            return ENUM_BULKCARGO_ORDER_OPERATE_ARRIVE;
            break;
        case 11:
            return ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE;
            break;
        case 99:
            return ENUM_BULKCARGO_ORDER_OPERATE_CLOSE;
            break;
            
        default:
            break;
    }
    return ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE;
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
            self.proxyTaxState = [dict doubleValueForKey:kModelBulkCargoOrderProxyTaxState];
            self.taxReceiptNumber = [dict stringValueForKey:kModelBulkCargoOrderTaxReceiptNumber];
            self.endPhone = [dict stringValueForKey:kModelBulkCargoOrderEndPhone];
            self.paymentPaymentChannel = [dict doubleValueForKey:kModelBulkCargoOrderPaymentPaymentChannel];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelBulkCargoOrderDescription];
            self.fastMailNumber = [dict stringValueForKey:kModelBulkCargoOrderFastMailNumber];
            self.fastMailChannel = [dict doubleValueForKey:kModelBulkCargoOrderFastMailChannel];
            self.iDProperty = [dict doubleValueForKey:kModelBulkCargoOrderId];
            self.taxState = [dict doubleValueForKey:kModelBulkCargoOrderTaxState];
            self.price = [dict doubleValueForKey:kModelBulkCargoOrderPrice];
            self.endTownName = [dict stringValueForKey:kModelBulkCargoOrderEndTownName];
            self.startProvinceId = [dict doubleValueForKey:kModelBulkCargoOrderStartProvinceId];
            self.proxyPaymentChannel = [dict doubleValueForKey:kModelBulkCargoOrderProxyPaymentChannel];
            self.endTime = [dict doubleValueForKey:kModelBulkCargoOrderEndTime];
            self.endCityId = [dict doubleValueForKey:kModelBulkCargoOrderEndCityId];
            self.driverPhone = [dict stringValueForKey:kModelBulkCargoOrderDriverPhone];
            self.paymentPaymentMethod = [dict doubleValueForKey:kModelBulkCargoOrderPaymentPaymentMethod];
            self.actualLoad = [dict doubleValueForKey:kModelBulkCargoOrderActualLoad];
            self.paymentFinishTime = [dict stringValueForKey:kModelBulkCargoOrderPaymentFinishTime];
            self.realityPrice = [dict doubleValueForKey:kModelBulkCargoOrderRealityPrice];
            self.vehicleType = [dict doubleValueForKey:kModelBulkCargoOrderVehicleType];
            self.acceptTime = [dict doubleValueForKey:kModelBulkCargoOrderAcceptTime];
            self.taxEntName = [dict stringValueForKey:kModelBulkCargoOrderTaxEntName];
            self.taxEntAddr = [dict stringValueForKey:kModelBulkCargoOrderTaxEntAddr];
            self.realityFeeRate = [dict doubleValueForKey:kModelBulkCargoOrderRealityFeeRate];
            self.taxNumber = [dict stringValueForKey:kModelBulkCargoOrderTaxNumber];
            self.startTownName = [dict stringValueForKey:kModelBulkCargoOrderStartTownName];
            self.endCityName = [dict stringValueForKey:kModelBulkCargoOrderEndCityName];
            self.fleetName = [dict stringValueForKey:kModelBulkCargoOrderFleetName];
            self.taxAppleTime = [dict stringValueForKey:kModelBulkCargoOrderTaxAppleTime];
            self.shipperId = [dict doubleValueForKey:kModelBulkCargoOrderShipperId];
            self.servicePrice = [dict doubleValueForKey:kModelBulkCargoOrderServicePrice];
            self.waybillState = [dict doubleValueForKey:kModelBulkCargoOrderWaybillState];
            self.startCityName = [dict stringValueForKey:kModelBulkCargoOrderStartCityName];
            self.endTownId = [dict doubleValueForKey:kModelBulkCargoOrderEndTownId];
            self.vehicleNumber = [dict stringValueForKey:kModelBulkCargoOrderVehicleNumber];
            self.realityServicePrice = [dict doubleValueForKey:kModelBulkCargoOrderRealityServicePrice];
            self.startTime = [dict doubleValueForKey:kModelBulkCargoOrderStartTime];
            self.taxBankName = [dict stringValueForKey:kModelBulkCargoOrderTaxBankName];
            self.taxBankAccount = [dict stringValueForKey:kModelBulkCargoOrderTaxBankAccount];
            self.startProvinceName = [dict stringValueForKey:kModelBulkCargoOrderStartProvinceName];
            self.cargoName = [dict stringValueForKey:kModelBulkCargoOrderCargoName];
            self.startPhone = [dict stringValueForKey:kModelBulkCargoOrderStartPhone];
            self.endProvinceId = [dict doubleValueForKey:kModelBulkCargoOrderEndProvinceId];
            self.startCountyId = [dict doubleValueForKey:kModelBulkCargoOrderStartCountyId];
            self.paymentAppleTime = [dict stringValueForKey:kModelBulkCargoOrderPaymentAppleTime];
            self.startAddr = [dict stringValueForKey:kModelBulkCargoOrderStartAddr];
            self.startTownId = [dict doubleValueForKey:kModelBulkCargoOrderStartTownId];
            self.taxPhone = [dict stringValueForKey:kModelBulkCargoOrderTaxPhone];
            self.taxAuditTime = [dict stringValueForKey:kModelBulkCargoOrderTaxAuditTime];
            self.proxySerialNumber = [dict stringValueForKey:kModelBulkCargoOrderProxySerialNumber];
            self.unloadPoundUrl = [dict stringValueForKey:kModelBulkCargoOrderUnloadPoundUrl];
            self.endAddr = [dict stringValueForKey:kModelBulkCargoOrderEndAddr];
            self.endEntName = [dict stringValueForKey:kModelBulkCargoOrderEndEntName];
            self.endCountyName = [dict stringValueForKey:kModelBulkCargoOrderEndCountyName];
            self.loadUnit = [dict stringValueForKey:kModelBulkCargoOrderLoadUnit];
            self.standardLoad = [dict doubleValueForKey:kModelBulkCargoOrderStandardLoad];
            self.shipperPhone = [dict stringValueForKey:kModelBulkCargoOrderShipperPhone];
            self.startCountyName = [dict stringValueForKey:kModelBulkCargoOrderStartCountyName];
            self.vehicleId = [dict doubleValueForKey:kModelBulkCargoOrderVehicleId];
            self.waybillNumber = [dict stringValueForKey:kModelBulkCargoOrderWaybillNumber];
            self.fleetId = [dict doubleValueForKey:kModelBulkCargoOrderFleetId];
            self.startContact = [dict stringValueForKey:kModelBulkCargoOrderStartContact];
            self.paymentState = [dict doubleValueForKey:kModelBulkCargoOrderPaymentState];
            self.endProvinceName = [dict stringValueForKey:kModelBulkCargoOrderEndProvinceName];
            self.returnUrl = [dict stringValueForKey:kModelBulkCargoOrderReturnUrl];
            self.loadPoundUrl = [dict stringValueForKey:kModelBulkCargoOrderLoadPoundUrl];
            self.taxPaymentMethod = [dict doubleValueForKey:kModelBulkCargoOrderTaxPaymentMethod];
            self.proxyTime = [dict stringValueForKey:kModelBulkCargoOrderProxyTime];
            self.serviceFeeRate = [dict doubleValueForKey:kModelBulkCargoOrderServiceFeeRate];
            self.createTime = [dict doubleValueForKey:kModelBulkCargoOrderCreateTime];
            self.driverId = [dict doubleValueForKey:kModelBulkCargoOrderDriverId];
            self.reason = [dict stringValueForKey:kModelBulkCargoOrderReason];
            self.driverName = [dict stringValueForKey:kModelBulkCargoOrderDriverName];
            self.paymentAuditTime = [dict stringValueForKey:kModelBulkCargoOrderPaymentAuditTime];
            self.fleetPhone = [dict stringValueForKey:kModelBulkCargoOrderFleetPhone];
            self.taxFinishTime = [dict stringValueForKey:kModelBulkCargoOrderTaxFinishTime];
            self.vehicleLength = [dict doubleValueForKey:kModelBulkCargoOrderVehicleLength];
            self.endCountyId = [dict doubleValueForKey:kModelBulkCargoOrderEndCountyId];
            self.proxyPaymentMethod = [dict doubleValueForKey:kModelBulkCargoOrderProxyPaymentMethod];
            self.startCityId = [dict doubleValueForKey:kModelBulkCargoOrderStartCityId];
            self.taxPaymentChannel = [dict doubleValueForKey:kModelBulkCargoOrderTaxPaymentChannel];
            self.shipperName = [dict stringValueForKey:kModelBulkCargoOrderShipperName];
            self.endContact = [dict stringValueForKey:kModelBulkCargoOrderEndContact];
        self.loadUrlList = [dict arrayValueForKey:kModelBulkCargoOrderLoadUrlList];
        self.unloadUrlList =  [dict arrayValueForKey:kModelBulkCargoOrderUnloadUrlList];
        self.loadTime = [dict doubleValueForKey:kModelBulkCargoOrderLoadTime];
        self.finishTime = [dict doubleValueForKey:kModelBulkCargoOrderFinishTime];
        self.unloadTime = [dict doubleValueForKey:kModelBulkCargoOrderUnloadTime];
        self.rejectTime = [dict doubleValueForKey:kModelBulkCargoOrderRejectTime];
        self.key = [dict stringValueForKey:kModelBulkCargoOrderKey];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.proxyTaxState] forKey:kModelBulkCargoOrderProxyTaxState];
    [mutableDict setValue:self.taxReceiptNumber forKey:kModelBulkCargoOrderTaxReceiptNumber];
    [mutableDict setValue:self.endPhone forKey:kModelBulkCargoOrderEndPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.paymentPaymentChannel] forKey:kModelBulkCargoOrderPaymentPaymentChannel];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelBulkCargoOrderDescription];
    [mutableDict setValue:self.fastMailNumber forKey:kModelBulkCargoOrderFastMailNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fastMailChannel] forKey:kModelBulkCargoOrderFastMailChannel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelBulkCargoOrderId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.taxState] forKey:kModelBulkCargoOrderTaxState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelBulkCargoOrderPrice];
    [mutableDict setValue:self.endTownName forKey:kModelBulkCargoOrderEndTownName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startProvinceId] forKey:kModelBulkCargoOrderStartProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.proxyPaymentChannel] forKey:kModelBulkCargoOrderProxyPaymentChannel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kModelBulkCargoOrderEndTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCityId] forKey:kModelBulkCargoOrderEndCityId];
    [mutableDict setValue:self.driverPhone forKey:kModelBulkCargoOrderDriverPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.paymentPaymentMethod] forKey:kModelBulkCargoOrderPaymentPaymentMethod];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actualLoad] forKey:kModelBulkCargoOrderActualLoad];
    [mutableDict setValue:self.paymentFinishTime forKey:kModelBulkCargoOrderPaymentFinishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.realityPrice] forKey:kModelBulkCargoOrderRealityPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleType] forKey:kModelBulkCargoOrderVehicleType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acceptTime] forKey:kModelBulkCargoOrderAcceptTime];
    [mutableDict setValue:self.taxEntName forKey:kModelBulkCargoOrderTaxEntName];
    [mutableDict setValue:self.taxEntAddr forKey:kModelBulkCargoOrderTaxEntAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.realityFeeRate] forKey:kModelBulkCargoOrderRealityFeeRate];
    [mutableDict setValue:self.taxNumber forKey:kModelBulkCargoOrderTaxNumber];
    [mutableDict setValue:self.startTownName forKey:kModelBulkCargoOrderStartTownName];
    [mutableDict setValue:self.endCityName forKey:kModelBulkCargoOrderEndCityName];
    [mutableDict setValue:self.fleetName forKey:kModelBulkCargoOrderFleetName];
    [mutableDict setValue:self.taxAppleTime forKey:kModelBulkCargoOrderTaxAppleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shipperId] forKey:kModelBulkCargoOrderShipperId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.servicePrice] forKey:kModelBulkCargoOrderServicePrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waybillState] forKey:kModelBulkCargoOrderWaybillState];
    [mutableDict setValue:self.startCityName forKey:kModelBulkCargoOrderStartCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTownId] forKey:kModelBulkCargoOrderEndTownId];
    [mutableDict setValue:self.vehicleNumber forKey:kModelBulkCargoOrderVehicleNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.realityServicePrice] forKey:kModelBulkCargoOrderRealityServicePrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kModelBulkCargoOrderStartTime];
    [mutableDict setValue:self.taxBankName forKey:kModelBulkCargoOrderTaxBankName];
    [mutableDict setValue:self.taxBankAccount forKey:kModelBulkCargoOrderTaxBankAccount];
    [mutableDict setValue:self.startProvinceName forKey:kModelBulkCargoOrderStartProvinceName];
    [mutableDict setValue:self.cargoName forKey:kModelBulkCargoOrderCargoName];
    [mutableDict setValue:self.startPhone forKey:kModelBulkCargoOrderStartPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endProvinceId] forKey:kModelBulkCargoOrderEndProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCountyId] forKey:kModelBulkCargoOrderStartCountyId];
    [mutableDict setValue:self.paymentAppleTime forKey:kModelBulkCargoOrderPaymentAppleTime];
    [mutableDict setValue:self.startAddr forKey:kModelBulkCargoOrderStartAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTownId] forKey:kModelBulkCargoOrderStartTownId];
    [mutableDict setValue:self.taxPhone forKey:kModelBulkCargoOrderTaxPhone];
    [mutableDict setValue:self.taxAuditTime forKey:kModelBulkCargoOrderTaxAuditTime];
    [mutableDict setValue:self.proxySerialNumber forKey:kModelBulkCargoOrderProxySerialNumber];
    [mutableDict setValue:self.unloadPoundUrl forKey:kModelBulkCargoOrderUnloadPoundUrl];
    [mutableDict setValue:self.endAddr forKey:kModelBulkCargoOrderEndAddr];
    [mutableDict setValue:self.endEntName forKey:kModelBulkCargoOrderEndEntName];
    [mutableDict setValue:self.endCountyName forKey:kModelBulkCargoOrderEndCountyName];
    [mutableDict setValue:self.loadUnit forKey:kModelBulkCargoOrderLoadUnit];
    [mutableDict setValue:[NSNumber numberWithDouble:self.standardLoad] forKey:kModelBulkCargoOrderStandardLoad];
    [mutableDict setValue:self.shipperPhone forKey:kModelBulkCargoOrderShipperPhone];
    [mutableDict setValue:self.startCountyName forKey:kModelBulkCargoOrderStartCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleId] forKey:kModelBulkCargoOrderVehicleId];
    [mutableDict setValue:self.waybillNumber forKey:kModelBulkCargoOrderWaybillNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fleetId] forKey:kModelBulkCargoOrderFleetId];
    [mutableDict setValue:self.startContact forKey:kModelBulkCargoOrderStartContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.paymentState] forKey:kModelBulkCargoOrderPaymentState];
    [mutableDict setValue:self.endProvinceName forKey:kModelBulkCargoOrderEndProvinceName];
    [mutableDict setValue:self.returnUrl forKey:kModelBulkCargoOrderReturnUrl];
    [mutableDict setValue:self.loadPoundUrl forKey:kModelBulkCargoOrderLoadPoundUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.taxPaymentMethod] forKey:kModelBulkCargoOrderTaxPaymentMethod];
    [mutableDict setValue:self.proxyTime forKey:kModelBulkCargoOrderProxyTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.serviceFeeRate] forKey:kModelBulkCargoOrderServiceFeeRate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelBulkCargoOrderCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kModelBulkCargoOrderDriverId];
    [mutableDict setValue:self.reason forKey:kModelBulkCargoOrderReason];
    [mutableDict setValue:self.driverName forKey:kModelBulkCargoOrderDriverName];
    [mutableDict setValue:self.paymentAuditTime forKey:kModelBulkCargoOrderPaymentAuditTime];
    [mutableDict setValue:self.fleetPhone forKey:kModelBulkCargoOrderFleetPhone];
    [mutableDict setValue:self.taxFinishTime forKey:kModelBulkCargoOrderTaxFinishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleLength] forKey:kModelBulkCargoOrderVehicleLength];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCountyId] forKey:kModelBulkCargoOrderEndCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.proxyPaymentMethod] forKey:kModelBulkCargoOrderProxyPaymentMethod];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCityId] forKey:kModelBulkCargoOrderStartCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.taxPaymentChannel] forKey:kModelBulkCargoOrderTaxPaymentChannel];
    [mutableDict setValue:self.shipperName forKey:kModelBulkCargoOrderShipperName];
    [mutableDict setValue:self.endContact forKey:kModelBulkCargoOrderEndContact];
    [mutableDict setValue:self.loadUrlList forKey:kModelBulkCargoOrderLoadUrlList];
    [mutableDict setValue:self.unloadUrlList forKey:kModelBulkCargoOrderUnloadUrlList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loadTime] forKey:kModelBulkCargoOrderLoadTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.finishTime] forKey:kModelBulkCargoOrderFinishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.unloadTime] forKey:kModelBulkCargoOrderUnloadTime];

    [mutableDict setValue:[NSNumber numberWithDouble:self.rejectTime] forKey:kModelBulkCargoOrderRejectTime];
    [mutableDict setValue:self.key forKey:kModelBulkCargoOrderKey];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
