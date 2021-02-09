//
//  ModelComment.h
//
//  Created by 林栋 隋 on 2021/1/25
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelComment : NSObject

@property (nonatomic, assign) double finishWaybillSum;
@property (nonatomic, assign) double score;
@property (nonatomic, strong) NSString *cellphone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *praiseRateShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
