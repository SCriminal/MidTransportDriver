//
//  ModelSignItem.h
//
//  Created by 林栋 隋 on 2021/2/2
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelSignItem : NSObject

@property (nonatomic, assign) double pointTime;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, assign) double point;
@property (nonatomic, assign) double direction;

@property (nonatomic, strong) NSString *strWeekShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
