//
//  ModelApns.h
//
//  Created by sld s on 2017/2/28
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelAps;

@interface ModelApns : NSObject

@property (nonatomic, strong) NSArray *ids;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) double isSilent;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
