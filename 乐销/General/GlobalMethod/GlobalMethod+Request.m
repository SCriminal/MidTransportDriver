//
//  GlobalMethod+Request.m
//中车运
//
//  Created by 隋林栋 on 2017/2/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod+Request.h"
#import "RequestApi+UserApi.h"
#import "VersionUpView.h"
#import "RequestApi+UserApi.h"
#import "RequestApi+Dictionary.h"

//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
#import "ModelVersionUp.h"

@implementation GlobalMethod (Request)
#pragma mark read Local data
+ (NSDictionary *)readLocalRequestData:(NSString *)key
{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:key ofType:@".json"];
    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithContentsOfFile:strPath] options:NSJSONReadingMutableContainers error:nil];
}
#pragma mark request

//请求bind device token
+ (void)requestBindDeviceToken{
    if ([self isLoginSuccess]) {
        __block BOOL isSuccess = NO;
        if (!isSuccess) {
            [CloudPushSDK bindAccount:strDotF([GlobalData sharedInstance].GB_UserModel.cellPhone) withCallback:^(CloudPushCallbackResult *res) {
                if (res.success) {
                    isSuccess = YES;
                }
            }];
        }
        [RequestApi requestBindDeviceIdWithDeviceID:nil delegate:nil success:nil failure:nil];
    }
    
}
//request package type
+ (void)requestPackageType{
    [RequestApi requestPackageTypeWithDelegate:nil success:nil failure:nil];
}
//request version
+ (void)requestVersion:(void(^)(void))blockSuccess{

    [RequestApi requestVersionWithDelegate:nil success:^(NSDictionary *response, id mark) {
        ModelVersionUp * modelVersion = [GlobalMethod exchangeDicToModel:response modelName:@"ModelVersionUp"];
        if (modelVersion.versionNumber.doubleValue) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            VersionUpView *view = [VersionUpView sharedInstance];
            [view resetViewWithModel:modelVersion];
            view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [window addSubview:view];
        }else{
            if (blockSuccess) {
                blockSuccess();
            }
        }
    } failure:^(NSString *errorStr, id mark) {

    }];
}

//extend token time
+ (void)requestExtendToken{
    [RequestApi requestExtendTokenSuccess:nil failure:nil];
}


@end
