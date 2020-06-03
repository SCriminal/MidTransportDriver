//
//  LocationEagleInstance.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/28.
//Copyright © 2019 ping. All rights reserved.
//

#import "LocationEagleInstance.h"
//猎鹰
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapTrackKit/AMapTrackKit.h>

@interface LocationEagleInstance ()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapTrackManager *trackManager;

@end
@implementation LocationEagleInstance
#pragma mark single instance
SYNTHESIZE_SINGLETONE_FOR_CLASS(LocationEagleInstance)

#pragma mark init
- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeSelfModelChange) name:NOTICE_SELFMODEL_CHANGE object:nil];
    }
    return self;
}

- (AMapTrackManager *)trackManager{
    if (!_trackManager) {
        AMapTrackManagerOptions *option = [[AMapTrackManagerOptions alloc] init];
        option.serviceID = @"52936"; //Service ID 需要根据需要进行修改
        //初始化AMapTrackManager
        _trackManager = [[AMapTrackManager alloc] initWithOptions:option];
        _trackManager.delegate = self;
        //配置定位属性
        [_trackManager setAllowsBackgroundLocationUpdates:YES];
        [_trackManager setPausesLocationUpdatesAutomatically:NO];
    }
    return _trackManager;
}

#pragma mark start
- (void)startRecord{
    [self.trackManager stopService];
    AMapTrackManagerServiceOption *serviceOption = [[AMapTrackManagerServiceOption alloc] init];
    serviceOption.terminalID = @"172903795"; //Terminal ID 需要根据需要进行修改
    [self.trackManager startServiceWithOptions:serviceOption];
    //开始采集定位点
    //    self.trackManager.trackID = @"20";
    [self.trackManager startGatherAndPack];
}
#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%s  %@",__func__,self.class);
}
- (void)noticeSelfModelChange{
    [self startRecord];
}



#pragma mark track delegate
- (void)onStartService:(AMapTrackErrorCode)errorCode {
    //开始service结果回调
    NSLog(@"sld onStartService");
}
- (void)onStopService:(AMapTrackErrorCode)errorCode {
    //结束service结果回调
    NSLog(@"sld onStopService");
}
- (void)onStartGatherAndPack:(AMapTrackErrorCode)errorCode {
    //开始采集结果回调
    NSLog(@"sld onStartGatherAndPack");
}
- (void)onStopGatherAndPack:(AMapTrackErrorCode)errorCode {
    //结束采集结果回调
    NSLog(@"sld onStopGatherAndPack");
}

@end
