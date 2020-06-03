//
//  ModelWXApiReq.h
//
//  Created by 京涛 刘 on 2017/7/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelWXApiReq : NSObject

@property (nonatomic, strong) NSString *package;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *noncestr;
@property (nonatomic, strong) NSString *partnerid;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *sign;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
