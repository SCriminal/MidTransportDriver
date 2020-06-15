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


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
