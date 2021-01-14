//
//  OrcHelper.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/14.
//Copyright © 2021 ping. All rights reserved.

#import <Foundation/Foundation.h>

@interface OrcHelper : NSObject
+ (void)orc:(NSString *)imageurl delegate:(nullable id <NSURLSessionDelegate>)delegate block:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler ;

@end
