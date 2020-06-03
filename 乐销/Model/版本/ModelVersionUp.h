//
//  ModelVersionUp.h
//
//  Created by 林栋 隋 on 2019/6/9
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelVersionUp : NSObject

@property (nonatomic, assign) double releaseTime;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *app;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *bundleId;
@property (nonatomic, assign) double terminalType;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double versionType;
@property (nonatomic, strong) NSString *versionNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
