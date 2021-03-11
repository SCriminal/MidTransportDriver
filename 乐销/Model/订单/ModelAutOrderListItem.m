//
//  ModelAutOrderListItem.m
//
//  Created by 林栋 隋 on 2021/1/22
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelAutOrderListItem.h"
#import <MAMapKit/MAGeometry.h>
#import <AMapLocationKit/AMapLocationKit.h>

NSString *const kModelAutOrderListItemEndProvinceId = @"endProvinceId";
NSString *const kModelAutOrderListItemEndCityName = @"endCityName";
NSString *const kModelAutOrderListItemStartLng = @"startLng";
NSString *const kModelAutOrderListItemStartCityName = @"startCityName";
NSString *const kModelAutOrderListItemPriceUnit = @"priceUnit";
NSString *const kModelAutOrderListItemVehicleDescription = @"vehicleDescription";
NSString *const kModelAutOrderListItemStartLat = @"startLat";
NSString *const kModelAutOrderListItemEndCountyName = @"endCountyName";
NSString *const kModelAutOrderListItemPlanNumber = @"planNumber";
NSString *const kModelAutOrderListItemEndCityId = @"endCityId";
NSString *const kModelAutOrderListItemEndTime = @"endTime";
NSString *const kModelAutOrderListItemCargoName = @"cargoName";
NSString *const kModelAutOrderListItemStorageQty = @"storageQty";
NSString *const kModelAutOrderListItemEndCountyId = @"endCountyId";
NSString *const kModelAutOrderListItemEndLat = @"endLat";
NSString *const kModelAutOrderListItemDriverId = @"driverId";
NSString *const kModelAutOrderListItemEndLng = @"endLng";
NSString *const kModelAutOrderListItemEndProvinceName = @"endProvinceName";
NSString *const kModelAutOrderListItemQty = @"qty";
NSString *const kModelAutOrderListItemShipperId = @"shipperId";
NSString *const kModelAutOrderListItemStartCityId = @"startCityId";
NSString *const kModelAutOrderListItemStartCountyId = @"startCountyId";
NSString *const kModelAutOrderListItemStartCountyName = @"startCountyName";
NSString *const kModelAutOrderListItemStartProvinceId = @"startProvinceId";
NSString *const kModelAutOrderListItemStartProvinceName = @"startProvinceName";
NSString *const kModelAutOrderListItemUnitPrice = @"unitPrice";
NSString *const kModelAutOrderListItemCreateTime = @"createTime";
NSString *const kModelAutOrderListItemStartTime = @"startTime";
NSString *const kModelAutOrderListItemMode = @"mode";
NSString *const kModelAutOrderListItemDescription = @"description";
NSString *const kModelAutOrderListItemLengthMax = @"lengthMax";
NSString *const kModelAutOrderListItemLengthMin = @"lengthMin";
NSString *const kModelAutOrderListItemTransportQty = @"transportQty";
NSString *const kModelAutOrderListItemEndAddr = @"endAddr";
NSString *const kModelAutOrderListItemStartAddr = @"startAddr";
NSString *const kModelAutOrderListItemEndContacter = @"endContacter";
NSString *const kModelAutOrderListItemPlanStatus = @"planStatus";
NSString *const kModelAutOrderListItemStartContacter = @"startContacter";
NSString *const kModelAutOrderListItemEndPhone = @"endPhone";
NSString *const kModelAutOrderListItemStartPhone = @"startPhone";
NSString *const kModelAutOrderListItemOrderQty = @"orderQty";
NSString *const kModelAutOrderListItemMatchQty = @"matchQty";
NSString *const kModelAutOrderListItemUnitWeight = @"unitWeight";
NSString *const kModelAutOrderListItemLoadQty = @"loadQty";
NSString *const kModelAutOrderListItemReason = @"reason";
NSString *const kModelAutOrderListItemMatchStatus = @"matchStatus";
NSString *const kModelAutOrderListItemCellphone = @"cellphone";
NSString *const kModelAutOrderListItemMatchNumber = @"matchNumber";
NSString *const kModelAutOrderListItemPrice = @"price";
NSString *const kModelAutOrderListItemVehicleId = @"vehicleId";
NSString *const kModelAutOrderListItemPlateNumber = @"plateNumber";
NSString *const kModelAutOrderListItemReplyTime = @"replyTime";
NSString *const kModelAutOrderListItemMatchTime = @"matchTime";

@interface ModelAutOrderListItem ()
@end

@implementation ModelAutOrderListItem

@synthesize endProvinceId = _endProvinceId;
@synthesize endCityName = _endCityName;
@synthesize startLng = _startLng;
@synthesize startCityName = _startCityName;
@synthesize priceUnit = _priceUnit;
@synthesize vehicleDescription = _vehicleDescription;
@synthesize startLat = _startLat;
@synthesize endCountyName = _endCountyName;
@synthesize planNumber = _planNumber;
@synthesize endCityId = _endCityId;
@synthesize endTime = _endTime;
@synthesize cargoName = _cargoName;
@synthesize storageQty = _storageQty;
@synthesize endCountyId = _endCountyId;
@synthesize endLat = _endLat;
@synthesize driverId = _driverId;
@synthesize endLng = _endLng;
@synthesize endProvinceName = _endProvinceName;
@synthesize qty = _qty;
@synthesize shipperId = _shipperId;
@synthesize startCityId = _startCityId;
@synthesize startCountyId = _startCountyId;
@synthesize startCountyName = _startCountyName;
@synthesize startProvinceId = _startProvinceId;
@synthesize startProvinceName = _startProvinceName;
@synthesize unitPrice = _unitPrice;
@synthesize createTime = _createTime;
@synthesize startTime = _startTime;
@synthesize mode = _mode;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.endProvinceId = [dict doubleValueForKey:kModelAutOrderListItemEndProvinceId];
            self.endCityName = [dict stringValueForKey:kModelAutOrderListItemEndCityName];
            self.startLng = [dict doubleValueForKey:kModelAutOrderListItemStartLng];
            self.startCityName = [dict stringValueForKey:kModelAutOrderListItemStartCityName];
            self.priceUnit = [dict doubleValueForKey:kModelAutOrderListItemPriceUnit];
            self.vehicleDescription = [dict stringValueForKey:kModelAutOrderListItemVehicleDescription];
            self.startLat = [dict doubleValueForKey:kModelAutOrderListItemStartLat];
            self.endCountyName = [dict stringValueForKey:kModelAutOrderListItemEndCountyName];
            self.planNumber = [dict stringValueForKey:kModelAutOrderListItemPlanNumber];
            self.endCityId = [dict doubleValueForKey:kModelAutOrderListItemEndCityId];
            self.endTime = [dict doubleValueForKey:kModelAutOrderListItemEndTime];
            self.cargoName = [dict stringValueForKey:kModelAutOrderListItemCargoName];
            self.storageQty = [dict doubleValueForKey:kModelAutOrderListItemStorageQty];
            self.endCountyId = [dict doubleValueForKey:kModelAutOrderListItemEndCountyId];
            self.endLat = [dict doubleValueForKey:kModelAutOrderListItemEndLat];
            self.driverId = [dict doubleValueForKey:kModelAutOrderListItemDriverId];
            self.endLng = [dict doubleValueForKey:kModelAutOrderListItemEndLng];
            self.endProvinceName = [dict stringValueForKey:kModelAutOrderListItemEndProvinceName];
            self.qty = [dict doubleValueForKey:kModelAutOrderListItemQty];
            self.shipperId = [dict doubleValueForKey:kModelAutOrderListItemShipperId];
            self.startCityId = [dict doubleValueForKey:kModelAutOrderListItemStartCityId];
            self.startCountyId = [dict doubleValueForKey:kModelAutOrderListItemStartCountyId];
            self.startCountyName = [dict stringValueForKey:kModelAutOrderListItemStartCountyName];
            self.startProvinceId = [dict doubleValueForKey:kModelAutOrderListItemStartProvinceId];
            self.startProvinceName = [dict stringValueForKey:kModelAutOrderListItemStartProvinceName];
            self.unitPrice = [dict doubleValueForKey:kModelAutOrderListItemUnitPrice];
            self.createTime = [dict doubleValueForKey:kModelAutOrderListItemCreateTime];
            self.startTime = [dict doubleValueForKey:kModelAutOrderListItemStartTime];
            self.mode = [dict doubleValueForKey:kModelAutOrderListItemMode];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelAutOrderListItemDescription];
        self.matchQty = [dict doubleValueForKey:kModelAutOrderListItemMatchQty];
        self.unitWeight = [dict doubleValueForKey:kModelAutOrderListItemUnitWeight];
        self.lengthMax = [dict doubleValueForKey:kModelAutOrderListItemLengthMax];
        self.lengthMin = [dict doubleValueForKey:kModelAutOrderListItemLengthMin];
        self.transportQty = [dict doubleValueForKey:kModelAutOrderListItemTransportQty];
        self.endAddr = [dict stringValueForKey:kModelAutOrderListItemEndAddr];
        self.startAddr = [dict stringValueForKey:kModelAutOrderListItemStartAddr];
        self.endContacter = [dict stringValueForKey:kModelAutOrderListItemEndContacter];
        self.planStatus = [dict doubleValueForKey:kModelAutOrderListItemPlanStatus];
        self.startContacter = [dict stringValueForKey:kModelAutOrderListItemStartContacter];
        self.endPhone = [dict stringValueForKey:kModelAutOrderListItemEndPhone];
        self.startPhone = [dict stringValueForKey:kModelAutOrderListItemStartPhone];
        self.orderQty = [dict doubleValueForKey:kModelAutOrderListItemOrderQty];
        self.loadQty = [dict doubleValueForKey:kModelAutOrderListItemLoadQty];
        self.reason = [dict stringValueForKey:kModelAutOrderListItemReason];
        self.matchStatus = [dict doubleValueForKey:kModelAutOrderListItemMatchStatus];
        self.cellphone = [dict stringValueForKey:kModelAutOrderListItemCellphone];
        self.matchNumber = [dict stringValueForKey:kModelAutOrderListItemMatchNumber];
        self.price = [dict doubleValueForKey:kModelAutOrderListItemPrice];
        self.vehicleId = [dict doubleValueForKey:kModelAutOrderListItemVehicleId];
        self.plateNumber = [dict stringValueForKey:kModelAutOrderListItemPlateNumber];
        self.replyTime = [dict doubleValueForKey:kModelAutOrderListItemReplyTime];
        self.matchTime = [dict doubleValueForKey:kModelAutOrderListItemMatchTime];

        
        //logical
        self.dateStart = [GlobalMethod exchangeTimeStampToDate:self.startTime];
        self.priceShow = [NSNumber bigDecimal:self.unitPrice divide:100.0];
        self.qtyShow = [self exchangeQtyShow:self.qty];
        self.remainShow = [self exchangeQtyShow:self.storageQty];

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
                break;
            case 5:
                self.unitShow = @"立方米";
                break;
            default:
                break;
        }
        
        ModelAddress * mLocation = [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
        if (mLocation.lat && mLocation.lng && self.startLat && self.startLng) {
            MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(mLocation.lat,mLocation.lng));
            MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.startLat,self.startLng));
            //2.计算距离
            CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
            self.distanceShow = [self resetDistance:distance];
        }else{
            self.distanceShow = nil;
        }
        if (self.lengthMin || self.lengthMax) {
            self.carLenthSHow = [NSString stringWithFormat:@"%@-%@米",[NSNumber bigDecimal:self.lengthMin divide:1000.0] ,[NSNumber bigDecimal:self.lengthMax divide:1000.0]];
        }else{
            self.carLenthSHow = nil;
        }
        
    }
    
    return self;
    
}
+ (NSString *)matchStatusExchange:(double)status{
    switch ((int)status) {//1匹配中/2已同意/11已拒绝/21已过期
        case 1:
            return @"匹配中";
            break;
        case 2:
            return @"已确认";
            break;
        case 11:
            return @"已拒绝";
            break;
        case 21:
            return @"已过期";
            break;
        case 99:
            return @"已取消";
            break;
        default:
            break;
    }
    return @"已过期";
}
+ (UIColor *)matchStatusColorExchange:(double)status{
    switch ((int)status) {//1匹配中/2已同意/11已拒绝/21已过期
        case 1:
            return COLOR_ORANGE;
            break;
        case 2:
            return COLOR_GREEN;
            break;
        case 11:
            return COLOR_RED;
            break;
        case 21:
            return COLOR_RED;
            break;
        case 99:
            return COLOR_RED;
            break;
        default:
            break;
    }
    return COLOR_RED;
}
- (double)exchangeRequestQty:(double)qty{
    switch ((int)self.priceUnit) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            qty = qty *1000.0;
            break;
        case 5:
            qty = qty *1000000000.0;

            break;
        default:
            break;
    }
    return  qty;
}

- (NSString *)exchangeQtyShow:(double)qty{
    NSString * strReturn = NSNumber.dou(qty).stringValue;
    switch ((int)self.priceUnit) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            strReturn = [NSNumber bigDecimal:qty divide:1000.0];
            break;
        case 5:
            strReturn = [NSNumber bigDecimal:qty divide:1000000000.0];
            break;
        default:
            break;
    }
    return  strReturn;
}

- (NSString *)resetDistance:(CGFloat)meter{
    return [NSString stringWithFormat:@"%.2fkm",meter/1000.0];

}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endProvinceId] forKey:kModelAutOrderListItemEndProvinceId];
    [mutableDict setValue:self.endCityName forKey:kModelAutOrderListItemEndCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startLng] forKey:kModelAutOrderListItemStartLng];
    [mutableDict setValue:self.startCityName forKey:kModelAutOrderListItemStartCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.priceUnit] forKey:kModelAutOrderListItemPriceUnit];
    [mutableDict setValue:self.vehicleDescription forKey:kModelAutOrderListItemVehicleDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startLat] forKey:kModelAutOrderListItemStartLat];
    [mutableDict setValue:self.endCountyName forKey:kModelAutOrderListItemEndCountyName];
    [mutableDict setValue:self.planNumber forKey:kModelAutOrderListItemPlanNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCityId] forKey:kModelAutOrderListItemEndCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kModelAutOrderListItemEndTime];
    [mutableDict setValue:self.cargoName forKey:kModelAutOrderListItemCargoName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.storageQty] forKey:kModelAutOrderListItemStorageQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCountyId] forKey:kModelAutOrderListItemEndCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endLat] forKey:kModelAutOrderListItemEndLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kModelAutOrderListItemDriverId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endLng] forKey:kModelAutOrderListItemEndLng];
    [mutableDict setValue:self.endProvinceName forKey:kModelAutOrderListItemEndProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qty] forKey:kModelAutOrderListItemQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shipperId] forKey:kModelAutOrderListItemShipperId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCityId] forKey:kModelAutOrderListItemStartCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCountyId] forKey:kModelAutOrderListItemStartCountyId];
    [mutableDict setValue:self.startCountyName forKey:kModelAutOrderListItemStartCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startProvinceId] forKey:kModelAutOrderListItemStartProvinceId];
    [mutableDict setValue:self.startProvinceName forKey:kModelAutOrderListItemStartProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.unitPrice] forKey:kModelAutOrderListItemUnitPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelAutOrderListItemCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kModelAutOrderListItemStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mode] forKey:kModelAutOrderListItemMode];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelAutOrderListItemDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.matchQty] forKey:kModelAutOrderListItemMatchQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.unitWeight] forKey:kModelAutOrderListItemUnitWeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lengthMax] forKey:kModelAutOrderListItemLengthMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lengthMin] forKey:kModelAutOrderListItemLengthMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.transportQty] forKey:kModelAutOrderListItemTransportQty];
    [mutableDict setValue:self.endAddr forKey:kModelAutOrderListItemEndAddr];
    [mutableDict setValue:self.startAddr forKey:kModelAutOrderListItemStartAddr];
    [mutableDict setValue:self.endContacter forKey:kModelAutOrderListItemEndContacter];
    [mutableDict setValue:[NSNumber numberWithDouble:self.planStatus] forKey:kModelAutOrderListItemPlanStatus];
    [mutableDict setValue:self.startContacter forKey:kModelAutOrderListItemStartContacter];
    [mutableDict setValue:self.endPhone forKey:kModelAutOrderListItemEndPhone];
    [mutableDict setValue:self.startPhone forKey:kModelAutOrderListItemStartPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderQty] forKey:kModelAutOrderListItemOrderQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loadQty] forKey:kModelAutOrderListItemLoadQty];
    [mutableDict setValue:self.reason forKey:kModelAutOrderListItemReason];
    [mutableDict setValue:[NSNumber numberWithDouble:self.matchStatus] forKey:kModelAutOrderListItemMatchStatus];
    [mutableDict setValue:self.cellphone forKey:kModelAutOrderListItemCellphone];
    [mutableDict setValue:self.matchNumber forKey:kModelAutOrderListItemMatchNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelAutOrderListItemPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleId] forKey:kModelAutOrderListItemVehicleId];
    [mutableDict setValue:self.plateNumber forKey:kModelAutOrderListItemPlateNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyTime] forKey:kModelAutOrderListItemReplyTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.matchTime] forKey:kModelAutOrderListItemMatchTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
