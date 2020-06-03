//
//  ModelAuthorityImage.m
//
//  Created by sld s on 2019/5/23
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthorityImage.h"


NSString *const kModelAuthorityImageId = @"id";
NSString *const kModelAuthorityImageCertificateType = @"certificateType";
NSString *const kModelAuthorityImageUrl = @"url";
NSString *const kModelAuthorityImageType = @"type";


@interface ModelAuthorityImage ()
@end

@implementation ModelAuthorityImage

@synthesize iDProperty = _iDProperty;
@synthesize certificateType = _certificateType;
@synthesize url = _url;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.iDProperty = [dict doubleValueForKey:kModelAuthorityImageId];
        self.certificateType = [dict doubleValueForKey:kModelAuthorityImageCertificateType];
        self.url = [dict stringValueForKey:kModelAuthorityImageUrl];
        if (!self.certificateType) {
            self.certificateType = [dict doubleValueForKey:kModelAuthorityImageType];
            
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAuthorityImageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.certificateType] forKey:kModelAuthorityImageCertificateType];
    [mutableDict setValue:self.url forKey:kModelAuthorityImageUrl];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
