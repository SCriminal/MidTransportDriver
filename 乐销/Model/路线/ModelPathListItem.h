//
//  ModelPathListItem.h
//
//  Created by 林栋 隋 on 2021/1/18
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelPathListItem : NSObject

@property (nonatomic, assign) double endProvinceId;
@property (nonatomic, strong) NSString *endCityName;
@property (nonatomic, strong) NSString *startCityName;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double routePass2Id;
@property (nonatomic, strong) NSString *endCountyName;
@property (nonatomic, assign) double routePass3Id;
@property (nonatomic, assign) double endCityId;
@property (nonatomic, strong) NSString *routePass3;
@property (nonatomic, strong) NSString *routePass2;
@property (nonatomic, assign) double endCountyId;
@property (nonatomic, strong) NSString *routePass1;
@property (nonatomic, assign) double startProvinceId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *endProvinceName;
@property (nonatomic, assign) double startCityId;
@property (nonatomic, assign) double startCountyId;
@property (nonatomic, strong) NSString *startCountyName;
@property (nonatomic, strong) NSString *startProvinceName;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double routePass1Id;

@property (nonatomic, strong) NSString *startShow;
@property (nonatomic, strong) NSString *endShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
