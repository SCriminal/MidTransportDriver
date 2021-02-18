//
//  CarHelper.h
//  Driver
//
//  Created by 隋林栋 on 2021/2/18.
//Copyright © 2021 ping. All rights reserved.

#import <Foundation/Foundation.h>

@interface CarHelper : NSObject
#pragma mark exchange type
+ (NSString *)exchangeVehicleType:(NSString *)identity;
+ (NSString *)exchangeLicenseType:(NSString *)identity;
+ (NSString *)exchangeEnergeyType:(NSString *)identity;
+ (NSNumber *)exchangeEnergeyTypeWithName:(NSString *)name;
+ (NSNumber *)exchangeVehicleTypeWithName:(NSString *)name;
@end
