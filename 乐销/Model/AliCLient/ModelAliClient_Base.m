//
//  ModelAliClient_Base.m
//
//  Created by sld s on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ModelAliClient_Base.h"


NSString *const kModelAliClient_BaseSecurityToken = @"SecurityToken";
NSString *const kModelAliClient_BaseExpiration = @"Expiration";
NSString *const kModelAliClient_BaseAccessKeySecret = @"AccessKeySecret";
NSString *const kModelAliClient_BaseAccessKeyId = @"AccessKeyId";


@interface ModelAliClient_Base ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelAliClient_Base

@synthesize securityToken = _securityToken;
@synthesize expiration = _expiration;
@synthesize accessKeySecret = _accessKeySecret;
@synthesize accessKeyId = _accessKeyId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.securityToken = [self objectOrNilForKey:kModelAliClient_BaseSecurityToken fromDictionary:dict];

            self.expiration = [self objectOrNilForKey:kModelAliClient_BaseExpiration fromDictionary:dict];
            self.accessKeySecret = [self objectOrNilForKey:kModelAliClient_BaseAccessKeySecret fromDictionary:dict];
            self.accessKeyId = [self objectOrNilForKey:kModelAliClient_BaseAccessKeyId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.securityToken forKey:kModelAliClient_BaseSecurityToken];
    [mutableDict setValue:self.expiration forKey:kModelAliClient_BaseExpiration];
    [mutableDict setValue:self.accessKeySecret forKey:kModelAliClient_BaseAccessKeySecret];
    [mutableDict setValue:self.accessKeyId forKey:kModelAliClient_BaseAccessKeyId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.securityToken = [aDecoder decodeObjectForKey:kModelAliClient_BaseSecurityToken];
    self.expiration = [aDecoder decodeObjectForKey:kModelAliClient_BaseExpiration];
    self.accessKeySecret = [aDecoder decodeObjectForKey:kModelAliClient_BaseAccessKeySecret];
    self.accessKeyId = [aDecoder decodeObjectForKey:kModelAliClient_BaseAccessKeyId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_securityToken forKey:kModelAliClient_BaseSecurityToken];
    [aCoder encodeObject:_expiration forKey:kModelAliClient_BaseExpiration];
    [aCoder encodeObject:_accessKeySecret forKey:kModelAliClient_BaseAccessKeySecret];
    [aCoder encodeObject:_accessKeyId forKey:kModelAliClient_BaseAccessKeyId];
}

- (id)copyWithZone:(NSZone *)zone
{
    ModelAliClient_Base *copy = [[ModelAliClient_Base alloc] init];
    
    if (copy) {

        copy.securityToken = [self.securityToken copyWithZone:zone];
        copy.expiration = [self.expiration copyWithZone:zone];
        copy.accessKeySecret = [self.accessKeySecret copyWithZone:zone];
        copy.accessKeyId = [self.accessKeyId copyWithZone:zone];
    }
    
    return copy;
}


@end
