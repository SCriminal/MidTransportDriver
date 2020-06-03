//
//  ModelPackageType.m
//
//  Created by 林栋 隋 on 2019/6/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelPackageType.h"


NSString *const kModelPackageTypeSort = @"sort";
NSString *const kModelPackageTypeId = @"id";
NSString *const kModelPackageTypeContainerSize = @"containerSize";
NSString *const kModelPackageTypeEntId = @"entId";
NSString *const kModelPackageTypeLabel = @"label";
NSString *const kModelPackageTypeDescription = @"description";
NSString *const kModelPackageTypeValue = @"value";
NSString *const kModelPackageTypeName = @"name";


@interface ModelPackageType ()
@end

@implementation ModelPackageType

@synthesize sort = _sort;
@synthesize iDProperty = _iDProperty;
@synthesize containerSize = _containerSize;
@synthesize entId = _entId;
@synthesize label = _label;
@synthesize iDPropertyDescription = _iDPropertyDescription;
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
            self.sort = [dict doubleValueForKey:kModelPackageTypeSort];
            self.iDProperty = [dict doubleValueForKey:kModelPackageTypeId];
            self.containerSize = [dict doubleValueForKey:kModelPackageTypeContainerSize];
            self.entId = [dict doubleValueForKey:kModelPackageTypeEntId];
            self.label = [dict stringValueForKey:kModelPackageTypeLabel];
            self.iDPropertyDescription = [dict stringValueForKey:kModelPackageTypeDescription];
            self.value = [dict doubleValueForKey:kModelPackageTypeValue];
            self.name = [dict stringValueForKey:kModelPackageTypeName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kModelPackageTypeSort];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelPackageTypeId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.containerSize] forKey:kModelPackageTypeContainerSize];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelPackageTypeEntId];
    [mutableDict setValue:self.label forKey:kModelPackageTypeLabel];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelPackageTypeDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.value] forKey:kModelPackageTypeValue];
    [mutableDict setValue:self.name forKey:kModelPackageTypeName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
