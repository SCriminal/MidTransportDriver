//
//  GlobalData.h
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//公司model
#import "ModelCompany.h"

//仅在appdelegate里赋值，无需做成实例变量
extern UINavigationController *GB_Nav;//全局导航条
//extern float GB_StartYCoordinate;//起始Y坐标

/*
 GB_UserName,GB_Pwd,GB_Permission会出现多次值的更改，所以要做成实例变量，可调用set方法来改变值
 这样可以避免写太多的alloc和release
 例如：要给GB_UserName重新赋值，[GB_UserName release];GB_UserName = nil;GB_UserName=[[NSString alloc] initWithString:@"aaa"];
 现在只需要这样调用[[GlobalData sharedGlobalData] setGB_UserName:@"aaa"];
 */

@interface GlobalData : NSObject

//单例
+ (GlobalData *)sharedInstance;

@property (nonatomic, strong) ModelBaseInfo * GB_UserModel;//用户模型
@property (nonatomic, strong) NSString * GB_Key;//登陆成功key
@property (nonatomic, strong) NoticeView * GB_NoticeView;//global notice view
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;//状态栏类型
@property (nonatomic, assign) BOOL statusHidden;//状态栏隐藏状态
@property (nonatomic, assign) BOOL isKeyboardShow;//键盘显示
@property (nonatomic, assign) BOOL isLoginAnimation;//正在跳转登录

@property (nonatomic, strong) NSMutableArray *aryLocations;//地理位置
@property (nonatomic, assign) BOOL isShowMapView;

+ (void)saveUserModel;
@end
