//
//  ModelOCR.h
//
//  Created by 林栋 隋 on 2020/6/12
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelOCR : NSObject

@property (nonatomic, strong) NSString *tractionMass;
@property (nonatomic, strong) NSString *fileNumber;
@property (nonatomic, strong) NSString *inspectionRecord;
@property (nonatomic, strong) NSString *approvedPassengerCapacity;
@property (nonatomic, strong) NSString *overallDimension;
@property (nonatomic, strong) NSString *energyType;
@property (nonatomic, strong) NSString *grossMass;
@property (nonatomic, strong) NSString *plateNumber;
@property (nonatomic, strong) NSString *unladenMass;
@property (nonatomic, strong) NSString *issue;

@property (nonatomic, strong) NSString *approvedLoad;

@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *issueDate;
@property (nonatomic, strong) NSString *useCharacter;
@property (nonatomic, strong) NSString *vin;
@property (nonatomic, strong) NSString *registerDate;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *vehicleType;
@property (nonatomic, strong) NSString *engineNumber;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iDNumber;

@property (nonatomic, readonly) NSString *vehicleLoad;
@property (nonatomic, assign) double length;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double issueDateStamp;
@property (nonatomic, assign) double registerDateStamp;
@property (nonatomic, strong) NSString *nationality;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, assign) double birthDateStamp;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *licenseNumber;
@property (nonatomic, strong) NSString *angle;
@property (nonatomic, strong) NSString *legalPerson;
@property (nonatomic, strong) NSString *establishDate;
@property (nonatomic, strong) NSString *capital;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *validPeriod;
@property (nonatomic, strong) NSString *business;
@property (nonatomic, strong) NSString *registerNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
