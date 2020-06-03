//
//  ModelValidCar.h
//
//  Created by 林栋 隋 on 2019/11/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelValidCar : NSObject

@property (nonatomic, assign) double fleetId;
@property (nonatomic, assign) double vehicleId;
@property (nonatomic, strong) NSString *vehicleNumber;
@property (nonatomic, strong) NSString *fleetName;
@property (nonatomic, readonly) NSString *nameShow;
@property (nonatomic, assign) double state;
@property (nonatomic, assign) double iDProperty;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
