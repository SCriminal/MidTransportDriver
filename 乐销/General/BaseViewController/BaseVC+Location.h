//
//  BaseVC+Location.h
//中车运
//
//  Created by 隋林栋 on 2017/7/4.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface BaseVC (Location)<AMapSearchDelegate>

#pragma mark 获取位置
- (void)initLocation;
#pragma mark sub use
- (void)fetchLocation:(CLLocation *)loc;
- (void)fetchAddress:(ModelAddress *)clPlace;

/**
 根据省市区获取经纬度
 
 @param addressStr 省市区
 @param Coordinate2DBlock 经纬度Block
 */
-(void)fetchCoordinate2DFromAddress:(NSString *)addressStr coordinate2D:(void(^)(CLLocationCoordinate2D coordinate2D))Coordinate2DBlock;

/**
 根据经纬度获取地址信息
 
 @param coordinate2D 经纬度
 @param addressBlock 地址信息回调
 */
-(void)fetchAddressFromCoordinate2D:(CLLocationCoordinate2D )coordinate2D coordinate2D:(void(^)(AMapAddressComponent *))addressBlock;

@end

