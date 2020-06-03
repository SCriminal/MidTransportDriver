//
//  WXApiManager.h
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/7/14.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
//model
#import "ModelWXApiReq.h"


@interface WXApiManager : NSObject<WXApiDelegate>

//单例
+ (instancetype)sharedManager;
//注册
+ (void)registerApp;

@end
