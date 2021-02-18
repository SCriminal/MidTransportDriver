//
//  CarHelper.m
//  Driver
//
//  Created by 隋林栋 on 2021/2/18.
//Copyright © 2021 ping. All rights reserved.
//

#import "CarHelper.h"

@implementation CarHelper

+ (NSString *)exchangeVehicleType:(NSString *)identity{
    NSArray * ary = [GlobalMethod readAry:LOCAL_CAR_TYPE modelName:@"ModelIntegralProduct"];
    for (ModelIntegralProduct * dic in ary) {
        if (identity.doubleValue == dic.iDProperty) {
            return dic.name;
        }
    }
    return nil;
}
+ (NSNumber *)exchangeVehicleTypeWithName:(NSString *)name{
    NSArray * ary = [GlobalMethod readAry:LOCAL_CAR_TYPE modelName:@"ModelIntegralProduct"];
    for (ModelIntegralProduct * item in ary) {
        if ([name isEqualToString:item.name]) {
            return NSNumber.dou(item.iDProperty);
        }
    }
    return nil;
}
+ (NSString *)exchangeLicenseType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"LicenseType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}
+ (NSString *)exchangeEnergeyType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"EnergyType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}
+ (NSNumber *)exchangeEnergeyTypeWithName:(NSString *)name{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"EnergyType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if ([name isEqualToString:[dic stringValueForKey:@"label"]]) {
            return [dic numberValueForKey:@"value"];
        }
    }
    return nil;
}

@end
