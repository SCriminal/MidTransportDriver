//
//  LocationEagleInstance.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/28.
//Copyright © 2019 ping. All rights reserved.

#import <Foundation/Foundation.h>

@interface LocationEagleInstance : NSObject

DECLARE_SINGLETON(LocationEagleInstance)
//start
- (void)startRecord;
//- (void)upLocation:(void (^)(void))successBlock;

@end
