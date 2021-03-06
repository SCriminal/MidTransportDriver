//
//  CLCompleteResult.h
//  CL_ShanYanSDK
//
//  Created by wanglijun on 2018/10/29.
//  Copyright © 2018 wanglijun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CLSDKInitStutas) {
    CLSDKInitStutasERRORIniting,//失败-未完成（正在进行中）
    CLSDKInitStutasERRORTimeOut,//失败-超时
    CLSDKInitStutasERRORFailure,//失败-出错
    CLSDKInitStutasSUCCESS,//成功
};

NS_ASSUME_NONNULL_BEGIN

@class CLCompleteResult;
typedef void(^CLComplete)(CLCompleteResult * completeResult);

@interface CLCompleteResult : NSObject
@property (nonatomic,assign)NSInteger code;//SDK外层code
@property (nonatomic,nullable,copy)NSString * message;//SDK外层msg
@property (nonatomic,nullable,copy)NSDictionary * data;//SDK外层data
@property (nonatomic,nullable,strong)NSError * error;//SDK内层Error

//@property (nonatomic,nullable,strong)id clModel;

+(instancetype)cl_CompleteWithCode:(NSInteger)code message:(NSString *)message data:(nullable NSDictionary *)data  error:(nullable NSError *)error;
@end

NS_ASSUME_NONNULL_END
