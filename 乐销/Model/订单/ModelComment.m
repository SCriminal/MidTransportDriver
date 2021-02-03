//
//  ModelComment.m
//
//  Created by 林栋 隋 on 2021/1/25
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelComment.h"


NSString *const kModelCommentFinishWaybillSum = @"finishWaybillSum";
NSString *const kModelCommentScore = @"score";
NSString *const kModelCommentCellphone = @"cellphone";
NSString *const kModelCommentName = @"realName";
NSString *const kModelCommentUserId = @"userId";


@interface ModelComment ()
@end

@implementation ModelComment

@synthesize finishWaybillSum = _finishWaybillSum;
@synthesize score = _score;
@synthesize cellphone = _cellphone;
@synthesize name = _name;
@synthesize userId = _userId;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.finishWaybillSum = [dict doubleValueForKey:kModelCommentFinishWaybillSum];
            self.score = [dict doubleValueForKey:kModelCommentScore];
            self.cellphone = [dict stringValueForKey:kModelCommentCellphone];
            self.name = [dict stringValueForKey:kModelCommentName];
            self.userId = [dict doubleValueForKey:kModelCommentUserId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.finishWaybillSum] forKey:kModelCommentFinishWaybillSum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelCommentScore];
    [mutableDict setValue:self.cellphone forKey:kModelCommentCellphone];
    [mutableDict setValue:self.name forKey:kModelCommentName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelCommentUserId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
