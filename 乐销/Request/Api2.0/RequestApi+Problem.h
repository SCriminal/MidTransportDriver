//
//  RequestApi+Problem.h
//  Driver
//
//  Created by 隋林栋 on 2021/2/2.
//  Copyright © 2021 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Problem)
/**
提交（司机）
*/
+(void)requestProblemWithProblemtype:(double)problemType
                type:(double)type
                description:(NSString *)description
                submitUrl1:(NSString *)submitUrl1
                submitUrl2:(NSString *)submitUrl2
                submitUrl3:(NSString *)submitUrl3
                waybillNumber:(NSString *)waybillNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
