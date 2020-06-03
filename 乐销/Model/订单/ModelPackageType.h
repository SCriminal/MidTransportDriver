//
//  ModelPackageType.h
//
//  Created by 林栋 隋 on 2019/6/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelPackageType : NSObject

@property (nonatomic, assign) double sort;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double containerSize;
@property (nonatomic, assign) double entId;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double value;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
