//
//  ModelLocationItem.h
//
//  Created by 林栋 隋 on 2019/6/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelLocationItem : NSObject

@property (nonatomic, assign) double collectTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, assign) double terminalType;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;
@property (nonatomic, strong) NSString *terminalNumber;
@property (nonatomic, assign) double uploaderId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
