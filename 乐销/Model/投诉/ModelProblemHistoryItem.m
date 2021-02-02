//
//  ModelProblemHistoryItem.m
//
//  Created by 林栋 隋 on 2021/2/2
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelProblemHistoryItem.h"


NSString *const kModelProblemHistoryItemProblemType = @"problemType";
NSString *const kModelProblemHistoryItemStatus = @"status";
NSString *const kModelProblemHistoryItemReplyTime = @"replyTime";
NSString *const kModelProblemHistoryItemSubmitterTime = @"submitterTime";
NSString *const kModelProblemHistoryItemScore = @"score";
NSString *const kModelProblemHistoryItemReplyUrl1 = @"replyUrl1";
NSString *const kModelProblemHistoryItemReplyUrl3 = @"replyUrl3";
NSString *const kModelProblemHistoryItemSubmitterEmpId = @"submitterEmpId";
NSString *const kModelProblemHistoryItemReplyEmpId = @"replyEmpId";
NSString *const kModelProblemHistoryItemSubmitterEmpName = @"submitterEmpName";
NSString *const kModelProblemHistoryItemReplyMessage = @"replyMessage";
NSString *const kModelProblemHistoryItemType = @"type";
NSString *const kModelProblemHistoryItemSubmitUrl3 = @"submitUrl3";
NSString *const kModelProblemHistoryItemSubmitUrl2 = @"submitUrl2";
NSString *const kModelProblemHistoryItemNumber = @"number";
NSString *const kModelProblemHistoryItemSubmitUrl1 = @"submitUrl1";
NSString *const kModelProblemHistoryItemSubmitterId = @"submitterId";
NSString *const kModelProblemHistoryItemReplyUrl2 = @"replyUrl2";
NSString *const kModelProblemHistoryItemReplyEmpName = @"replyEmpName";
NSString *const kModelProblemHistoryItemSubmitterName = @"submitterName";
NSString *const kModelProblemHistoryItemWaybillNumber = @"waybillNumber";
NSString *const kModelProblemHistoryItemDescription = @"description";


@interface ModelProblemHistoryItem ()
@end

@implementation ModelProblemHistoryItem

@synthesize problemType = _problemType;
@synthesize status = _status;
@synthesize replyTime = _replyTime;
@synthesize submitterTime = _submitterTime;
@synthesize score = _score;
@synthesize replyUrl1 = _replyUrl1;
@synthesize replyUrl3 = _replyUrl3;
@synthesize submitterEmpId = _submitterEmpId;
@synthesize replyEmpId = _replyEmpId;
@synthesize submitterEmpName = _submitterEmpName;
@synthesize replyMessage = _replyMessage;
@synthesize type = _type;
@synthesize submitUrl3 = _submitUrl3;
@synthesize submitUrl2 = _submitUrl2;
@synthesize number = _number;
@synthesize submitUrl1 = _submitUrl1;
@synthesize submitterId = _submitterId;
@synthesize replyUrl2 = _replyUrl2;
@synthesize replyEmpName = _replyEmpName;
@synthesize submitterName = _submitterName;
@synthesize waybillNumber = _waybillNumber;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.problemType = [dict doubleValueForKey:kModelProblemHistoryItemProblemType];
            self.status = [dict doubleValueForKey:kModelProblemHistoryItemStatus];
            self.replyTime = [dict doubleValueForKey:kModelProblemHistoryItemReplyTime];
            self.submitterTime = [dict doubleValueForKey:kModelProblemHistoryItemSubmitterTime];
            self.score = [dict doubleValueForKey:kModelProblemHistoryItemScore];
            self.replyUrl1 = [dict objectForKey:kModelProblemHistoryItemReplyUrl1];
            self.replyUrl3 = [dict objectForKey:kModelProblemHistoryItemReplyUrl3];
            self.submitterEmpId = [dict doubleValueForKey:kModelProblemHistoryItemSubmitterEmpId];
            self.replyEmpId = [dict doubleValueForKey:kModelProblemHistoryItemReplyEmpId];
            self.submitterEmpName = [dict stringValueForKey:kModelProblemHistoryItemSubmitterEmpName];
            self.replyMessage = [dict objectForKey:kModelProblemHistoryItemReplyMessage];
            self.type = [dict doubleValueForKey:kModelProblemHistoryItemType];
            self.submitUrl3 = [dict objectForKey:kModelProblemHistoryItemSubmitUrl3];
            self.submitUrl2 = [dict objectForKey:kModelProblemHistoryItemSubmitUrl2];
            self.number = [dict stringValueForKey:kModelProblemHistoryItemNumber];
            self.submitUrl1 = [dict objectForKey:kModelProblemHistoryItemSubmitUrl1];
            self.submitterId = [dict doubleValueForKey:kModelProblemHistoryItemSubmitterId];
            self.replyUrl2 = [dict objectForKey:kModelProblemHistoryItemReplyUrl2];
            self.replyEmpName = [dict objectForKey:kModelProblemHistoryItemReplyEmpName];
            self.submitterName = [dict stringValueForKey:kModelProblemHistoryItemSubmitterName];
            self.waybillNumber = [dict objectForKey:kModelProblemHistoryItemWaybillNumber];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelProblemHistoryItemDescription];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.problemType] forKey:kModelProblemHistoryItemProblemType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelProblemHistoryItemStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyTime] forKey:kModelProblemHistoryItemReplyTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitterTime] forKey:kModelProblemHistoryItemSubmitterTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelProblemHistoryItemScore];
    [mutableDict setValue:self.replyUrl1 forKey:kModelProblemHistoryItemReplyUrl1];
    [mutableDict setValue:self.replyUrl3 forKey:kModelProblemHistoryItemReplyUrl3];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitterEmpId] forKey:kModelProblemHistoryItemSubmitterEmpId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyEmpId] forKey:kModelProblemHistoryItemReplyEmpId];
    [mutableDict setValue:self.submitterEmpName forKey:kModelProblemHistoryItemSubmitterEmpName];
    [mutableDict setValue:self.replyMessage forKey:kModelProblemHistoryItemReplyMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelProblemHistoryItemType];
    [mutableDict setValue:self.submitUrl3 forKey:kModelProblemHistoryItemSubmitUrl3];
    [mutableDict setValue:self.submitUrl2 forKey:kModelProblemHistoryItemSubmitUrl2];
    [mutableDict setValue:self.number forKey:kModelProblemHistoryItemNumber];
    [mutableDict setValue:self.submitUrl1 forKey:kModelProblemHistoryItemSubmitUrl1];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitterId] forKey:kModelProblemHistoryItemSubmitterId];
    [mutableDict setValue:self.replyUrl2 forKey:kModelProblemHistoryItemReplyUrl2];
    [mutableDict setValue:self.replyEmpName forKey:kModelProblemHistoryItemReplyEmpName];
    [mutableDict setValue:self.submitterName forKey:kModelProblemHistoryItemSubmitterName];
    [mutableDict setValue:self.waybillNumber forKey:kModelProblemHistoryItemWaybillNumber];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelProblemHistoryItemDescription];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
