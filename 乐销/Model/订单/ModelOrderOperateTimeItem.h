//
//  ModelOrderOperateTimeItem.h
//
//  Created by sld s on 2019/5/24
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelOrderOperateTimeItem : NSObject

@property (nonatomic, assign) double formId;
@property (nonatomic, assign) double stateTime;
@property (nonatomic, assign) double src;
@property (nonatomic, assign) double formType;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *operatorName;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double operatorEmpId;
@property (nonatomic, assign) double formState;
@property (nonatomic, assign) double stateSort;
@property (nonatomic, strong) NSString *operatorEmpName;
@property (nonatomic, assign) double operatorId;
@property (nonatomic, assign) double lng;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
