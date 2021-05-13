//
//  ModelAuthCar.m
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthCar.h"


NSString *const kModelAuthCarPlateNumber = @"plateNumber";
NSString *const kModelAuthCarUseCharacter = @"useCharacter";
NSString *const kModelAuthCarDriving2Url = @"driving3Url";
NSString *const kModelAuthCarReviewerName = @"reviewerName";
NSString *const kModelAuthCarReviewNumber = @"reviewNumber";
NSString *const kModelAuthCarPlateColor = @"plateColor";
NSString *const kModelAuthCarSubmitId = @"submitId";
NSString *const kModelAuthCarReviewerEntName = @"reviewerEntName";
NSString *const kModelAuthCarSubmitName = @"submitName";
NSString *const kModelAuthCarDescription = @"description";
NSString *const kModelAuthCarVehicleLength = @"vehicleLength";
NSString *const kModelAuthCarVehicleId = @"vehicleId";
NSString *const kModelAuthCarDriving3Url = @"driving4Url";
NSString *const kModelAuthCarRtpNumber = @"rtpNumber";
NSString *const kModelAuthCarDrivingRegisterDate = @"drivingRegisterDate";
NSString *const kModelAuthCarEnergyType = @"energyType";
NSString *const kModelAuthCarEngineNumber = @"engineNumber";
NSString *const kModelAuthCarTractionMass = @"tractionMass";
NSString *const kModelAuthCarApprovedLoad = @"approvedLoad";
NSString *const kModelAuthCarVehicleHeight = @"vehicleHeight";
NSString *const kModelAuthCarDrivingIssueDate = @"drivingIssueDate";
NSString *const kModelAuthCarReviewerId = @"reviewerId";
NSString *const kModelAuthCarVehicleWidth = @"vehicleWidth";
NSString *const kModelAuthCarVehicleType = @"vehicleType";
NSString *const kModelAuthCarReviewerEntId = @"reviewerEntId";
NSString *const kModelAuthCarModel = @"model";
NSString *const kModelAuthCarGrossMass = @"grossMass";
NSString *const kModelAuthCarVin = @"vin";
NSString *const kModelAuthCarReviewTime = @"reviewTime";
NSString *const kModelAuthCarOwner = @"owner";
NSString *const kModelAuthCarDriving1Url = @"driving2Url";
NSString *const kModelAuthCarIs4500kg = @"is4500kg";
NSString *const kModelAuthCarUnladenMass = @"unladenMass";
NSString *const kModelAuthCarReviewStatus = @"reviewStatus";
NSString *const kModelAuthCarDrivingEndTime = @"drivingEndTime";


@interface ModelAuthCar ()
@end

@implementation ModelAuthCar

@synthesize plateNumber = _plateNumber;
@synthesize useCharacter = _useCharacter;
@synthesize driving2Url = _driving2Url;
@synthesize reviewerName = _reviewerName;
@synthesize reviewNumber = _reviewNumber;
@synthesize plateColor = _plateColor;
@synthesize submitId = _submitId;
@synthesize reviewerEntName = _reviewerEntName;
@synthesize submitName = _submitName;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize vehicleLength = _vehicleLength;
@synthesize vehicleId = _vehicleId;
@synthesize driving3Url = _driving3Url;
@synthesize rtpNumber = _rtpNumber;
@synthesize drivingRegisterDate = _drivingRegisterDate;
@synthesize energyType = _energyType;
@synthesize engineNumber = _engineNumber;
@synthesize tractionMass = _tractionMass;
@synthesize approvedLoad = _approvedLoad;
@synthesize vehicleHeight = _vehicleHeight;
@synthesize drivingIssueDate = _drivingIssueDate;
@synthesize reviewerId = _reviewerId;
@synthesize vehicleWidth = _vehicleWidth;
@synthesize vehicleType = _vehicleType;
@synthesize reviewerEntId = _reviewerEntId;
@synthesize model = _model;
@synthesize grossMass = _grossMass;
@synthesize vin = _vin;
@synthesize reviewTime = _reviewTime;
@synthesize owner = _owner;
@synthesize driving1Url = _driving1Url;
@synthesize is4500kg = _is4500kg;
@synthesize unladenMass = _unladenMass;
@synthesize reviewStatus = _reviewStatus;
@synthesize drivingEndTime = _drivingEndTime;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.plateNumber = [dict stringValueForKey:kModelAuthCarPlateNumber];
            self.useCharacter = [dict stringValueForKey:kModelAuthCarUseCharacter];
            self.driving2Url = [dict stringValueForKey:kModelAuthCarDriving2Url];
            self.reviewerName = [dict stringValueForKey:kModelAuthCarReviewerName];
            self.reviewNumber = [dict stringValueForKey:kModelAuthCarReviewNumber];
            self.plateColor = [dict doubleValueForKey:kModelAuthCarPlateColor];
            self.submitId = [dict doubleValueForKey:kModelAuthCarSubmitId];
            self.reviewerEntName = [dict stringValueForKey:kModelAuthCarReviewerEntName];
            self.submitName = [dict stringValueForKey:kModelAuthCarSubmitName];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelAuthCarDescription];
            self.vehicleLength = [dict doubleValueForKey:kModelAuthCarVehicleLength];
            self.vehicleId = [dict doubleValueForKey:kModelAuthCarVehicleId];
            self.driving3Url = [dict stringValueForKey:kModelAuthCarDriving3Url];
            self.rtpNumber = [dict stringValueForKey:kModelAuthCarRtpNumber];
            self.drivingRegisterDate = [dict doubleValueForKey:kModelAuthCarDrivingRegisterDate];
            self.energyType = [dict doubleValueForKey:kModelAuthCarEnergyType];
            self.engineNumber = [dict stringValueForKey:kModelAuthCarEngineNumber];
            self.tractionMass = [dict doubleValueForKey:kModelAuthCarTractionMass];
            self.approvedLoad = [dict doubleValueForKey:kModelAuthCarApprovedLoad];
            self.vehicleHeight = [dict doubleValueForKey:kModelAuthCarVehicleHeight];
            self.drivingIssueDate = [dict doubleValueForKey:kModelAuthCarDrivingIssueDate];
            self.reviewerId = [dict doubleValueForKey:kModelAuthCarReviewerId];
            self.vehicleWidth = [dict doubleValueForKey:kModelAuthCarVehicleWidth];
            self.vehicleType = [dict doubleValueForKey:kModelAuthCarVehicleType];
            self.reviewerEntId = [dict doubleValueForKey:kModelAuthCarReviewerEntId];
            self.model = [dict stringValueForKey:kModelAuthCarModel];
            self.grossMass = [dict doubleValueForKey:kModelAuthCarGrossMass];
            self.vin = [dict stringValueForKey:kModelAuthCarVin];
            self.reviewTime = [dict doubleValueForKey:kModelAuthCarReviewTime];
            self.owner = [dict stringValueForKey:kModelAuthCarOwner];
            self.driving1Url = [dict stringValueForKey:kModelAuthCarDriving1Url];
            self.is4500kg = [dict doubleValueForKey:kModelAuthCarIs4500kg];
            self.unladenMass = [dict doubleValueForKey:kModelAuthCarUnladenMass];
            self.reviewStatus = [dict doubleValueForKey:kModelAuthCarReviewStatus];
            self.drivingEndTime = [dict doubleValueForKey:kModelAuthCarDrivingEndTime];

        self.trailerDriving2Url = [dict stringValueForKey:@"trailerDriving2Url"];
        self.trailerDriving3Url = [dict stringValueForKey:@"trailerDriving3Url"];
        self.trailerPlateNumber = [dict stringValueForKey:@"trailerPlateNumber"];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.plateNumber forKey:kModelAuthCarPlateNumber];
    [mutableDict setValue:self.useCharacter forKey:kModelAuthCarUseCharacter];
    [mutableDict setValue:self.driving2Url forKey:kModelAuthCarDriving2Url];
    [mutableDict setValue:self.reviewerName forKey:kModelAuthCarReviewerName];
    [mutableDict setValue:self.reviewNumber forKey:kModelAuthCarReviewNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.plateColor] forKey:kModelAuthCarPlateColor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitId] forKey:kModelAuthCarSubmitId];
    [mutableDict setValue:self.reviewerEntName forKey:kModelAuthCarReviewerEntName];
    [mutableDict setValue:self.submitName forKey:kModelAuthCarSubmitName];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelAuthCarDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleLength] forKey:kModelAuthCarVehicleLength];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleId] forKey:kModelAuthCarVehicleId];
    [mutableDict setValue:self.driving3Url forKey:kModelAuthCarDriving3Url];
    [mutableDict setValue:self.rtpNumber forKey:kModelAuthCarRtpNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.drivingRegisterDate] forKey:kModelAuthCarDrivingRegisterDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.energyType] forKey:kModelAuthCarEnergyType];
    [mutableDict setValue:self.engineNumber forKey:kModelAuthCarEngineNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tractionMass] forKey:kModelAuthCarTractionMass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.approvedLoad] forKey:kModelAuthCarApprovedLoad];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleHeight] forKey:kModelAuthCarVehicleHeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.drivingIssueDate] forKey:kModelAuthCarDrivingIssueDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerId] forKey:kModelAuthCarReviewerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleWidth] forKey:kModelAuthCarVehicleWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vehicleType] forKey:kModelAuthCarVehicleType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerEntId] forKey:kModelAuthCarReviewerEntId];
    [mutableDict setValue:self.model forKey:kModelAuthCarModel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grossMass] forKey:kModelAuthCarGrossMass];
    [mutableDict setValue:self.vin forKey:kModelAuthCarVin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelAuthCarReviewTime];
    [mutableDict setValue:self.owner forKey:kModelAuthCarOwner];
    [mutableDict setValue:self.driving1Url forKey:kModelAuthCarDriving1Url];
    [mutableDict setValue:[NSNumber numberWithDouble:self.is4500kg] forKey:kModelAuthCarIs4500kg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.unladenMass] forKey:kModelAuthCarUnladenMass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewStatus] forKey:kModelAuthCarReviewStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.drivingEndTime] forKey:kModelAuthCarDrivingEndTime];

    [mutableDict setValue:self.trailerDriving2Url forKey:@"trailerDriving2Url"];
    [mutableDict setValue:self.trailerDriving3Url forKey:@"trailerDriving3Url"];
    [mutableDict setValue:self.trailerPlateNumber forKey:@"trailerPlateNumber"];

    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
