//
//  ModelProvince.m
//
//  Created by sld s on 2019/6/1
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelProvince.h"


NSString *const kModelProvinceId = @"id";
NSString *const kModelProvinceLabel = @"label";
NSString *const kModelProvinceValue = @"value";
NSString *const kModelProvinceName = @"name";


@interface ModelProvince ()
@end

@implementation ModelProvince

@synthesize iDProperty = _iDProperty;
@synthesize label = _label;
@synthesize value = _value;
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
        self.iDProperty = [dict doubleValueForKey:kModelProvinceId];
        self.label = [dict stringValueForKey:kModelProvinceLabel];
        self.value = [dict doubleValueForKey:kModelProvinceValue];
        self.name = [dict stringValueForKey:kModelProvinceName];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelProvinceId];
    [mutableDict setValue:self.label forKey:kModelProvinceLabel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.value] forKey:kModelProvinceValue];
    [mutableDict setValue:self.name forKey:kModelProvinceName];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
