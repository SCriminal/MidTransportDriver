//
//  ModelAuthDriver.h
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthDriver : NSObject

@property (nonatomic, strong) NSString *idFaceUrl;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, assign) double submitterId;
@property (nonatomic, strong) NSString *vehicleUrl;
@property (nonatomic, assign) double reviewStatus;
@property (nonatomic, strong) NSString *driverUrl;
@property (nonatomic, strong) NSString *idEmblemUrl;
@property (nonatomic, assign) double reviewerId;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
