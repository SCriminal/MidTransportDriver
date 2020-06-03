//
//  ModelAccountList.h
//
//  Created by sld s on 2019/6/6
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAccountList : NSObject

@property (nonatomic, assign) double waybillId;
@property (nonatomic, assign) double dataState;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *billNumber;
@property (nonatomic, assign) double entId;
@property (nonatomic, strong) NSString *waybillNumber;
@property (nonatomic, assign) double fee;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
