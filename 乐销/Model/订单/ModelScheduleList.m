//
//  ModelScheduleList.m
//
//  Created by 林栋 隋 on 2019/11/25
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelScheduleList.h"


NSString *const kModelScheduleListEndCountyId = @"endCountyId";
NSString *const kModelScheduleListId = @"id";
NSString *const kModelScheduleListPlanId = @"planId";
NSString *const kModelScheduleListEntName = @"entName";
NSString *const kModelScheduleListEndProvinceId = @"endProvinceId";
NSString *const kModelScheduleListStartCityName = @"startCityName";
NSString *const kModelScheduleListStartCountyId = @"startCountyId";
NSString *const kModelScheduleListStartCityId = @"startCityId";
NSString *const kModelScheduleListTempState = @"tempState";
NSString *const kModelScheduleListCloseTime = @"closeTime";
NSString *const kModelScheduleListStartTownId = @"startTownId";
NSString *const kModelScheduleListStartContact = @"startContact";
NSString *const kModelScheduleListPlanNumber = @"planNumber";
NSString *const kModelScheduleListVehicleLength = @"vehicleLength";
NSString *const kModelScheduleListVehicleId = @"vehicleId";
NSString *const kModelScheduleListEndAddr = @"endAddr";
NSString *const kModelScheduleListEndLng = @"endLng";
NSString *const kModelScheduleListStartLat = @"startLat";
NSString *const kModelScheduleListEndTownId = @"endTownId";
NSString *const kModelScheduleListStartCountyName = @"startCountyName";
NSString *const kModelScheduleListStartPhone = @"startPhone";
NSString *const kModelScheduleListDriverName = @"driverName";
NSString *const kModelScheduleListEndEntName = @"endEntName";
NSString *const kModelScheduleListEndProvinceName = @"endProvinceName";
NSString *const kModelScheduleListVehicleNumber = @"vehicleNumber";
NSString *const kModelScheduleListCargoName = @"cargoName";
NSString *const kModelScheduleListEndLat = @"endLat";
NSString *const kModelScheduleListStartProvinceName = @"startProvinceName";
NSString *const kModelScheduleListLoadUnit = @"loadUnit";
NSString *const kModelScheduleListVehicleType = @"vehicleType";
NSString *const kModelScheduleListPrice = @"price";
NSString *const kModelScheduleListEndCityName = @"endCityName";
NSString *const kModelScheduleListEntId = @"entId";
NSString *const kModelScheduleListStartProvinceId = @"startProvinceId";
NSString *const kModelScheduleListEndContact = @"endContact";
NSString *const kModelScheduleListEndTownName = @"endTownName";
NSString *const kModelScheduleListReviewTime = @"reviewTime";
NSString *const kModelScheduleListDriverId = @"driverId";
NSString *const kModelScheduleListStartLng = @"startLng";
NSString *const kModelScheduleListStartTownName = @"startTownName";
NSString *const kModelScheduleListWaybillId = @"waybillId";
NSString *const kModelScheduleListEndCityId = @"endCityId";
NSString *const kModelScheduleListEndCountyName = @"endCountyName";
NSString *const kModelScheduleListActualLoad = @"actualLoad";
NSString *const kModelScheduleListFleetId = @"fleetId";
NSString *const kModelScheduleListDriverPhone = @"driverPhone";
NSString *const kModelScheduleListEndPhone = @"endPhone";
NSString *const kModelScheduleListStartAddr = @"startAddr";
NSString *const kModelScheduleListWaybillNumber = @"waybillNumber";
NSString *const kModelScheduleListScanTime = @"scanTime";
NSString *const kModelScheduleListStandardLoad = @"standardLoad";



@interface ModelScheduleList ()
@end

@implementation ModelScheduleList

@synthesize endCountyId = _endCountyId;
@synthesize iDProperty = _iDProperty;
@synthesize planId = _planId;
@synthesize entName = _entName;
@synthesize endProvinceId = _endProvinceId;
@synthesize startCityName = _startCityName;
@synthesize startCountyId = _startCountyId;
@synthesize startCityId = _startCityId;
@synthesize tempState = _tempState;
@synthesize closeTime = _closeTime;
@synthesize startTownId = _startTownId;
@synthesize startContact = _startContact;
@synthesize planNumber = _planNumber;
@synthesize vehicleLength = _vehicleLength;
@synthesize vehicleId = _vehicleId;
@synthesize endAddr = _endAddr;
@synthesize endLng = _endLng;
@synthesize startLat = _startLat;
@synthesize endTownId = _endTownId;
@synthesize startCountyName = _startCountyName;
@synthesize startPhone = _startPhone;
@synthesize driverName = _driverName;
@synthesize endEntName = _endEntName;
@synthesize endProvinceName = _endProvinceName;
@synthesize vehicleNumber = _vehicleNumber;
@synthesize cargoName = _cargoName;
@synthesize endLat = _endLat;
@synthesize startProvinceName = _startProvinceName;
@synthesize loadUnit = _loadUnit;
@synthesize vehicleType = _vehicleType;
@synthesize price = _price;
@synthesize endCityName = _endCityName;
@synthesize entId = _entId;
@synthesize startProvinceId = _startProvinceId;
@synthesize endContact = _endContact;
@synthesize endTownName = _endTownName;
@synthesize reviewTime = _reviewTime;
@synthesize driverId = _driverId;
@synthesize startLng = _startLng;
@synthesize startTownName = _startTownName;
@synthesize waybillId = _waybillId;
@synthesize endCityId = _endCityId;
@synthesize endCountyName = _endCountyName;
@synthesize actualLoad = _actualLoad;
@synthesize fleetId = _fleetId;
@synthesize driverPhone = _driverPhone;
@synthesize endPhone = _endPhone;
@synthesize startAddr = _startAddr;
@synthesize waybillNumber = _waybillNumber;
@synthesize scanTime = _scanTime;
@synthesize standardLoad = _standardLoad;

#pragma mark logical
- (NSString *)scheduleStatusShow{
    switch ((int)self.tempState) {
        case 1:
            return @"待确认";
            break;
        case 21:
            return @"已驳回";
            break;
        case 99:
            return @"已确认";
            break;
        default:
            break;
    }
    return @"";
}
- (UIColor *)colorStateShow{
    switch ((int)self.tempState) {
        case 1:
            return COLOR_ORANGE;
            break;
        case 21:
            return [UIColor redColor];
            break;
        case 99:
            return COLOR_GREEN;
            break;
        default:
            break;
    }
    return COLOR_333;
}
- (NSString *)addressFromShow{
    return [NSString stringWithFormat:@"%@%@",UnPackStr(self.startProvinceName),[self.startProvinceName isEqualToString:self.startCityName]?@"":UnPackStr(self.startCityName)];
}
- (NSString *)addressToShow{
    return [NSString stringWithFormat:@"%@%@",UnPackStr(self.endProvinceName),[self.endProvinceName isEqualToString:self.endCityName]?@"":UnPackStr(self.endCityName)];
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
            self.endCountyId = [dict doubleValueForKey:kModelScheduleListEndCountyId];
            self.iDProperty = [dict doubleValueForKey:kModelScheduleListId];
            self.planId = [dict doubleValueForKey:kModelScheduleListPlanId];
            self.entName = [dict stringValueForKey:kModelScheduleListEntName];
            self.endProvinceId = [dict doubleValueForKey:kModelScheduleListEndProvinceId];
            self.startCityName = [dict stringValueForKey:kModelScheduleListStartCityName];
            self.startCountyId = [dict doubleValueForKey:kModelScheduleListStartCountyId];
            self.startCityId = [dict doubleValueForKey:kModelScheduleListStartCityId];
            self.tempState = [dict doubleValueForKey:kModelScheduleListTempState];
            self.closeTime = [dict doubleValueForKey:kModelScheduleListCloseTime];
            self.startTownId = [dict doubleValueForKey:kModelScheduleListStartTownId];
            self.startContact = [dict stringValueForKey:kModelScheduleListStartContact];
            self.planNumber = [dict stringValueForKey:kModelScheduleListPlanNumber];
            self.vehicleLength = [dict doubleValueForKey:kModelScheduleListVehicleLength];
            self.vehicleId = [dict doubleValueForKey:kModelScheduleListVehicleId];
            self.endAddr = [dict stringValueForKey:kModelScheduleListEndAddr];
            self.endLng = [dict doubleValueForKey:kModelScheduleListEndLng];
            self.startLat = [dict doubleValueForKey:kModelScheduleListStartLat];
            self.endTownId = [dict doubleValueForKey:kModelScheduleListEndTownId];
            self.startCountyName = [dict stringValueForKey:kModelScheduleListStartCountyName];
            self.startPhone = [dict stringValueForKey:kModelScheduleListStartPhone];
            self.driverName = [dict stringValueForKey:kModelScheduleListDriverName];
            self.endEntName = [dict stringValueForKey:kModelScheduleListEndEntName];
            self.endProvinceName = [dict stringValueForKey:kModelScheduleListEndProvinceName];
            self.vehicleNumber = [dict stringValueForKey:kModelScheduleListVehicleNumber];
            self.cargoName = [dict stringValueForKey:kModelScheduleListCargoName];
            self.endLat = [dict doubleValueForKey:kModelScheduleListEndLat];
            self.startProvinceName = [dict stringValueForKey:kModelScheduleListStartProvinceName];
            self.loadUnit = [dict stringValueForKey:kModelScheduleListLoadUnit];
            self.vehicleType = [dict doubleValueForKey:kModelScheduleListVehicleType];
            self.price = [dict doubleValueForKey:kModelScheduleListPrice];
            self.endCityName = [dict stringValueForKey:kModelScheduleListEndCityName];
            self.entId = [dict doubleValueForKey:kModelScheduleListEntId];
            self.startProvinceId = [dict doubleValueForKey:kModelScheduleListStartProvinceId];
            self.endContact = [dict stringValueForKey:kModelScheduleListEndContact];
            self.endTownName = [dict stringValueForKey:kModelScheduleListEndTownName];
            self.reviewTime = [dict doubleValueForKey:kModelScheduleListReviewTime];
            self.driverId = [dict doubleValueForKey:kModelScheduleListDriverId];
            self.startLng = [dict doubleValueForKey:kModelScheduleListStartLng];
            self.startTownName = [dict stringValueForKey:kModelScheduleListStartTownName];
            self.waybillId = [dict doubleValueForKey:kModelScheduleListWaybillId];
            self.endCityId = [dict doubleValueForKey:kModelScheduleListEndCityId];
            self.endCountyName = [dict stringValueForKey:kModelScheduleListEndCountyName];
            self.actualLoad = [dict doubleValueForKey:kModelScheduleListActualLoad];
            self.fleetId = [dict doubleValueForKey:kModelScheduleListFleetId];
            self.driverPhone = [dict stringValueForKey:kModelScheduleListDriverPhone];
            self.endPhone = [dict stringValueForKey:kModelScheduleListEndPhone];
            self.startAddr = [dict stringValueForKey:kModelScheduleListStartAddr];
            self.waybillNumber = [dict stringValueForKey:kModelScheduleListWaybillNumber];
            self.scanTime = [dict doubleValueForKey:kModelScheduleListScanTime];
            self.standardLoad = [dict doubleValueForKey:kModelScheduleListStandardLoad];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCountyId] forKey:kModelScheduleListEndCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelScheduleListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.planId] forKey:kModelScheduleListPlanId];
    [mutableDict setValue:self.entName forKey:kModelScheduleListEntName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endProvinceId] forKey:kModelScheduleListEndProvinceId];
    [mutableDict setValue:self.startCityName forKey:kModelScheduleListStartCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCountyId] forKey:kModelScheduleListStartCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCityId] forKey:kModelScheduleListStartCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempState] forKey:kModelScheduleListTempState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.closeTime] forKey:kModelScheduleListCloseTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTownId] forKey:kModelScheduleListStartTownId];
    [mutableDict setValue:self.startContact forKey:kModelScheduleListStartContact];
    [mutableDict setValue:self.planNumber forKey:kModelScheduleListPlanNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleLength] forKey:kModelScheduleListVehicleLength];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleId] forKey:kModelScheduleListVehicleId];
    [mutableDict setValue:self.endAddr forKey:kModelScheduleListEndAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endLng] forKey:kModelScheduleListEndLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startLat] forKey:kModelScheduleListStartLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTownId] forKey:kModelScheduleListEndTownId];
    [mutableDict setValue:self.startCountyName forKey:kModelScheduleListStartCountyName];
    [mutableDict setValue:self.startPhone forKey:kModelScheduleListStartPhone];
    [mutableDict setValue:self.driverName forKey:kModelScheduleListDriverName];
    [mutableDict setValue:self.endEntName forKey:kModelScheduleListEndEntName];
    [mutableDict setValue:self.endProvinceName forKey:kModelScheduleListEndProvinceName];
    [mutableDict setValue:self.vehicleNumber forKey:kModelScheduleListVehicleNumber];
    [mutableDict setValue:self.cargoName forKey:kModelScheduleListCargoName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endLat] forKey:kModelScheduleListEndLat];
    [mutableDict setValue:self.startProvinceName forKey:kModelScheduleListStartProvinceName];
    [mutableDict setValue:self.loadUnit forKey:kModelScheduleListLoadUnit];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleType] forKey:kModelScheduleListVehicleType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelScheduleListPrice];
    [mutableDict setValue:self.endCityName forKey:kModelScheduleListEndCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelScheduleListEntId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startProvinceId] forKey:kModelScheduleListStartProvinceId];
    [mutableDict setValue:self.endContact forKey:kModelScheduleListEndContact];
    [mutableDict setValue:self.endTownName forKey:kModelScheduleListEndTownName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelScheduleListReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kModelScheduleListDriverId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startLng] forKey:kModelScheduleListStartLng];
    [mutableDict setValue:self.startTownName forKey:kModelScheduleListStartTownName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waybillId] forKey:kModelScheduleListWaybillId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endCityId] forKey:kModelScheduleListEndCityId];
    [mutableDict setValue:self.endCountyName forKey:kModelScheduleListEndCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actualLoad] forKey:kModelScheduleListActualLoad];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fleetId] forKey:kModelScheduleListFleetId];
    [mutableDict setValue:self.driverPhone forKey:kModelScheduleListDriverPhone];
    [mutableDict setValue:self.endPhone forKey:kModelScheduleListEndPhone];
    [mutableDict setValue:self.startAddr forKey:kModelScheduleListStartAddr];
    [mutableDict setValue:self.waybillNumber forKey:kModelScheduleListWaybillNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scanTime] forKey:kModelScheduleListScanTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.standardLoad] forKey:kModelScheduleListStandardLoad];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
