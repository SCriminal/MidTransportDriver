//
//  TimerHelper.m
//  Driver
//
//  Created by 隋林栋 on 2021/3/12.
//Copyright © 2021 ping. All rights reserved.
//

#import "TimerHelper.h"
//request
#import "RequestDriver2.h"
#import "LocationRecordInstance.h"

@implementation TimerHelper
SYNTHESIZE_SINGLETONE_FOR_CLASS(TimerHelper)

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timerStop) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timerStart) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}
- (void)timerStart{
    if (self.timer == nil) {
        self.timer = [YYTimer timerWithTimeInterval:60 target:self selector:@selector(timerRun) repeats:true];
    }
    [self timerRun];
    [[LocationRecordInstance sharedInstance]requestUpuserLocation];
}
- (void)timerStop{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerRun{
    if ([GlobalMethod isLoginSuccess]) {
        [RequestApi requestLocationOrderDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
            [GlobalMethod writeStr:[response stringValueForKey:@"orderNumber"]  forKey:LOCAL_TRANSPORT_NUMBER];
            [GlobalMethod writeStr:[response stringValueForKey:@"plateNumber"] forKey:LOCAL_PLATE_NUMBER];

        }failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        }];
    }
   
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
