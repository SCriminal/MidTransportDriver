//
//  TimerHelper.h
//  Driver
//
//  Created by 隋林栋 on 2021/3/12.
//Copyright © 2021 ping. All rights reserved.

#import <Foundation/Foundation.h>
#import "YYTimer.h"
@interface TimerHelper : NSObject
//单例
DECLARE_SINGLETON(TimerHelper)
@property (nonatomic, strong) YYTimer *timer;
- (void)timerStart;
- (void)timerStop;
- (void)timerRun;
@end
