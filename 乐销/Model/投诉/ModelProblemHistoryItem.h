//
//  ModelProblemHistoryItem.h
//
//  Created by 林栋 隋 on 2021/2/3
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelProblemHistoryItem : NSObject

@property (nonatomic, assign) double problemType;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double replyTime;
@property (nonatomic, assign) double submitterTime;
@property (nonatomic, assign) double score;
@property (nonatomic, strong) NSString *replyUrl1;
@property (nonatomic, strong) NSString *replyUrl3;
@property (nonatomic, assign) double submitterEmpId;
@property (nonatomic, assign) double replyEmpId;
@property (nonatomic, strong) NSString *submitterEmpName;
@property (nonatomic, strong) NSString *replyMessage;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *submitUrl3;
@property (nonatomic, strong) NSString *submitUrl2;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *submitUrl1;
@property (nonatomic, assign) double submitterId;
@property (nonatomic, strong) NSString *replyUrl2;
@property (nonatomic, strong) NSString *replyEmpName;
@property (nonatomic, strong) NSString *submitterName;
@property (nonatomic, strong) NSString *waybillNumber;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSMutableArray *urls;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
