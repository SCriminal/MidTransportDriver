//
//  ModelMotrocadeList.h
//
//  Created by 林栋 隋 on 2019/6/13
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelMotrocadeList : NSObject

@property (nonatomic, strong) NSString *entName;
@property (nonatomic, strong) NSString *vehicleNumber;
@property (nonatomic, assign) double entId;
@property (nonatomic, assign) double date;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *attachStatusShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
