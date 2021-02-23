//
//  ModelCreditListItem.h
//
//  Created by 林栋 隋 on 2021/2/23
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCreditListItem : NSObject

@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double pointType;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double point;
@property (nonatomic, strong) NSString *typeShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
