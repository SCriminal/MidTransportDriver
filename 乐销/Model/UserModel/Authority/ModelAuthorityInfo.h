//
//  ModelAuthorityInfo.h
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthorityInfo : NSObject

@property (nonatomic, assign) double driverReviewTime;
@property (nonatomic, assign) double driverSubmitTime;
@property (nonatomic, assign) double vehicleReviewTime;
@property (nonatomic, assign) double vehicleSubmitTime;
@property (nonatomic, assign) double bizSubmitTime;
@property (nonatomic, assign) double driverStatus;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double vehicleStatus;
@property (nonatomic, assign) double bizReviewTime;
@property (nonatomic, assign) double bizStatus;

@property (nonatomic, strong) NSString * bizDescription;
@property (nonatomic,  strong) NSString * driverDescription;
@property (nonatomic,  strong) NSString * vehicleDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
- (BOOL)isAuthed;
+(UIColor *)statusColor:(int)status;
+(NSString *)statusTitle:(int)status;
@end
