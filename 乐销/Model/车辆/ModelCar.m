//
//  ModelCar.m
//
//  Created by sld s on 2019/5/29
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelCar.h"


NSString *const kModelCarId = @"id";
NSString *const kModelCarDriverPhone = @"driverPhone";
NSString *const kModelCarDriverId = @"driverId";
NSString *const kModelCarVin = @"vin";
NSString *const kModelCarEngineNumber = @"engineNumber";
NSString *const kModelCarLicenceType = @"licenceType";
NSString *const kModelCarVehicleNumber = @"vehicleNumber";
NSString *const kModelCarDriverName = @"driverName";
NSString *const kModelCarEntId = @"entId";
NSString *const kModelCarDate = @"date";
NSString *const kModelCarCreateTime = @"createTime";
NSString *const kModelCarTrailerNumber = @"trailerNumber";
NSString *const kModelCarDriverUserId = @"driverUserId";
NSString *const kModelCarQualificationState = @"qualificationState";
NSString *const kModelCarVehicleLoad = @"vehicleLoad";
NSString *const kModelCarSubmitTime = @"submitTime";
NSString *const kModelCarAxle = @"axle";
NSString *const kModelCarVehicleType = @"vehicleType";
NSString *const kModelCarEntName = @"entName";
NSString *const kModelCarVehicleLength = @"vehicleLength";
NSString *const kModelCarVehicleLicense = @"vehicleLicense";
NSString *const kModelCarVehicleOwner = @"vehicleOwner";
NSString *const kModelCarDrivingLicenseFrontUrl = @"drivingLicenseFrontUrl";
NSString *const kModelCarTrailerGoodsInsuranceUrl = @"trailerGoodsInsuranceUrl";
NSString *const kModelCarVehiclePhotoUrl = @"vehiclePhotoUrl";
NSString *const kModelCarManagementLicenseUrl = @"managementLicenseUrl";
NSString *const kModelCarTrailerInsuranceUrl = @"trailerInsuranceUrl";
NSString *const kModelCarTrailerTripartiteInsuranceUrl = @"trailerTripartiteInsuranceUrl";
NSString *const kModelCarDrivingLicenseNegativeUrl = @"drivingLicenseNegativeUrl";
NSString *const kModelCarVehicleInsuranceUrl = @"vehicleInsuranceUrl";
NSString *const kModelCarVehicleTripartiteInsuranceUrl = @"vehicleTripartiteInsuranceUrl";
NSString *const kModelCarDrivingEndDate = @"drivingEndDate";
NSString *const kModelCarDrivingRegisterDate = @"drivingRegisterDate";
NSString *const kModelCarEnergyType = @"energyType";
NSString *const kModelCarDrivingIssueDate = @"drivingIssueDate";
NSString *const kModelCarWeight = @"weight";
NSString *const kModelCarLength = @"length";
NSString *const kModelCarSubmitDate = @"submitDate";
NSString *const kModelCarGrossMass = @"grossMass";
NSString *const kModelCarTruckNumber = @"truckNumber";
NSString *const kModelCarHeight = @"height";
NSString *const kModelCarRoadTransportNumber = @"roadTransportNumber";
NSString *const kModelCarUseCharacter = @"useCharacter";
NSString *const kModelCarDrivingAgency = @"drivingAgency";
NSString *const kModelCarModel = @"model";
NSString *const kModelCarDrivingNumber = @"drivingNumber";
NSString *const kModelCarDriving2NegativeUrl = @"driving2NegativeUrl";

@interface ModelCar ()

@end

@implementation ModelCar

@synthesize iDProperty = _iDProperty;
@synthesize driverPhone = _driverPhone;
@synthesize driverId = _driverId;
@synthesize vin = _vin;
@synthesize engineNumber = _engineNumber;
@synthesize licenceType = _licenceType;
@synthesize vehicleNumber = _vehicleNumber;
@synthesize driverName = _driverName;
@synthesize entId = _entId;

#pragma mark logical show
- (NSString *)authStatusShow{
    switch ((int)self.qualificationState) {
        case 1:
            return @"待提交";
            break;
        case 2:
            return @"审核中";
            break;
        case 3:
            return @"已认证";
            break;
        case 10:
            return @"认证失败";
            break;
        default:
            break;
    }
    return @"";
}
- (UIColor *)authStatusColorShow{
    switch ((int)self.qualificationState) {
        case 1:
        case 2:
            return COLOR_BLUE;
            break;
        case 3:
            return COLOR_GREEN;
            break;
        case 10:
            return [UIColor redColor];
            break;
        default:
            break;
    }
    return COLOR_ORANGE;
}

- (BOOL)isAuthorityAcceptOrAuthering{
    return self.qualificationState == 3||self.qualificationState == 2;
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
            self.iDProperty = [dict doubleValueForKey:kModelCarId];
            self.driverPhone = [dict stringValueForKey:kModelCarDriverPhone];
            self.driverId = [dict doubleValueForKey:kModelCarDriverId];
            self.vin = [dict stringValueForKey:kModelCarVin];
            self.engineNumber = [dict stringValueForKey:kModelCarEngineNumber];
            self.licenceType = [dict doubleValueForKey:kModelCarLicenceType];
            self.vehicleNumber = [dict stringValueForKey:kModelCarVehicleNumber];
            self.driverName = [dict stringValueForKey:kModelCarDriverName];
            self.entId = [dict doubleValueForKey:kModelCarEntId];
        self.date = [dict doubleValueForKey:kModelCarDate];
        self.createTime = [dict doubleValueForKey:kModelCarCreateTime];
        self.trailerNumber = [dict stringValueForKey:kModelCarTrailerNumber];
        self.driverUserId = [dict doubleValueForKey:kModelCarDriverUserId];
        self.qualificationState = [dict doubleValueForKey:kModelCarQualificationState];
        self.vehicleLoad = [dict doubleValueForKey:kModelCarVehicleLoad];
        self.submitTime = [dict stringValueForKey:kModelCarSubmitTime];
        self.axle = [dict doubleValueForKey:kModelCarAxle];
        self.vehicleType = [dict doubleValueForKey:kModelCarVehicleType];
        self.entName = [dict stringValueForKey:kModelCarEntName];
        self.vehicleLength = [dict doubleValueForKey:kModelCarVehicleLength];
        self.vehicleLicense = [dict stringValueForKey:kModelCarVehicleLicense];
        self.vehicleOwner = [dict stringValueForKey:kModelCarVehicleOwner];
        self.drivingLicenseFrontUrl = [dict stringValueForKey:kModelCarDrivingLicenseFrontUrl];
        self.trailerGoodsInsuranceUrl = [dict stringValueForKey:kModelCarTrailerGoodsInsuranceUrl];
        self.vehiclePhotoUrl = [dict stringValueForKey:kModelCarVehiclePhotoUrl];
        self.managementLicenseUrl = [dict stringValueForKey:kModelCarManagementLicenseUrl];
        self.trailerInsuranceUrl = [dict stringValueForKey:kModelCarTrailerInsuranceUrl];
        self.trailerTripartiteInsuranceUrl = [dict stringValueForKey:kModelCarTrailerTripartiteInsuranceUrl];
        self.drivingLicenseNegativeUrl = [dict stringValueForKey:kModelCarDrivingLicenseNegativeUrl];
        self.vehicleInsuranceUrl = [dict stringValueForKey:kModelCarVehicleInsuranceUrl];
        self.vehicleTripartiteInsuranceUrl = [dict stringValueForKey:kModelCarVehicleTripartiteInsuranceUrl];
        self.drivingNumber = [dict stringValueForKey:kModelCarDrivingNumber];
        self.drivingEndDate = [dict doubleValueForKey:kModelCarDrivingEndDate];
        self.drivingRegisterDate = [dict doubleValueForKey:kModelCarDrivingRegisterDate];
        self.energyType = [dict doubleValueForKey:kModelCarEnergyType];
        self.drivingIssueDate = [dict doubleValueForKey:kModelCarDrivingIssueDate];
        self.weight = [dict doubleValueForKey:kModelCarWeight];
        self.length = [dict doubleValueForKey:kModelCarLength];
        self.submitDate = [dict doubleValueForKey:kModelCarSubmitDate];
        self.grossMass = [dict doubleValueForKey:kModelCarGrossMass];
        self.truckNumber = [dict stringValueForKey:kModelCarTruckNumber];
        self.height = [dict doubleValueForKey:kModelCarHeight];
        self.roadTransportNumber = [dict stringValueForKey:kModelCarRoadTransportNumber];
        self.useCharacter = [dict stringValueForKey:kModelCarUseCharacter];
        self.drivingAgency = [dict stringValueForKey:kModelCarDrivingAgency];
        self.model = [dict stringValueForKey:kModelCarModel];
        self.driving2NegativeUrl = [dict stringValueForKey:kModelCarDriving2NegativeUrl];

        if (self.qualificationState == 0) {
            self.qualificationState = [dict doubleValueForKey:@"state"];
        }
        if (self.vehicleLoad == 0) {
            self.vehicleLoad = [dict doubleValueForKey:@"load"];
        }
//        if (self.qualificationState == 0) {
//            self.qualificationState = [dict doubleValueForKey:@"state"];
//        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCarId];
    [mutableDict setValue:self.driverPhone forKey:kModelCarDriverPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kModelCarDriverId];
    [mutableDict setValue:self.vin forKey:kModelCarVin];
    [mutableDict setValue:self.engineNumber forKey:kModelCarEngineNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.licenceType] forKey:kModelCarLicenceType];
    [mutableDict setValue:self.vehicleNumber forKey:kModelCarVehicleNumber];
    [mutableDict setValue:self.driverName forKey:kModelCarDriverName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelCarEntId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kModelCarDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelCarCreateTime];
    [mutableDict setValue:self.trailerNumber forKey:kModelCarTrailerNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverUserId] forKey:kModelCarDriverUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qualificationState] forKey:kModelCarQualificationState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleLoad] forKey:kModelCarVehicleLoad];
    [mutableDict setValue:self.submitTime forKey:kModelCarSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.axle] forKey:kModelCarAxle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleType] forKey:kModelCarVehicleType];
    [mutableDict setValue:self.entName forKey:kModelCarEntName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleLength] forKey:kModelCarVehicleLength];
    [mutableDict setValue:self.vehicleLicense forKey:kModelCarVehicleLicense];
    [mutableDict setValue:self.vehicleOwner forKey:kModelCarVehicleOwner];
    [mutableDict setValue:self.drivingLicenseFrontUrl forKey:kModelCarDrivingLicenseFrontUrl];
    [mutableDict setValue:self.trailerGoodsInsuranceUrl forKey:kModelCarTrailerGoodsInsuranceUrl];
    [mutableDict setValue:self.vehiclePhotoUrl forKey:kModelCarVehiclePhotoUrl];
    [mutableDict setValue:self.managementLicenseUrl forKey:kModelCarManagementLicenseUrl];
    [mutableDict setValue:self.trailerInsuranceUrl forKey:kModelCarTrailerInsuranceUrl];
    [mutableDict setValue:self.trailerTripartiteInsuranceUrl forKey:kModelCarTrailerTripartiteInsuranceUrl];
    [mutableDict setValue:self.drivingLicenseNegativeUrl forKey:kModelCarDrivingLicenseNegativeUrl];
    [mutableDict setValue:self.vehicleInsuranceUrl forKey:kModelCarVehicleInsuranceUrl];
    [mutableDict setValue:self.vehicleTripartiteInsuranceUrl forKey:kModelCarVehicleTripartiteInsuranceUrl];
    [mutableDict setValue:self.drivingNumber forKey:kModelCarDrivingNumber];
    [mutableDict setValue:NSNumber.dou(self.drivingEndDate) forKey:kModelCarDrivingEndDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.drivingRegisterDate] forKey:kModelCarDrivingRegisterDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.energyType] forKey:kModelCarEnergyType];
    [mutableDict setValue:NSNumber.dou(self.drivingIssueDate) forKey:kModelCarDrivingIssueDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weight] forKey:kModelCarWeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.length] forKey:kModelCarLength];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitDate] forKey:kModelCarSubmitDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grossMass] forKey:kModelCarGrossMass];
    [mutableDict setValue:self.truckNumber forKey:kModelCarTruckNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kModelCarHeight];
    [mutableDict setValue:self.roadTransportNumber forKey:kModelCarRoadTransportNumber];
    [mutableDict setValue:self.useCharacter forKey:kModelCarUseCharacter];
    [mutableDict setValue:self.drivingAgency forKey:kModelCarDrivingAgency];
    [mutableDict setValue:self.model forKey:kModelCarModel];
    [mutableDict setValue:self.driving2NegativeUrl forKey:kModelCarDriving2NegativeUrl];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
