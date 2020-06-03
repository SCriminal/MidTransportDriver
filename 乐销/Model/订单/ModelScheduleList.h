//
//  ModelScheduleList.h
//
//  Created by 林栋 隋 on 2019/11/25
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelScheduleList : NSObject

@property (nonatomic, assign) double endCountyId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double planId;
@property (nonatomic, strong) NSString *entName;
@property (nonatomic, assign) double endProvinceId;
@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, assign) double startCountyId;
@property (nonatomic, assign) double startCityId;
@property (nonatomic, assign) double tempState;
@property (nonatomic, assign) double closeTime;
@property (nonatomic, assign) double startTownId;
@property (nonatomic, strong) NSString *startContact;
@property (nonatomic, strong) NSString *planNumber;
@property (nonatomic, assign) double vehicleLength;
@property (nonatomic, assign) double vehicleId;
@property (nonatomic, strong) NSString *endAddr;
@property (nonatomic, assign) double endLng;
@property (nonatomic, assign) double startLat;
@property (nonatomic, assign) double endTownId;
@property (nonatomic, strong) NSString *startCountyName;
@property (nonatomic, strong) NSString *startPhone;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, strong) NSString *endEntName;
@property (nonatomic, strong) NSString *endProvinceName;
@property (nonatomic, strong) NSString *vehicleNumber;
@property (nonatomic, strong) NSString *cargoName;
@property (nonatomic, assign) double endLat;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, strong) NSString *loadUnit;
@property (nonatomic, assign) double vehicleType;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *endCityName;
@property (nonatomic, assign) double entId;
@property (nonatomic, assign) double startProvinceId;
@property (nonatomic, strong) NSString *endContact;
@property (nonatomic, strong) NSString *endTownName;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, assign) double driverId;
@property (nonatomic, assign) double startLng;
@property (nonatomic, strong) NSString *startTownName;
@property (nonatomic, assign) double waybillId;
@property (nonatomic, assign) double endCityId;
@property (nonatomic, strong) NSString *endCountyName;
@property (nonatomic, assign) double actualLoad;
@property (nonatomic, assign) double fleetId;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, strong) NSString *endPhone;
@property (nonatomic, strong) NSString *startAddr;
@property (nonatomic, strong) NSString *waybillNumber;
@property (nonatomic, assign) double scanTime;
@property (nonatomic, assign) double standardLoad;

//logical
@property (nonatomic, readonly) NSString *scheduleStatusShow;
@property (nonatomic, readonly) UIColor *colorStateShow;
@property (nonatomic, readonly) NSString *addressFromShow;
@property (nonatomic, readonly) NSString *addressToShow;



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
