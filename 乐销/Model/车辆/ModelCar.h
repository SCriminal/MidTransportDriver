//
//  ModelCar.h
//
//  Created by sld s on 2019/5/29
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCar : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, assign) double driverId;
@property (nonatomic, strong) NSString *vin;
@property (nonatomic, strong) NSString *engineNumber;
@property (nonatomic, assign) double licenceType;
@property (nonatomic, strong) NSString *vehicleNumber;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, assign) double entId;
@property (nonatomic, assign) double date;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *trailerNumber;
@property (nonatomic, assign) double driverUserId;
@property (nonatomic, assign) double qualificationState;
@property (nonatomic, assign) double vehicleLoad;
@property (nonatomic, strong) NSString *submitTime;
@property (nonatomic, assign) double axle;
@property (nonatomic, assign) double vehicleType;
@property (nonatomic, strong) NSString *entName;
@property (nonatomic, assign) double vehicleLength;
@property (nonatomic, strong) NSString *vehicleLicense;
@property (nonatomic, strong) NSString *vehicleOwner;
@property (nonatomic, strong) NSString *drivingLicenseFrontUrl;
@property (nonatomic, strong) NSString *trailerGoodsInsuranceUrl;
@property (nonatomic, strong) NSString *vehiclePhotoUrl;
@property (nonatomic, strong) NSString *managementLicenseUrl;
@property (nonatomic, strong) NSString *trailerInsuranceUrl;
@property (nonatomic, strong) NSString *trailerTripartiteInsuranceUrl;
@property (nonatomic, strong) NSString *drivingLicenseNegativeUrl;
@property (nonatomic, strong) NSString *vehicleInsuranceUrl;
@property (nonatomic, strong) NSString *vehicleTripartiteInsuranceUrl;
@property (nonatomic, strong) NSString *drivingNumber;
@property (nonatomic, assign) double drivingEndDate;
@property (nonatomic, assign) double drivingRegisterDate;
@property (nonatomic, assign) double energyType;
@property (nonatomic, assign) double drivingIssueDate;
@property (nonatomic, assign) double weight;
@property (nonatomic, assign) double length;
@property (nonatomic, assign) double submitDate;
@property (nonatomic, assign) double grossMass;
@property (nonatomic, strong) NSString *truckNumber;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSString *roadTransportNumber;
@property (nonatomic, strong) NSString *useCharacter;
@property (nonatomic, strong) NSString *drivingAgency;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *driving2NegativeUrl;

//logical
@property (nonatomic, readonly) NSString *authStatusShow;
@property (nonatomic, readonly) UIColor *authStatusColorShow;
@property (nonatomic, readonly) BOOL isAuthorityAcceptOrAuthering;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
