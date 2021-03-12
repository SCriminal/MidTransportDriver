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
NSString *const kModelCommentScore1Qty = @"score1Qty";
NSString *const kModelCommentScore4Qty = @"score4Qty";
NSString *const kModelCommentScore3Qty = @"score3Qty";
NSString *const kModelCommentScore2Qty = @"score2Qty";
NSString *const kModelCommentScore5Qty = @"score5Qty";

@interface ModelComment ()
@property (nonatomic, assign) double score1Qty;
@property (nonatomic, assign) double score4Qty;
@property (nonatomic, assign) double score3Qty;
@property (nonatomic, assign) double score2Qty;
@property (nonatomic, assign) double score5Qty;
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
        self.score1Qty = [dict doubleValueForKey:kModelCommentScore1Qty];
        self.score4Qty = [dict doubleValueForKey:kModelCommentScore4Qty];
        self.score3Qty = [dict doubleValueForKey:kModelCommentScore3Qty];
        self.score2Qty = [dict doubleValueForKey:kModelCommentScore2Qty];
        self.score5Qty = [dict doubleValueForKey:kModelCommentScore5Qty];

        double num = self.score5Qty;
        double numAll = (self.score1Qty+self.score2Qty+self.score3Qty+self.score4Qty+self.score5Qty);
        self.praiseRateShow = numAll?[NSString stringWithFormat:@"%.f%%",round(num/numAll*100.0)]:@"0%";
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
    [mutableDict setValue:[NSNumber numberWithDouble:self.score1Qty] forKey:kModelCommentScore1Qty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score4Qty] forKey:kModelCommentScore4Qty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score3Qty] forKey:kModelCommentScore3Qty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score2Qty] forKey:kModelCommentScore2Qty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score5Qty] forKey:kModelCommentScore5Qty];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
