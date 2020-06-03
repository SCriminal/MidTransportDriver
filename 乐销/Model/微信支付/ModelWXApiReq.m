//
//  ModelWXApiReq.m
//
//  Created by 京涛 刘 on 2017/7/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ModelWXApiReq.h"


NSString *const kModelWXApiReqPackage = @"packages";
NSString *const kModelWXApiReqTimestamp = @"timestamp";
NSString *const kModelWXApiReqAppid = @"appid";
NSString *const kModelWXApiReqNoncestr = @"noncestr";
NSString *const kModelWXApiReqPartnerid = @"partnerid";
NSString *const kModelWXApiReqPrepayid = @"prepayid";
NSString *const kModelWXApiReqSign = @"sign";


@interface ModelWXApiReq ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelWXApiReq

@synthesize package = _package;
@synthesize timestamp = _timestamp;
@synthesize appid = _appid;
@synthesize noncestr = _noncestr;
@synthesize partnerid = _partnerid;
@synthesize prepayid = _prepayid;
@synthesize sign = _sign;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.package = [self objectOrNilForKey:kModelWXApiReqPackage fromDictionary:dict];
            self.timestamp = [self objectOrNilForKey:kModelWXApiReqTimestamp fromDictionary:dict];
            self.appid = [self objectOrNilForKey:kModelWXApiReqAppid fromDictionary:dict];
            self.noncestr = [self objectOrNilForKey:kModelWXApiReqNoncestr fromDictionary:dict];
            self.partnerid = [self objectOrNilForKey:kModelWXApiReqPartnerid fromDictionary:dict];
            self.prepayid = [self objectOrNilForKey:kModelWXApiReqPrepayid fromDictionary:dict];
            self.sign = [self objectOrNilForKey:kModelWXApiReqSign fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.package forKey:kModelWXApiReqPackage];
    [mutableDict setValue:self.timestamp forKey:kModelWXApiReqTimestamp];
    [mutableDict setValue:self.appid forKey:kModelWXApiReqAppid];
    [mutableDict setValue:self.noncestr forKey:kModelWXApiReqNoncestr];
    [mutableDict setValue:self.partnerid forKey:kModelWXApiReqPartnerid];
    [mutableDict setValue:self.prepayid forKey:kModelWXApiReqPrepayid];
    [mutableDict setValue:self.sign forKey:kModelWXApiReqSign];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}




@end
