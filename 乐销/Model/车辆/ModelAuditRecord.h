//
//  ModelAuditRecord.h
//
//  Created by 林栋 隋 on 2020/6/8
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuditRecord : NSObject

@property (nonatomic, strong) NSString *submitterName;
@property (nonatomic, assign) double state;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double submitterId;
@property (nonatomic, assign) double vehicleId;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double reviewerId;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
