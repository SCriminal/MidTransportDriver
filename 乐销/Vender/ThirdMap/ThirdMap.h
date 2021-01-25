//
//  ThirdMap.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/7/1.
//Copyright © 2020 ping. All rights reserved.

#import <Foundation/Foundation.h>

@interface ThirdMap : NSObject
+(UIAlertController *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)coord currentLocation:(CLLocationCoordinate2D)currentCoord;
@end
