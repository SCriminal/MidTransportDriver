//
//  ModelVersionUp.m
//
//  Created by 林栋 隋 on 2019/6/9
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelVersionUp.h"


NSString *const kModelVersionUpReleaseTime = @"releaseTime";
NSString *const kModelVersionUpDownloadUrl = @"downloadUrl";
NSString *const kModelVersionUpApp = @"app";
NSString *const kModelVersionUpId = @"id";
NSString *const kModelVersionUpBundleId = @"bundleId";
NSString *const kModelVersionUpTerminalType = @"terminalType";
NSString *const kModelVersionUpDescription = @"description";
NSString *const kModelVersionUpVersionType = @"versionType";
NSString *const kModelVersionUpVersionNumber = @"versionNumber";


@interface ModelVersionUp ()
@end

@implementation ModelVersionUp

@synthesize releaseTime = _releaseTime;
@synthesize downloadUrl = _downloadUrl;
@synthesize app = _app;
@synthesize iDProperty = _iDProperty;
@synthesize bundleId = _bundleId;
@synthesize terminalType = _terminalType;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize versionType = _versionType;
@synthesize versionNumber = _versionNumber;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.releaseTime = [dict doubleValueForKey:kModelVersionUpReleaseTime];
        self.downloadUrl = [dict stringValueForKey:kModelVersionUpDownloadUrl];
        self.app = [dict stringValueForKey:kModelVersionUpApp];
        self.iDProperty = [dict doubleValueForKey:kModelVersionUpId];
        self.bundleId = [dict stringValueForKey:kModelVersionUpBundleId];
        self.terminalType = [dict doubleValueForKey:kModelVersionUpTerminalType];
        self.iDPropertyDescription = [dict stringValueForKey:kModelVersionUpDescription];
        self.versionType = [dict doubleValueForKey:kModelVersionUpVersionType];
        self.versionNumber = [dict stringValueForKey:kModelVersionUpVersionNumber];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.releaseTime] forKey:kModelVersionUpReleaseTime];
    [mutableDict setValue:self.downloadUrl forKey:kModelVersionUpDownloadUrl];
    [mutableDict setValue:self.app forKey:kModelVersionUpApp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelVersionUpId];
    [mutableDict setValue:self.bundleId forKey:kModelVersionUpBundleId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.terminalType] forKey:kModelVersionUpTerminalType];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelVersionUpDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.versionType] forKey:kModelVersionUpVersionType];
    [mutableDict setValue:self.versionNumber forKey:kModelVersionUpVersionNumber];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
