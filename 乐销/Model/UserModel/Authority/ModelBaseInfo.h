//
//  ModelBaseInfo.h
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelBaseInfo : NSObject

@property (nonatomic, assign) double birthday;
@property (nonatomic, assign) double driverStartTime;
@property (nonatomic, assign) double userStatus;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double countyId;
@property (nonatomic, assign) double driverEndTime;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, assign) double gender;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, assign) double isDriver;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, assign) double isIdentity;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *wxNumber;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, assign) double reviewStatus;

//logical
@property (nonatomic, readonly) NSString *authStatusShow;

+ (void)jumpToAuthorityStateVCSuccessBlock:(void (^)(void))successBlock;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
