//
//  ModelAuthorityImage.h
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthorityImage : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double certificateType;
@property (nonatomic, strong) NSString *url;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
