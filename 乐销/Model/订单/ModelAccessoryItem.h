//
//  ModelAccessoryItem.h
//
//  Created by 林栋 隋 on 2019/7/12
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAccessoryItem : NSObject

@property (nonatomic, assign) double formId;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *fileUrl;
@property (nonatomic, assign) double formType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
