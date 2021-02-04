//
//  ModelModule.h
//
//  Created by 林栋 隋 on 2021/2/4
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelModule : NSObject

@property (nonatomic, assign) double isOpen;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, assign) double sort;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSArray *clientTypes;
@property (nonatomic, strong) NSString *clientTypeDesc;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
