//
//  ModelCreditListItem.m
//
//  Created by 林栋 隋 on 2021/2/23
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelCreditListItem.h"


NSString *const kModelCreditListItemCreateTime = @"createTime";
NSString *const kModelCreditListItemPointType = @"pointType";
NSString *const kModelCreditListItemUserId = @"userId";
NSString *const kModelCreditListItemPoint = @"point";


@interface ModelCreditListItem ()
@end

@implementation ModelCreditListItem

@synthesize createTime = _createTime;
@synthesize pointType = _pointType;
@synthesize userId = _userId;
@synthesize point = _point;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.createTime = [dict doubleValueForKey:kModelCreditListItemCreateTime];
            self.pointType = [dict doubleValueForKey:kModelCreditListItemPointType];
            self.userId = [dict doubleValueForKey:kModelCreditListItemUserId];
            self.point = [dict doubleValueForKey:kModelCreditListItemPoint];
        // 1认证评分 2.运单完成 3运单评价 4.系统干预
        switch ((int)self.pointType) {
            case 1:
                self.typeShow = @"认证评分";
                break;
            case 2:
                self.typeShow = @"运单完成";
                break;
            case 3:
                self.typeShow = @"运单评价";
                break;
            case 4:
                self.typeShow = @"系统干预";
                break;
            default:
                break;
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelCreditListItemCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pointType] forKey:kModelCreditListItemPointType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelCreditListItemUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.point] forKey:kModelCreditListItemPoint];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
