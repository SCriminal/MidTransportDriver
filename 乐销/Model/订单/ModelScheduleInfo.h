//
//  ModelScheduleInfo.h
//
//  Created by 林栋 隋 on 2019/11/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelScheduleInfo : NSObject

@property (nonatomic, strong) NSString *endCityName;
@property (nonatomic, strong) NSString *startAddr;
@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, strong) NSString *startContact;
@property (nonatomic, strong) NSString *endPhone;
@property (nonatomic, strong) NSString *endCountyName;
@property (nonatomic, strong) NSString *endContact;
@property (nonatomic, strong) NSString *endEntName;
@property (nonatomic, strong) NSString *cargoName;
@property (nonatomic, strong) NSString *entName;
@property (nonatomic, strong) NSString *endAddr;
@property (nonatomic, assign) double closeTime;
@property (nonatomic, strong) NSString *endProvinceName;
@property (nonatomic, strong) NSString *startCountyName;
@property (nonatomic, strong) NSString *startTownName;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, assign) double waybillVolume;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *startPhone;
@property (nonatomic, strong) NSString *endTownName;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double reserveVolume;
@property (nonatomic, assign) double isOpen;

//logical
@property (nonatomic, readonly) NSString *addressFromShow;
@property (nonatomic, readonly) NSString *addressToShow;
@property (nonatomic, readonly) NSString *addressFromDetailShow;
@property (nonatomic, readonly) NSString *addressToDetailShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
