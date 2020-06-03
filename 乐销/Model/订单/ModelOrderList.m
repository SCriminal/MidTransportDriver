//
//  ModelOrderList.m
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelOrderList.h"


NSString *const kModelOrderListEndCyName = @"endCyName";
NSString *const kModelOrderListPlaceDetailAddr = @"placeDetailAddr";
NSString *const kModelOrderListStartCyId = @"startCyId";
NSString *const kModelOrderListId = @"id";
NSString *const kModelOrderListStartCardAddr = @"startCardAddr";
NSString *const kModelOrderListPlacePhone = @"placePhone";
NSString *const kModelOrderListToFactoryTime = @"toFactoryTime";
NSString *const kModelOrderListState = @"state";
NSString *const kModelOrderListEndCyId = @"endCyId";
NSString *const kModelOrderListStartContact = @"startContact";
NSString *const kModelOrderListEndPhone = @"endPhone";
NSString *const kModelOrderListCategoryId = @"categoryId";
NSString *const kModelOrderListAcceptTime = @"acceptTime";
NSString *const kModelOrderListStartCardPhone = @"startCardPhone";
NSString *const kModelOrderListTruckNumber = @"truckNumber";
NSString *const kModelOrderListEndContact = @"endContact";
NSString *const kModelOrderListPlaceEnvName = @"placeEnvName";
NSString *const kModelOrderListDescription = @"description";
NSString *const kModelOrderListPlaceTownName = @"placeTownName";
NSString *const kModelOrderListPlaceCityId = @"placeCityId";
NSString *const kModelOrderListSrc = @"src";
NSString *const kModelOrderListStartPhone = @"startPhone";
NSString *const kModelOrderListVoyageNumber = @"voyageNumber";
NSString *const kModelOrderListStartProvinceId = @"startProvinceId";
NSString *const kModelOrderListPrice = @"price";
NSString *const kModelOrderListAfterSaleFormId = @"afterSaleFormId";
NSString *const kModelOrderListEndProvinceId = @"endProvinceId";
NSString *const kModelOrderListEndAreaId = @"endAreaId";
NSString *const kModelOrderListStartAreaId = @"startAreaId";
NSString *const kModelOrderListClosingTime = @"closingTime";
NSString *const kModelOrderListPlaceContact = @"placeContact";
NSString *const kModelOrderListPlaceTime = @"placeTime";
NSString *const kModelOrderListFinishTime = @"finishTime";
NSString *const kModelOrderListTotal = @"total";
NSString *const kModelOrderListDriverPhone = @"driverPhone";
NSString *const kModelOrderListPlaceCountyName = @"placeCountyName";
NSString *const kModelOrderListCarrierName = @"carrierName";
NSString *const kModelOrderListStuffTime = @"stuffTime";
NSString *const kModelOrderListPlaceProvinceId = @"placeProvinceId";
NSString *const kModelOrderListShippingLineName = @"shippingLineName";
NSString *const kModelOrderListEndPortId = @"endPortId";
NSString *const kModelOrderListEndProvinceName = @"endProvinceName";
NSString *const kModelOrderListEndPortName = @"endPortName";
NSString *const kModelOrderListReason = @"reason";
NSString *const kModelOrderListWaybillNumber = @"waybillNumber";
NSString *const kModelOrderListOceanVessel = @"oceanVessel";
NSString *const kModelOrderListShipperId = @"shipperId";
NSString *const kModelOrderListPlaceCityName = @"placeCityName";
NSString *const kModelOrderListBlNumber = @"blNumber";
NSString *const kModelOrderListEndAreaName = @"endAreaName";
NSString *const kModelOrderListStartAreaName = @"startAreaName";
NSString *const kModelOrderListStartPortId = @"startPortId";
NSString *const kModelOrderListPlaceCountyId = @"placeCountyId";
NSString *const kModelOrderListHandleTime = @"handleTime";
NSString *const kModelOrderListCarrierId = @"carrierId";
NSString *const kModelOrderListShipperName = @"shipperName";
NSString *const kModelOrderListCreateTime = @"createTime";
NSString *const kModelOrderListStartCyName = @"startCyName";
NSString *const kModelOrderListPlaceTownId = @"placeTownId";
NSString *const kModelOrderListPlaceProvinceName = @"placeProvinceName";
NSString *const kModelOrderListStartPortName = @"startPortName";
NSString *const kModelOrderListTruckId = @"truckId";
NSString *const kModelOrderListStartProvinceName = @"startProvinceName";
NSString *const kModelOrderListStartCardContact = @"startCardContact";
NSString *const kModelOrderListShipperPhone = @"shipperPhone";
NSString *const kModelOrderListKey = @"key";


@interface ModelOrderList ()
@end

@implementation ModelOrderList

@synthesize endCyName = _endCyName;
@synthesize placeDetailAddr = _placeDetailAddr;
@synthesize startCyId = _startCyId;
@synthesize iDProperty = _iDProperty;
@synthesize startCardAddr = _startCardAddr;
@synthesize placePhone = _placePhone;
@synthesize toFactoryTime = _toFactoryTime;
@synthesize state = _state;
@synthesize endCyId = _endCyId;
@synthesize startContact = _startContact;
@synthesize endPhone = _endPhone;
@synthesize categoryId = _categoryId;
@synthesize acceptTime = _acceptTime;
@synthesize startCardPhone = _startCardPhone;
@synthesize truckNumber = _truckNumber;
@synthesize endContact = _endContact;
@synthesize placeEnvName = _placeEnvName;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize placeTownName = _placeTownName;
@synthesize placeCityId = _placeCityId;
@synthesize src = _src;
@synthesize startPhone = _startPhone;
@synthesize voyageNumber = _voyageNumber;
@synthesize startProvinceId = _startProvinceId;
@synthesize price = _price;
@synthesize afterSaleFormId = _afterSaleFormId;
@synthesize endProvinceId = _endProvinceId;
@synthesize endAreaId = _endAreaId;
@synthesize startAreaId = _startAreaId;
@synthesize closingTime = _closingTime;
@synthesize placeContact = _placeContact;
@synthesize placeTime = _placeTime;
@synthesize finishTime = _finishTime;
@synthesize total = _total;
@synthesize driverPhone = _driverPhone;
@synthesize placeCountyName = _placeCountyName;
@synthesize carrierName = _carrierName;
@synthesize stuffTime = _stuffTime;
@synthesize placeProvinceId = _placeProvinceId;
@synthesize shippingLineName = _shippingLineName;
@synthesize endPortId = _endPortId;
@synthesize endProvinceName = _endProvinceName;
@synthesize endPortName = _endPortName;
@synthesize reason = _reason;
@synthesize waybillNumber = _waybillNumber;
@synthesize oceanVessel = _oceanVessel;
@synthesize shipperId = _shipperId;
@synthesize placeCityName = _placeCityName;
@synthesize blNumber = _blNumber;
@synthesize endAreaName = _endAreaName;
@synthesize startAreaName = _startAreaName;
@synthesize startPortId = _startPortId;
@synthesize placeCountyId = _placeCountyId;
@synthesize handleTime = _handleTime;
@synthesize carrierId = _carrierId;
@synthesize shipperName = _shipperName;
@synthesize createTime = _createTime;
@synthesize startCyName = _startCyName;
@synthesize placeTownId = _placeTownId;
@synthesize placeProvinceName = _placeProvinceName;
@synthesize startPortName = _startPortName;
@synthesize truckId = _truckId;
@synthesize startProvinceName = _startProvinceName;
@synthesize startCardContact = _startCardContact;

#pragma mark logical
- (ENUM_ORDER_TYPE)orderType{
    return [ModelOrderList transformOrderType:self.categoryId];
}
- (NSString *)loadAddressShow{
    return [NSString stringWithFormat:@"%@%@%@ %@",UnPackStr(self.placeProvinceName),[self.placeCityName isEqualToString:self.placeProvinceName]?@"":UnPackStr(self.placeCityName),UnPackStr(self.placeCountyName),UnPackStr(self.placeDetailAddr)];
}
-(NSString *)backPackageAddressShow{
    return [NSString stringWithFormat:@"%@%@%@ %@",UnPackStr(self.startProvinceName),[self.startPortName isEqualToString:self.startProvinceName]?@"":UnPackStr(self.startPortName),UnPackStr(self.startAreaName),UnPackStr(self.startCyName)];
}
-(NSString *)returnPackageAddressShow{
    return [NSString stringWithFormat:@"%@%@%@ %@",UnPackStr(self.endProvinceName),[self.endPortName isEqualToString:self.endProvinceName]?@"":UnPackStr(self.endPortName),UnPackStr(self.endAreaName),UnPackStr(self.endCyName)];
}
-(NSString *)orderStatusShow{
    return [ModelOrderList transformOrderStatusToName:self.state orderType:self.orderType];
}

+ (NSString *)transformOrderStatusToName:(int)state orderType:(ENUM_ORDER_TYPE)orderType{
    switch ((int)state) {
        case 601:
            return @"待接单";
            break;
        case 602:
            return @"待提箱";
            break;
        case 603:
            return @"已提箱";
            break;
        case 604:
            return orderType==ENUM_ORDER_TYPE_INPUT?@"待卸货":@"待装货";//
            break;
        case 605:
            return @"待还箱";
            break;
        case 610:
            return @"已还箱";
        default:
            break;
    }
    return @"";
}
- (UIColor *)colorStateShow{
    switch (self.operateType) {
        case ENUM_ORDER_OPERATE_WAIT_RECEIVE:
            return COLOR_BLUE;
            break;
        case ENUM_ORDER_OPERATE_COMPLETE:
            return COLOR_GREEN;
            break;
        default:
            break;
    }
    return COLOR_RED;
}
+ (NSString *)transformOrderStatusToCompleteName:(int)state orderType:(ENUM_ORDER_TYPE)orderType{
    switch ((int)state) {
        case 601:
            return @"派单";
            break;
        case 602:
            return @"接单";
            break;
        case 603:
            return @"提箱";
            break;
        case 604:
            return @"到厂";//
            break;
        case 605:
            return orderType==ENUM_ORDER_TYPE_INPUT?@"卸货":@"装货";
            break;
        case 610:
            return @"还箱";
        default:
            break;
    }
    return @"";
}
+ (ENUM_ORDER_TYPE)transformOrderType:(int)type{
    if (type == 11) {//11-进口 12-出口
        return ENUM_ORDER_TYPE_INPUT;
    }else if(type == 12){
        return ENUM_ORDER_TYPE_OUTPUT;
    }
    return ENUM_ORDER_TYPE_ERROR;
}
+ (ENUM_ORDER_OPERATE_TYPE)transformOrderOperateType:(int)status{
    switch (status) {
        case 601:
            return ENUM_ORDER_OPERATE_WAIT_RECEIVE;
            break;
        case 602:
            return ENUM_ORDER_OPERATE_BACK_PACKAGE;
            break;
        case 603:
            return ENUM_ORDER_OPERATE_ARRIVE_FACTORY;
            break;
        case 604:
            return ENUM_ORDER_OPERATE_LOAD_COMPLETE;
            break;
        case 605:
            return ENUM_ORDER_OPERATE_RETURN_PACKAGE;
            break;
            
        default:
            break;
    }
    return ENUM_ORDER_OPERATE_COMPLETE;
}

- (ENUM_ORDER_OPERATE_TYPE)operateType{
    return [ModelOrderList transformOrderOperateType:self.state];
}

- (void)configClosingTimeShow{
    NSDate * date = [GlobalMethod exchangeTimeStampToDate:self.closingTime];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        self.closingTimeShow = [NSString stringWithFormat:@"今天 %@",[GlobalMethod exchangeDate:date formatter:@"HH:mm"]];
    } else if ([dateString isEqualToString:tomorrowString])
    {
        self.closingTimeShow = [NSString stringWithFormat:@"明天 %@",[GlobalMethod exchangeDate:date formatter:@"HH:mm"]];
    }else{
        self.closingTimeShow = [GlobalMethod exchangeTimeWithStamp:self.closingTime andFormatter:@"yyyy/MM/dd HH:mm"];
    }
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
            self.endCyName = [dict stringValueForKey:kModelOrderListEndCyName];
            self.placeDetailAddr = [dict stringValueForKey:kModelOrderListPlaceDetailAddr];
            self.startCyId = [dict doubleValueForKey:kModelOrderListStartCyId];
            self.iDProperty = [dict doubleValueForKey:kModelOrderListId];
            self.startCardAddr = [dict stringValueForKey:kModelOrderListStartCardAddr];
            self.placePhone = [dict stringValueForKey:kModelOrderListPlacePhone];
            self.toFactoryTime = [dict doubleValueForKey:kModelOrderListToFactoryTime];
            self.state = [dict doubleValueForKey:kModelOrderListState];
            self.endCyId = [dict doubleValueForKey:kModelOrderListEndCyId];
            self.startContact = [dict stringValueForKey:kModelOrderListStartContact];
            self.endPhone = [dict stringValueForKey:kModelOrderListEndPhone];
            self.categoryId = [dict doubleValueForKey:kModelOrderListCategoryId];
            self.acceptTime = [dict doubleValueForKey:kModelOrderListAcceptTime];
            self.startCardPhone = [dict stringValueForKey:kModelOrderListStartCardPhone];
            self.truckNumber = [dict stringValueForKey:kModelOrderListTruckNumber];
            self.endContact = [dict stringValueForKey:kModelOrderListEndContact];
            self.placeEnvName = [dict stringValueForKey:kModelOrderListPlaceEnvName];
            self.iDPropertyDescription = [dict stringValueForKey:kModelOrderListDescription];
            self.placeTownName = [dict stringValueForKey:kModelOrderListPlaceTownName];
            self.placeCityId = [dict doubleValueForKey:kModelOrderListPlaceCityId];
            self.src = [dict doubleValueForKey:kModelOrderListSrc];
            self.startPhone = [dict stringValueForKey:kModelOrderListStartPhone];
            self.voyageNumber = [dict stringValueForKey:kModelOrderListVoyageNumber];
            self.startProvinceId = [dict doubleValueForKey:kModelOrderListStartProvinceId];
            self.price = [dict doubleValueForKey:kModelOrderListPrice];
            self.afterSaleFormId = [dict doubleValueForKey:kModelOrderListAfterSaleFormId];
            self.endProvinceId = [dict doubleValueForKey:kModelOrderListEndProvinceId];
            self.endAreaId = [dict doubleValueForKey:kModelOrderListEndAreaId];
            self.startAreaId = [dict doubleValueForKey:kModelOrderListStartAreaId];
            self.closingTime = [dict doubleValueForKey:kModelOrderListClosingTime];
            self.placeContact = [dict stringValueForKey:kModelOrderListPlaceContact];
            self.placeTime = [dict doubleValueForKey:kModelOrderListPlaceTime];
            self.finishTime = [dict doubleValueForKey:kModelOrderListFinishTime];
            self.total = [dict doubleValueForKey:kModelOrderListTotal];
            self.driverPhone = [dict stringValueForKey:kModelOrderListDriverPhone];
            self.placeCountyName = [dict stringValueForKey:kModelOrderListPlaceCountyName];
            self.carrierName = [dict stringValueForKey:kModelOrderListCarrierName];
            self.stuffTime = [dict doubleValueForKey:kModelOrderListStuffTime];
            self.placeProvinceId = [dict doubleValueForKey:kModelOrderListPlaceProvinceId];
            self.shippingLineName = [dict stringValueForKey:kModelOrderListShippingLineName];
            self.endPortId = [dict doubleValueForKey:kModelOrderListEndPortId];
            self.endProvinceName = [dict stringValueForKey:kModelOrderListEndProvinceName];
            self.endPortName = [dict stringValueForKey:kModelOrderListEndPortName];
            self.reason = [dict stringValueForKey:kModelOrderListReason];
            self.waybillNumber = [dict stringValueForKey:kModelOrderListWaybillNumber];
            self.oceanVessel = [dict stringValueForKey:kModelOrderListOceanVessel];
            self.shipperId = [dict doubleValueForKey:kModelOrderListShipperId];
            self.placeCityName = [dict stringValueForKey:kModelOrderListPlaceCityName];
            self.blNumber = [dict stringValueForKey:kModelOrderListBlNumber];
            self.endAreaName = [dict stringValueForKey:kModelOrderListEndAreaName];
            self.startAreaName = [dict stringValueForKey:kModelOrderListStartAreaName];
            self.startPortId = [dict doubleValueForKey:kModelOrderListStartPortId];
            self.placeCountyId = [dict doubleValueForKey:kModelOrderListPlaceCountyId];
            self.handleTime = [dict doubleValueForKey:kModelOrderListHandleTime];
            self.carrierId = [dict doubleValueForKey:kModelOrderListCarrierId];
            self.shipperName = [dict stringValueForKey:kModelOrderListShipperName];
            self.createTime = [dict doubleValueForKey:kModelOrderListCreateTime];
            self.startCyName = [dict stringValueForKey:kModelOrderListStartCyName];
            self.placeTownId = [dict doubleValueForKey:kModelOrderListPlaceTownId];
            self.placeProvinceName = [dict stringValueForKey:kModelOrderListPlaceProvinceName];
            self.startPortName = [dict stringValueForKey:kModelOrderListStartPortName];
            self.truckId = [dict doubleValueForKey:kModelOrderListTruckId];
            self.startProvinceName = [dict stringValueForKey:kModelOrderListStartProvinceName];
            self.startCardContact = [dict stringValueForKey:kModelOrderListStartCardContact];
        self.shipperPhone = [dict stringValueForKey:kModelOrderListShipperPhone];
        self.key = [dict stringValueForKey:kModelOrderListKey];

        [self configClosingTimeShow];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.endCyName forKey:kModelOrderListEndCyName];
    [mutableDict setValue:self.placeDetailAddr forKey:kModelOrderListPlaceDetailAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCyId] forKey:kModelOrderListStartCyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelOrderListId];
    [mutableDict setValue:self.startCardAddr forKey:kModelOrderListStartCardAddr];
    [mutableDict setValue:self.placePhone forKey:kModelOrderListPlacePhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.toFactoryTime] forKey:kModelOrderListToFactoryTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelOrderListState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCyId] forKey:kModelOrderListEndCyId];
    [mutableDict setValue:self.startContact forKey:kModelOrderListStartContact];
    [mutableDict setValue:self.endPhone forKey:kModelOrderListEndPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelOrderListCategoryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acceptTime] forKey:kModelOrderListAcceptTime];
    [mutableDict setValue:self.startCardPhone forKey:kModelOrderListStartCardPhone];
    [mutableDict setValue:self.truckNumber forKey:kModelOrderListTruckNumber];
    [mutableDict setValue:self.endContact forKey:kModelOrderListEndContact];
    [mutableDict setValue:self.placeEnvName forKey:kModelOrderListPlaceEnvName];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelOrderListDescription];
    [mutableDict setValue:self.placeTownName forKey:kModelOrderListPlaceTownName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.placeCityId] forKey:kModelOrderListPlaceCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.src] forKey:kModelOrderListSrc];
    [mutableDict setValue:self.startPhone forKey:kModelOrderListStartPhone];
    [mutableDict setValue:self.voyageNumber forKey:kModelOrderListVoyageNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startProvinceId] forKey:kModelOrderListStartProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelOrderListPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.afterSaleFormId] forKey:kModelOrderListAfterSaleFormId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endProvinceId] forKey:kModelOrderListEndProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endAreaId] forKey:kModelOrderListEndAreaId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startAreaId] forKey:kModelOrderListStartAreaId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.closingTime] forKey:kModelOrderListClosingTime];
    [mutableDict setValue:self.placeContact forKey:kModelOrderListPlaceContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.placeTime] forKey:kModelOrderListPlaceTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.finishTime] forKey:kModelOrderListFinishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kModelOrderListTotal];
    [mutableDict setValue:self.driverPhone forKey:kModelOrderListDriverPhone];
    [mutableDict setValue:self.placeCountyName forKey:kModelOrderListPlaceCountyName];
    [mutableDict setValue:self.carrierName forKey:kModelOrderListCarrierName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stuffTime] forKey:kModelOrderListStuffTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.placeProvinceId] forKey:kModelOrderListPlaceProvinceId];
    [mutableDict setValue:self.shippingLineName forKey:kModelOrderListShippingLineName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endPortId] forKey:kModelOrderListEndPortId];
    [mutableDict setValue:self.endProvinceName forKey:kModelOrderListEndProvinceName];
    [mutableDict setValue:self.endPortName forKey:kModelOrderListEndPortName];
    [mutableDict setValue:self.reason forKey:kModelOrderListReason];
    [mutableDict setValue:self.waybillNumber forKey:kModelOrderListWaybillNumber];
    [mutableDict setValue:self.oceanVessel forKey:kModelOrderListOceanVessel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shipperId] forKey:kModelOrderListShipperId];
    [mutableDict setValue:self.placeCityName forKey:kModelOrderListPlaceCityName];
    [mutableDict setValue:self.blNumber forKey:kModelOrderListBlNumber];
    [mutableDict setValue:self.endAreaName forKey:kModelOrderListEndAreaName];
    [mutableDict setValue:self.startAreaName forKey:kModelOrderListStartAreaName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startPortId] forKey:kModelOrderListStartPortId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.placeCountyId] forKey:kModelOrderListPlaceCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handleTime] forKey:kModelOrderListHandleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carrierId] forKey:kModelOrderListCarrierId];
    [mutableDict setValue:self.shipperName forKey:kModelOrderListShipperName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelOrderListCreateTime];
    [mutableDict setValue:self.startCyName forKey:kModelOrderListStartCyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.placeTownId] forKey:kModelOrderListPlaceTownId];
    [mutableDict setValue:self.placeProvinceName forKey:kModelOrderListPlaceProvinceName];
    [mutableDict setValue:self.startPortName forKey:kModelOrderListStartPortName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.truckId] forKey:kModelOrderListTruckId];
    [mutableDict setValue:self.startProvinceName forKey:kModelOrderListStartProvinceName];
    [mutableDict setValue:self.startCardContact forKey:kModelOrderListStartCardContact];
    [mutableDict setValue:self.shipperPhone forKey:kModelOrderListShipperPhone];
    [mutableDict setValue:self.key forKey:kModelOrderListKey];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
