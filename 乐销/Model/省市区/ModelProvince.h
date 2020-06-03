//
//  ModelProvince.h
//
//  Created by sld s on 2019/6/1
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelProvince : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, assign) double value;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
