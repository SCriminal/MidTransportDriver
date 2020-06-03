//
//  GlobalMethod+Version.h
//中车运
//
//  Created by 隋林栋 on 2016/12/15.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "GlobalMethod.h"
//model
#import "DataModels.h"

@interface GlobalMethod (Version)

//注销
+ (void)logoutSuccess;
//清除全局数据
+ (void)clearUserInfo;
//登录
+ (void)requestLoginResponse:(NSDictionary *)response
                        mark:(id)mark
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure;
//重新登陆
+ (void)relogin;
//创建rootNav
+ (void)createRootNav;

//刷新tableviewVC
+ (void)refreshTabelVCWithView:(UIView *)view;
//是否可以侧滑
+ (BOOL)canLeftSlide;
// 异步执行
+ (void)asynthicBlock:(void (^)(void))block;
+ (void)mainQueueBlock:(void (^)(void))block;
+(void)applyRepeatNum:(int)num block:(void(^)(size_t time))block;

//跳转到指定根视图
+(void)jumpToRootVC:(NSUInteger)index  animated:(BOOL)animated;

//跳转到订单
+ (void)jumpToOrderDetailVC:(double )orderID;
+ (void)jumpToOrderList;
+ (void)jumpToMsgVC;
@end
