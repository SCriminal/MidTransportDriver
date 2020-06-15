//
//  ModelOCR.m
//
//  Created by 林栋 隋 on 2020/6/12
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelOCR.h"


NSString *const kModelOCRTractionMass = @"tractionMass";
NSString *const kModelOCRFileNumber = @"fileNumber";
NSString *const kModelOCRInspectionRecord = @"inspectionRecord";
NSString *const kModelOCRApprovedPassengerCapacity = @"approvedPassengerCapacity";
NSString *const kModelOCROverallDimension = @"overallDimension";
NSString *const kModelOCREnergyType = @"energyType";
NSString *const kModelOCRGrossMass = @"grossMass";
NSString *const kModelOCRUnladenMass = @"unladenMass";
NSString *const kModelOCRApprovedLoad = @"approvedLoad";
NSString *const kModelOCROwner = @"owner";
NSString *const kModelOCRIssueDate = @"issueDate";
NSString *const kModelOCRUseCharacter = @"useCharacter";
NSString *const kModelOCRVin = @"vin";
NSString *const kModelOCRRegisterDate = @"registerDate";
NSString *const kModelOCRModel = @"model";
NSString *const kModelOCRAddress = @"address";
NSString *const kModelOCRVehicleType = @"vehicleType";
NSString *const kModelOCRPlateNumber = @"plateNumber";
NSString *const kModelOCREngineNumber = @"engineNumber";
NSString *const kModelOCRName = @"name";
NSString *const kModelOCRIDNumber = @"IDNumber";

@interface ModelOCR ()
@end

@implementation ModelOCR

@synthesize tractionMass = _tractionMass;
@synthesize fileNumber = _fileNumber;
@synthesize inspectionRecord = _inspectionRecord;
@synthesize approvedPassengerCapacity = _approvedPassengerCapacity;
@synthesize overallDimension = _overallDimension;
@synthesize energyType = _energyType;
@synthesize grossMass = _grossMass;
@synthesize plateNumber = _plateNumber;
@synthesize unladenMass = _unladenMass;
@synthesize approvedLoad = _approvedLoad;

- (NSString *)vehicleLoad{
    int load = MAX(self.unladenMass.doubleValue, self.tractionMass.doubleValue)/1000.0;
    return load?[NSString stringWithFormat:@"%d吨",load]:nil;
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
            self.tractionMass = [dict stringValueForKey:kModelOCRTractionMass];
            self.fileNumber = [dict stringValueForKey:kModelOCRFileNumber];
            self.inspectionRecord = [dict stringValueForKey:kModelOCRInspectionRecord];
            self.approvedPassengerCapacity = [dict stringValueForKey:kModelOCRApprovedPassengerCapacity];
            self.overallDimension = [dict stringValueForKey:kModelOCROverallDimension];
            self.energyType = [dict stringValueForKey:kModelOCREnergyType];
            self.grossMass = [dict stringValueForKey:kModelOCRGrossMass];
            self.plateNumber = [dict stringValueForKey:kModelOCRPlateNumber];
            self.unladenMass = [dict stringValueForKey:kModelOCRUnladenMass];
            self.approvedLoad = [dict stringValueForKey:kModelOCRApprovedLoad];
        self.owner = [dict stringValueForKey:kModelOCROwner];
        self.issueDate = [dict stringValueForKey:kModelOCRIssueDate];
        self.useCharacter = [dict stringValueForKey:kModelOCRUseCharacter];
        self.vin = [dict stringValueForKey:kModelOCRVin];
        self.registerDate = [dict stringValueForKey:kModelOCRRegisterDate];
        self.model = [dict stringValueForKey:kModelOCRModel];
        self.address = [dict stringValueForKey:kModelOCRAddress];
        self.vehicleType = [dict stringValueForKey:kModelOCRVehicleType];
        self.engineNumber = [dict stringValueForKey:kModelOCREngineNumber];
        self.name = [dict stringValueForKey:kModelOCRName];
        self.iDNumber = [dict stringValueForKey:kModelOCRIDNumber];

        NSArray * aryDimension = [self.overallDimension componentsSeparatedByString:@"X"];
        if (aryDimension.count>2) {
            self.length = [aryDimension.firstObject doubleValue];
            self.width = [[aryDimension objectAtIndex:1] doubleValue];
            self.height = [[aryDimension objectAtIndex:2] doubleValue];
        }
        self.issueDateStamp = [GlobalMethod exchangeStringToDate:self.issueDate formatter:@"YYYYMMDD"].timeIntervalSince1970;
        self.registerDateStamp  = [GlobalMethod exchangeStringToDate:self.registerDate formatter:@"YYYYMMDD"].timeIntervalSince1970;

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tractionMass forKey:kModelOCRTractionMass];
    [mutableDict setValue:self.fileNumber forKey:kModelOCRFileNumber];
    [mutableDict setValue:self.inspectionRecord forKey:kModelOCRInspectionRecord];
    [mutableDict setValue:self.approvedPassengerCapacity forKey:kModelOCRApprovedPassengerCapacity];
    [mutableDict setValue:self.overallDimension forKey:kModelOCROverallDimension];
    [mutableDict setValue:self.energyType forKey:kModelOCREnergyType];
    [mutableDict setValue:self.grossMass forKey:kModelOCRGrossMass];
    [mutableDict setValue:self.plateNumber forKey:kModelOCRPlateNumber];
    [mutableDict setValue:self.unladenMass forKey:kModelOCRUnladenMass];
    [mutableDict setValue:self.approvedLoad forKey:kModelOCRApprovedLoad];
    [mutableDict setValue:self.owner forKey:kModelOCROwner];
    [mutableDict setValue:self.issueDate forKey:kModelOCRIssueDate];
    [mutableDict setValue:self.useCharacter forKey:kModelOCRUseCharacter];
    [mutableDict setValue:self.vin forKey:kModelOCRVin];
    [mutableDict setValue:self.registerDate forKey:kModelOCRRegisterDate];
    [mutableDict setValue:self.model forKey:kModelOCRModel];
    [mutableDict setValue:self.address forKey:kModelOCRAddress];
    [mutableDict setValue:self.vehicleType forKey:kModelOCRVehicleType];
    [mutableDict setValue:self.engineNumber forKey:kModelOCREngineNumber];
    [mutableDict setValue:self.name forKey:kModelOCRName];
    [mutableDict setValue:self.iDNumber forKey:kModelOCRIDNumber];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
