//
//  ModelAttaceedCompany.h
//
//  Created by 林栋 隋 on 2019/12/11
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAttaceedCompany : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double entId;
@property (nonatomic, assign) double date;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSString *vehicleNumber;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double applyTime;

@property (nonatomic, readonly) NSString *codeShow;
@property (nonatomic, readonly) NSString *nameShow;
@property (nonatomic, assign) BOOL isAttached;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
