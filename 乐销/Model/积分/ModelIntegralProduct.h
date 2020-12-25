//
//  ModelIntegralProduct.h
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelIntegralProduct : NSObject

@property (nonatomic, assign) double score;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double stockAmount;
@property (nonatomic, strong) NSString *descriptionUrl;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) double qty;
@property (nonatomic, assign) double displayMode;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, assign) double monthAmount;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSArray *urls;

//logical
@property (nonatomic, assign) BOOL selected;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
