//
//  ModelBank.h
//
//  Created by 林栋 隋 on 2019/9/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelBank : NSObject

@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *bankNumber;
@property (nonatomic, assign) double accountType;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, assign) double isInterbank;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
