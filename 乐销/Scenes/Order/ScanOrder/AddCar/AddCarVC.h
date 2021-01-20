//
//  AddCarVC.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface AddCarVC : BaseTableVC

@property (nonatomic, assign) double carID;

#pragma mark exchange type
+ (NSString *)exchangeVehicleType:(NSString *)identity;
+ (NSString *)exchangeLicenseType:(NSString *)identity;
+ (NSString *)exchangeEnergeyType:(NSString *)identity;
+ (NSNumber *)exchangeEnergeyTypeWithName:(NSString *)name;
+ (NSNumber *)exchangeVehicleTypeWithName:(NSString *)name;
@end
