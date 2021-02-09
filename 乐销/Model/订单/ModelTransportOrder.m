//
//  ModelTransportOrder.m
//
//  Created by 林栋 隋 on 2021/1/23
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelTransportOrder.h"


NSString *const kModelTransportOrderRtbpNumber = @"rtbpNumber";
NSString *const kModelTransportOrderPlateNumber = @"plateNumber";
NSString *const kModelTransportOrderPlatformTime = @"platformTime";
NSString *const kModelTransportOrderStartCityId = @"startCityId";
NSString *const kModelTransportOrderEndCountyCode = @"endCountyCode";
NSString *const kModelTransportOrderMode = @"mode";
NSString *const kModelTransportOrderEndPhone = @"endPhone";
NSString *const kModelTransportOrderConfirmTime = @"confirmTime";
NSString *const kModelTransportOrderStartAddr = @"startAddr";
NSString *const kModelTransportOrderAcceptTime = @"acceptTime";
NSString *const kModelTransportOrderBizOrderTime = @"bizOrderTime";
NSString *const kModelTransportOrderIsShipperEvaluation = @"isShipperEvaluation";
NSString *const kModelTransportOrderTransportQty = @"transportQty";
NSString *const kModelTransportOrderPriceUnit = @"priceUnit";
NSString *const kModelTransportOrderCargoTypeClass = @"cargoTypeClass";
NSString *const kModelTransportOrderStartContacter = @"startContacter";
NSString *const kModelTransportOrderStartCountyName = @"startCountyName";
NSString *const kModelTransportOrderStartPhone = @"startPhone";
NSString *const kModelTransportOrderStartProvinceId = @"startProvinceId";
NSString *const kModelTransportOrderCargoName = @"cargoName";
NSString *const kModelTransportOrderCargoWeight = @"cargoWeight";
NSString *const kModelTransportOrderEndProvinceId = @"endProvinceId";
NSString *const kModelTransportOrderUnloadTime = @"unloadTime";
NSString *const kModelTransportOrderDriverId = @"driverId";
NSString *const kModelTransportOrderEndCityName = @"endCityName";
NSString *const kModelTransportOrderEndCountyName = @"endCountyName";
NSString *const kModelTransportOrderVehicleId = @"vehicleId";
NSString *const kModelTransportOrderStartCityName = @"startCityName";
NSString *const kModelTransportOrderFinishTime = @"finishTime";
NSString *const kModelTransportOrderChannel = @"channel";
NSString *const kModelTransportOrderEndCityId = @"endCityId";
NSString *const kModelTransportOrderOrderStatus = @"orderStatus";
NSString *const kModelTransportOrderStartCountyId = @"startCountyId";
NSString *const kModelTransportOrderEndProvinceName = @"endProvinceName";
NSString *const kModelTransportOrderStartCountyCode = @"startCountyCode";
NSString *const kModelTransportOrderPlanNumber = @"planNumber";
NSString *const kModelTransportOrderShipperId = @"shipperId";
NSString *const kModelTransportOrderStartTime = @"startTime";
NSString *const kModelTransportOrderShipperPrice = @"shipperPrice";
NSString *const kModelTransportOrderLoadUrls = @"loadUrls";
NSString *const kModelTransportOrderEndAddr = @"endAddr";
NSString *const kModelTransportOrderIsDriverEvaluation = @"isDriverEvaluation";
NSString *const kModelTransportOrderExternalBatchNumber = @"externalBatchNumber";
NSString *const kModelTransportOrderDriverName = @"driverName";
NSString *const kModelTransportOrderEndTime = @"endTime";
NSString *const kModelTransportOrderExternalNumber = @"externalNumber";
NSString *const kModelTransportOrderEndCountyId = @"endCountyId";
NSString *const kModelTransportOrderUnloadUrls = @"unloadUrls";
NSString *const kModelTransportOrderShipperName = @"shipperName";
NSString *const kModelTransportOrderOrderNumber = @"orderNumber";
NSString *const kModelTransportOrderEndContacter = @"endContacter";
NSString *const kModelTransportOrderLoadTime = @"loadTime";
NSString *const kModelTransportOrderStartProvinceName = @"startProvinceName";
NSString *const kModelTransportOrderUnitPrice = @"unitPrice";


@interface ModelTransportOrder ()
@end

@implementation ModelTransportOrder

@synthesize rtbpNumber = _rtbpNumber;
@synthesize plateNumber = _plateNumber;
@synthesize platformTime = _platformTime;
@synthesize startCityId = _startCityId;
@synthesize endCountyCode = _endCountyCode;
@synthesize mode = _mode;
@synthesize endPhone = _endPhone;
@synthesize confirmTime = _confirmTime;
@synthesize startAddr = _startAddr;
@synthesize acceptTime = _acceptTime;
@synthesize bizOrderTime = _bizOrderTime;
@synthesize isShipperEvaluation = _isShipperEvaluation;
@synthesize transportQty = _transportQty;
@synthesize priceUnit = _priceUnit;
@synthesize cargoTypeClass = _cargoTypeClass;
@synthesize startContacter = _startContacter;
@synthesize startCountyName = _startCountyName;
@synthesize startPhone = _startPhone;
@synthesize startProvinceId = _startProvinceId;
@synthesize cargoName = _cargoName;
@synthesize cargoWeight = _cargoWeight;
@synthesize endProvinceId = _endProvinceId;
@synthesize unloadTime = _unloadTime;
@synthesize driverId = _driverId;
@synthesize endCityName = _endCityName;
@synthesize endCountyName = _endCountyName;
@synthesize vehicleId = _vehicleId;
@synthesize startCityName = _startCityName;
@synthesize finishTime = _finishTime;
@synthesize channel = _channel;
@synthesize endCityId = _endCityId;
@synthesize orderStatus = _orderStatus;
@synthesize startCountyId = _startCountyId;
@synthesize endProvinceName = _endProvinceName;
@synthesize startCountyCode = _startCountyCode;
@synthesize planNumber = _planNumber;
@synthesize shipperId = _shipperId;
@synthesize startTime = _startTime;
@synthesize shipperPrice = _shipperPrice;
@synthesize loadUrls = _loadUrls;
@synthesize endAddr = _endAddr;
@synthesize isDriverEvaluation = _isDriverEvaluation;
@synthesize externalBatchNumber = _externalBatchNumber;
@synthesize driverName = _driverName;
@synthesize endTime = _endTime;
@synthesize externalNumber = _externalNumber;
@synthesize endCountyId = _endCountyId;
@synthesize unloadUrls = _unloadUrls;
@synthesize shipperName = _shipperName;
@synthesize orderNumber = _orderNumber;
@synthesize endContacter = _endContacter;
@synthesize loadTime = _loadTime;
@synthesize startProvinceName = _startProvinceName;
@synthesize unitPrice = _unitPrice;

- (BOOL)isOutOfTime{
    NSDate * date = [GlobalMethod exchangeTimeStampToDate:self.endTime];
//    return  date.timeIntervalSinceNow > 0;
    return  date.timeIntervalSinceNow < 0;
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
            self.rtbpNumber = [dict stringValueForKey:kModelTransportOrderRtbpNumber];
            self.plateNumber = [dict stringValueForKey:kModelTransportOrderPlateNumber];
            self.platformTime = [dict doubleValueForKey:kModelTransportOrderPlatformTime];
            self.startCityId = [dict doubleValueForKey:kModelTransportOrderStartCityId];
            self.endCountyCode = [dict stringValueForKey:kModelTransportOrderEndCountyCode];
            self.mode = [dict doubleValueForKey:kModelTransportOrderMode];
            self.endPhone = [dict stringValueForKey:kModelTransportOrderEndPhone];
            self.confirmTime = [dict doubleValueForKey:kModelTransportOrderConfirmTime];
            self.startAddr = [dict stringValueForKey:kModelTransportOrderStartAddr];
            self.acceptTime = [dict doubleValueForKey:kModelTransportOrderAcceptTime];
            self.bizOrderTime = [dict doubleValueForKey:kModelTransportOrderBizOrderTime];
            self.isShipperEvaluation = [dict doubleValueForKey:kModelTransportOrderIsShipperEvaluation];
            self.transportQty = [dict doubleValueForKey:kModelTransportOrderTransportQty];
            self.priceUnit = [dict doubleValueForKey:kModelTransportOrderPriceUnit];
            self.cargoTypeClass = [dict doubleValueForKey:kModelTransportOrderCargoTypeClass];
            self.startContacter = [dict stringValueForKey:kModelTransportOrderStartContacter];
            self.startCountyName = [dict stringValueForKey:kModelTransportOrderStartCountyName];
            self.startPhone = [dict stringValueForKey:kModelTransportOrderStartPhone];
            self.startProvinceId = [dict doubleValueForKey:kModelTransportOrderStartProvinceId];
            self.cargoName = [dict stringValueForKey:kModelTransportOrderCargoName];
            self.cargoWeight = [dict doubleValueForKey:kModelTransportOrderCargoWeight];
            self.endProvinceId = [dict doubleValueForKey:kModelTransportOrderEndProvinceId];
            self.unloadTime = [dict doubleValueForKey:kModelTransportOrderUnloadTime];
            self.driverId = [dict doubleValueForKey:kModelTransportOrderDriverId];
            self.endCityName = [dict stringValueForKey:kModelTransportOrderEndCityName];
            self.endCountyName = [dict stringValueForKey:kModelTransportOrderEndCountyName];
            self.vehicleId = [dict doubleValueForKey:kModelTransportOrderVehicleId];
            self.startCityName = [dict stringValueForKey:kModelTransportOrderStartCityName];
            self.finishTime = [dict doubleValueForKey:kModelTransportOrderFinishTime];
            self.channel = [dict stringValueForKey:kModelTransportOrderChannel];
            self.endCityId = [dict doubleValueForKey:kModelTransportOrderEndCityId];
            self.orderStatus = [dict doubleValueForKey:kModelTransportOrderOrderStatus];
            self.startCountyId = [dict doubleValueForKey:kModelTransportOrderStartCountyId];
            self.endProvinceName = [dict stringValueForKey:kModelTransportOrderEndProvinceName];
            self.startCountyCode = [dict stringValueForKey:kModelTransportOrderStartCountyCode];
            self.planNumber = [dict stringValueForKey:kModelTransportOrderPlanNumber];
            self.shipperId = [dict doubleValueForKey:kModelTransportOrderShipperId];
            self.startTime = [dict doubleValueForKey:kModelTransportOrderStartTime];
            self.shipperPrice = [dict doubleValueForKey:kModelTransportOrderShipperPrice];
        self.loadUrls =  [dict arrayValueForKey:kModelTransportOrderLoadUrls];
            self.endAddr = [dict stringValueForKey:kModelTransportOrderEndAddr];
            self.isDriverEvaluation = [dict doubleValueForKey:kModelTransportOrderIsDriverEvaluation];
            self.externalBatchNumber = [dict objectForKey:kModelTransportOrderExternalBatchNumber];
            self.driverName = [dict stringValueForKey:kModelTransportOrderDriverName];
            self.endTime = [dict doubleValueForKey:kModelTransportOrderEndTime];
            self.externalNumber = [dict objectForKey:kModelTransportOrderExternalNumber];
            self.endCountyId = [dict doubleValueForKey:kModelTransportOrderEndCountyId];
        self.unloadUrls =  [dict arrayValueForKey:kModelTransportOrderUnloadUrls];
            self.shipperName = [dict stringValueForKey:kModelTransportOrderShipperName];
            self.orderNumber = [dict stringValueForKey:kModelTransportOrderOrderNumber];
            self.endContacter = [dict stringValueForKey:kModelTransportOrderEndContacter];
            self.loadTime = [dict doubleValueForKey:kModelTransportOrderLoadTime];
            self.startProvinceName = [dict stringValueForKey:kModelTransportOrderStartProvinceName];
            self.unitPrice = [dict doubleValueForKey:kModelTransportOrderUnitPrice];

        
        //logical
        self.qtyShow = self.transportQty;
        self.priceShow = self.unitPrice/100.0;
        switch ((int)self.priceUnit) {
            case 1:
                self.unitShow = @"箱";
                break;
            case 2:
                self.unitShow = @"件";
                break;
            case 3:
                self.unitShow = @"车";
                break;
            case 4:
                self.unitShow = @"吨";
                self.qtyShow = self.transportQty/1000.0;
                break;
            case 5:
                self.unitShow = @"立方米";
                self.qtyShow = self.transportQty/1000000000.0;
                break;
            default:
                break;
        }
        
        self.orderStatusShow = [ModelTransportOrder statusTransport: self.orderStatus];
        self.colorStateShow = [ModelTransportOrder statusColorTransport:self.orderStatus];
      
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rtbpNumber forKey:kModelTransportOrderRtbpNumber];
    [mutableDict setValue:self.plateNumber forKey:kModelTransportOrderPlateNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.platformTime] forKey:kModelTransportOrderPlatformTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCityId] forKey:kModelTransportOrderStartCityId];
    [mutableDict setValue:self.endCountyCode forKey:kModelTransportOrderEndCountyCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mode] forKey:kModelTransportOrderMode];
    [mutableDict setValue:self.endPhone forKey:kModelTransportOrderEndPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.confirmTime] forKey:kModelTransportOrderConfirmTime];
    [mutableDict setValue:self.startAddr forKey:kModelTransportOrderStartAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acceptTime] forKey:kModelTransportOrderAcceptTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizOrderTime] forKey:kModelTransportOrderBizOrderTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isShipperEvaluation] forKey:kModelTransportOrderIsShipperEvaluation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.transportQty] forKey:kModelTransportOrderTransportQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.priceUnit] forKey:kModelTransportOrderPriceUnit];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cargoTypeClass] forKey:kModelTransportOrderCargoTypeClass];
    [mutableDict setValue:self.startContacter forKey:kModelTransportOrderStartContacter];
    [mutableDict setValue:self.startCountyName forKey:kModelTransportOrderStartCountyName];
    [mutableDict setValue:self.startPhone forKey:kModelTransportOrderStartPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startProvinceId] forKey:kModelTransportOrderStartProvinceId];
    [mutableDict setValue:self.cargoName forKey:kModelTransportOrderCargoName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cargoWeight] forKey:kModelTransportOrderCargoWeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endProvinceId] forKey:kModelTransportOrderEndProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.unloadTime] forKey:kModelTransportOrderUnloadTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kModelTransportOrderDriverId];
    [mutableDict setValue:self.endCityName forKey:kModelTransportOrderEndCityName];
    [mutableDict setValue:self.endCountyName forKey:kModelTransportOrderEndCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleId] forKey:kModelTransportOrderVehicleId];
    [mutableDict setValue:self.startCityName forKey:kModelTransportOrderStartCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.finishTime] forKey:kModelTransportOrderFinishTime];
    [mutableDict setValue:self.channel forKey:kModelTransportOrderChannel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCityId] forKey:kModelTransportOrderEndCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderStatus] forKey:kModelTransportOrderOrderStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCountyId] forKey:kModelTransportOrderStartCountyId];
    [mutableDict setValue:self.endProvinceName forKey:kModelTransportOrderEndProvinceName];
    [mutableDict setValue:self.startCountyCode forKey:kModelTransportOrderStartCountyCode];
    [mutableDict setValue:self.planNumber forKey:kModelTransportOrderPlanNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shipperId] forKey:kModelTransportOrderShipperId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kModelTransportOrderStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shipperPrice] forKey:kModelTransportOrderShipperPrice];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.loadUrls] forKey:kModelTransportOrderLoadUrls];
    [mutableDict setValue:self.endAddr forKey:kModelTransportOrderEndAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDriverEvaluation] forKey:kModelTransportOrderIsDriverEvaluation];
    [mutableDict setValue:self.externalBatchNumber forKey:kModelTransportOrderExternalBatchNumber];
    [mutableDict setValue:self.driverName forKey:kModelTransportOrderDriverName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kModelTransportOrderEndTime];
    [mutableDict setValue:self.externalNumber forKey:kModelTransportOrderExternalNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCountyId] forKey:kModelTransportOrderEndCountyId];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.unloadUrls] forKey:kModelTransportOrderUnloadUrls];
    [mutableDict setValue:self.shipperName forKey:kModelTransportOrderShipperName];
    [mutableDict setValue:self.orderNumber forKey:kModelTransportOrderOrderNumber];
    [mutableDict setValue:self.endContacter forKey:kModelTransportOrderEndContacter];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loadTime] forKey:kModelTransportOrderLoadTime];
    [mutableDict setValue:self.startProvinceName forKey:kModelTransportOrderStartProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.unitPrice] forKey:kModelTransportOrderUnitPrice];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

+(NSString *)statusTransport:(double)state{
    switch ((int)state) {
        case 1:
            return @"待接单";
            break;
        case 2:
            return @"待装车";
            break;
        case 3:
            return @"已装车";
            break;
        case 4:
            return @"已到达";
            break;
        case 5:
            return @"已到达";
            break;
        case 9:
            return @"已完成";
            break;
        case 99:
            return @"已取消";
            break;
        default:
            break;
    }
    return @"已取消";
}

+(UIColor *)statusColorTransport:(double)state{
    switch ((int)state) {
        case 1:
            return COLOR_RED;
            break;
        case 2:
            return COLOR_ORANGE;
            break;
        case 3:
            return COLOR_ORANGE;
            break;
        case 4:
            return COLOR_GREEN;
            break;
        case 5:
            return COLOR_GREEN;
            break;
        case 9:
            return COLOR_GREEN;
            break;
        case 99:
            return COLOR_RED;
            break;
        default:
            break;
    }
    return COLOR_RED;
}
@end
