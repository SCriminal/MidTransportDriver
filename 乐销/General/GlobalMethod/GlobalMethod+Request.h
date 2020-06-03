//
//  GlobalMethod+Request.h
//中车运
//
//  Created by 隋林栋 on 2017/2/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod.h"

@interface GlobalMethod (Request)
#pragma mark read Local data
+ (NSDictionary *)readLocalRequestData:(NSString *)key;

#pragma mark request
//版本判断
+ (void)requestVersion:(void(^)(void))blockSuccess;
//请求bind device token
+ (void)requestBindDeviceToken;
//请求bind undevice token
+ (void)requestUnBindDeviceToken;
//request package type
+ (void)requestPackageType;
//extend token time
+ (void)requestExtendToken;
@end
