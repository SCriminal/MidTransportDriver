//
//  ModelAccessoryItem.m
//
//  Created by 林栋 隋 on 2019/7/12
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAccessoryItem.h"


NSString *const kModelAccessoryItemFormId = @"formId";
NSString *const kModelAccessoryItemFileName = @"fileName";
NSString *const kModelAccessoryItemFileUrl = @"fileUrl";
NSString *const kModelAccessoryItemFormType = @"formType";


@interface ModelAccessoryItem ()
@end

@implementation ModelAccessoryItem

@synthesize formId = _formId;
@synthesize fileName = _fileName;
@synthesize fileUrl = _fileUrl;
@synthesize formType = _formType;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.formId = [dict doubleValueForKey:kModelAccessoryItemFormId];
            self.fileName = [dict stringValueForKey:kModelAccessoryItemFileName];
            self.fileUrl = [dict stringValueForKey:kModelAccessoryItemFileUrl];
            self.formType = [dict doubleValueForKey:kModelAccessoryItemFormType];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.formId] forKey:kModelAccessoryItemFormId];
    [mutableDict setValue:self.fileName forKey:kModelAccessoryItemFileName];
    [mutableDict setValue:self.fileUrl forKey:kModelAccessoryItemFileUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.formType] forKey:kModelAccessoryItemFormType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
