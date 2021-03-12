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
    
}
- (void)timerStop{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerRun{
    if ([GlobalMethod isLoginSuccess]) {
        [RequestApi requestOrderListWithPage:1 count:20 orderNumber:nil shipperName:nil plateNumber:nil driverName:nil                       startTime:0
                                     endTime:0
                                orderStatues:@"3"
                                    delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelTransportOrder"];
            if (aryRequest.count>0 ) {
                ModelTransportOrder * order = aryRequest.firstObject;
                [GlobalMethod writeModel:order key:LOCAL_TRANSPORT_LOADING];
            }
        }failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        }];
    }
   
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
