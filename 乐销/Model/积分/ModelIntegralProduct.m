//
//  ModelIntegralProduct.m
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelIntegralProduct.h"


NSString *const kModelIntegralProductScore = @"score";
NSString *const kModelIntegralProductId = @"id";
NSString *const kModelIntegralProductPrice = @"price";
NSString *const kModelIntegralProductStockAmount = @"stockAmount";
NSString *const kModelIntegralProductUrlList = @"urlList";
NSString *const kModelIntegralProductDescriptionUrl = @"descriptionUrl";
NSString *const kModelIntegralProductCoverUrl = @"coverUrl";
NSString *const kModelIntegralProductName = @"name";
NSString *const kModelIntegralProductQty = @"qty";
NSString *const kModelIntegralProductCode = @"code";
NSString *const kModelIntegralProductDisplayMode = @"displayMode";
NSString *const kModelIntegralProductSelected = @"selected";
NSString *const kModelIntegralProductBody = @"body";
NSString *const kModelIntegralProductCategoryId = @"categoryId";
NSString *const kModelIntegralProductMonthAmount = @"monthAmount";
NSString *const kModelIntegralProductCategoryName = @"categoryName";
NSString *const kModelIntegralProductUrls = @"urls";

@interface ModelIntegralProduct ()
@property (nonatomic, strong) NSArray *urlList;

@end

@implementation ModelIntegralProduct

@synthesize score = _score;
@synthesize iDProperty = _iDProperty;
@synthesize price = _price;
@synthesize stockAmount = _stockAmount;
@synthesize urlList = _urlList;
@synthesize descriptionUrl = _descriptionUrl;
@synthesize coverUrl = _coverUrl;
@synthesize name = _name;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.score = [dict doubleValueForKey:kModelIntegralProductScore];
            self.iDProperty = [dict doubleValueForKey:kModelIntegralProductId];
            self.price = [dict doubleValueForKey:kModelIntegralProductPrice];
            self.stockAmount = [dict doubleValueForKey:kModelIntegralProductStockAmount];
            self.descriptionUrl = [dict stringValueForKey:kModelIntegralProductDescriptionUrl];
            self.coverUrl = [dict stringValueForKey:kModelIntegralProductCoverUrl];
            self.name = [dict stringValueForKey:kModelIntegralProductName];
        self.qty = [dict doubleValueForKey:kModelIntegralProductQty];
        self.code = [dict stringValueForKey:kModelIntegralProductCode];
        self.displayMode = [dict doubleValueForKey:kModelIntegralProductDisplayMode];
        self.selected = [dict doubleValueForKey:kModelIntegralProductSelected];
        self.body = [dict stringValueForKey:kModelIntegralProductBody];
                  self.categoryId = [dict doubleValueForKey:kModelIntegralProductCategoryId];
                  self.monthAmount = [dict doubleValueForKey:kModelIntegralProductMonthAmount];
                  self.categoryName = [dict stringValueForKey:kModelIntegralProductCategoryName];
        self.urls =  [dict arrayValueForKey:kModelIntegralProductUrls];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelIntegralProductScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelIntegralProductId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelIntegralProductPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stockAmount] forKey:kModelIntegralProductStockAmount];
    [mutableDict setValue:self.descriptionUrl forKey:kModelIntegralProductDescriptionUrl];
    [mutableDict setValue:self.coverUrl forKey:kModelIntegralProductCoverUrl];
    [mutableDict setValue:self.name forKey:kModelIntegralProductName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qty] forKey:kModelIntegralProductQty];
    [mutableDict setValue:self.code forKey:kModelIntegralProductCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayMode] forKey:kModelIntegralProductDisplayMode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.selected] forKey:kModelIntegralProductSelected];
    [mutableDict setValue:self.body forKey:kModelIntegralProductBody];
       [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelIntegralProductCategoryId];
       [mutableDict setValue:[NSNumber numberWithDouble:self.monthAmount] forKey:kModelIntegralProductMonthAmount];
       [mutableDict setValue:self.categoryName forKey:kModelIntegralProductCategoryName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.urls] forKey:kModelIntegralProductUrls];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
