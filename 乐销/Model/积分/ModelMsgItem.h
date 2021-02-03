//
//  ModelMsgItem.h
//
//  Created by 林栋 隋 on 2021/2/3
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelMsgItem : NSObject

@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) double isRead;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, assign) double pushTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
