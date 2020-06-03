//
//  ModelAliClient_Base.h
//
//  Created by sld s on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAliClient_Base : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *securityToken;
@property (nonatomic, strong) NSString *expiration;
@property (nonatomic, strong) NSString *accessKeySecret;
@property (nonatomic, strong) NSString *accessKeyId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
