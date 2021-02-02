//
//  ModelProblemHistoryItem.h
//
//  Created by 林栋 隋 on 2021/2/2
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelProblemHistoryItem : NSObject

@property (nonatomic, assign) double problemType;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double replyTime;
@property (nonatomic, assign) double submitterTime;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) id replyUrl1;
@property (nonatomic, assign) id replyUrl3;
@property (nonatomic, assign) double submitterEmpId;
@property (nonatomic, assign) double replyEmpId;
@property (nonatomic, strong) NSString *submitterEmpName;
@property (nonatomic, assign) id replyMessage;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) id submitUrl3;
@property (nonatomic, assign) id submitUrl2;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) id submitUrl1;
@property (nonatomic, assign) double submitterId;
@property (nonatomic, assign) id replyUrl2;
@property (nonatomic, assign) id replyEmpName;
@property (nonatomic, strong) NSString *submitterName;
@property (nonatomic, assign) id waybillNumber;
@property (nonatomic, strong) NSString *internalBaseClassDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
