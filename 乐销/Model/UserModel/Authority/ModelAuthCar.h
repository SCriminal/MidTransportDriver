//
//  ModelAuthCar.h
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthCar : NSObject

@property (nonatomic, strong) NSString *plateNumber;
@property (nonatomic, strong) NSString *useCharacter;
@property (nonatomic, strong) NSString *driving2Url;
@property (nonatomic, strong) NSString *reviewerName;
@property (nonatomic, strong) NSString *reviewNumber;
@property (nonatomic, assign) double plateColor;
@property (nonatomic, assign) double submitId;
@property (nonatomic, strong) NSString *reviewerEntName;
@property (nonatomic, strong) NSString *submitName;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, assign) double vehicleLength;
@property (nonatomic, assign) double vehicleId;
@property (nonatomic, strong) NSString *driving3Url;
@property (nonatomic, strong) NSString *rtpNumber;
@property (nonatomic, assign) double drivingRegisterDate;
@property (nonatomic, assign) double energyType;
@property (nonatomic, strong) NSString *engineNumber;
@property (nonatomic, assign) double tractionMass;
@property (nonatomic, assign) double approvedLoad;
@property (nonatomic, assign) double vehicleHeight;
@property (nonatomic, assign) double drivingIssueDate;
@property (nonatomic, assign) double reviewerId;
@property (nonatomic, assign) double vehicleWidth;
@property (nonatomic, assign) double vehicleType;
@property (nonatomic, assign) double reviewerEntId;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, assign) double grossMass;
@property (nonatomic, strong) NSString *vin;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *driving1Url;
@property (nonatomic, assign) double is4500kg;
@property (nonatomic, assign) double unladenMass;
@property (nonatomic, assign) double reviewStatus;
@property (nonatomic, assign) double drivingEndTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
