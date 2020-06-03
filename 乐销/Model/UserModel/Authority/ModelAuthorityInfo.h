//
//  ModelAuthorityInfo.h
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthorityInfo : NSObject

@property (nonatomic, assign) double status;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *explain;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, assign) double reviewId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
