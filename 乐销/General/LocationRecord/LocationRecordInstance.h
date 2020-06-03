//
//  LocationRecordInstance.h
//  Driver
//
//  Created by 隋林栋 on 2019/6/5.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationRecordInstance : NSObject
@property (nonatomic, strong) AMapLocationManager *locationManager;//获取地址

DECLARE_SINGLETON(LocationRecordInstance)

//start
- (void)startRecord;
- (void)upLocation:(void (^)(void))successBlock;


#pragma mark 交通部
-(void)startLocationWithShippingNoteInfos:(NSArray *)shippingNoteInfos listener:(void(^)(id model, NSError *error))listener;
-(void)stopLocationWithShippingNoteInfos:(NSArray *)shippingNoteInfos listener:(void(^)(id model, NSError *error))listener;
@end
