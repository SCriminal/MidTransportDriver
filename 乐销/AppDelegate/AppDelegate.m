

#import "AppDelegate.h"
//地图api
#import <AMapFoundationKit/AMapFoundationKit.h>
//全局方法
#import "GlobalMethod+Version.h"

//UNUserNotification
#import <UserNotifications/UserNotifications.h>
//微信
#import "WXApi.h"
//微博
#import "WeiboSDK.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
//Wechat
#import "WXApiManager.h"
//crash analyse
#import "ModelApns.h"
//top alert view
#import "TopAlertView.h"
//flash login
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
//location record
#import "LocationRecordInstance.h"
//location
#import "LocationRecordInstance.h"
//bug
#import <Bugly/Bugly.h>


@interface AppDelegate ()<UIAlertViewDelegate,UNUserNotificationCenterDelegate,WXApiDelegate,WeiboSDKDelegate>{

}

@end

@implementation AppDelegate
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //create root nav
    [GlobalMethod createRootNav];
    //注册通知
    [self registerForRemoteNotification];
    //配置 app id
    [self configureAPIKey];
    //quick login
    [self configLogin];

    return YES;
}
//config flash login
- (void)configLogin{
    //􏱲􏱳􏱴􏱵
    [CLShanYanSDKManager initWithAppId:FLASH_ID AppKey:FLASH_KEY
                               timeOut:4 complete:nil];
}
//注册通知
-(void)registerForRemoteNotification {
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [GlobalMethod mainQueueBlock:^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                }];
            }
        }];
    }else{
        if (isIOS8) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
       
      }
}

#pragma mark 配置appid
- (void)configureAPIKey
{
    //地图
    [AMapServices sharedServices].apiKey = MAPID;
    //注册微信ID
    [WXApiManager registerApp];
    //配置阿里推送
    //阿里云推送
    [CloudPushSDK autoInit:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@", [CloudPushSDK getDeviceId]);
            [GlobalMethod requestBindDeviceToken];
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
        //开启地理位置定位
    [[LocationRecordInstance sharedInstance]startRecord];
    //bug
    [Bugly startWithAppId:@"af4bcb1f7d"];


}

#pragma mark 推送
// 将得到的deviceTokern传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * strToken =[[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" "withString:@""];;
    NSLog(@"strToken:%@",strToken);
//    return;
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            [GlobalMethod requestBindDeviceToken];
            NSLog(@"Register deviceToken success.");
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
   
    
}

#pragma mark 微信
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"weixin"]||[url.host isEqualToString:@"wechat"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"weixin"]||[url.host isEqualToString:@"wechat"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return [WeiboSDK handleOpenURL:url delegate:self];
}

//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}


#pragma mark -- WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博分享失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博授权成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博授权失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}
#pragma mark推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"didReceiveRemoteNotification ");

    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"didReceiveRemoteNotification fetchCompletionHandler");
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}

#pragma mark app 状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //record inter background time
    [GlobalMethod writeStr:[GlobalMethod exchangeDate:[NSDate date] formatter:TIME_MIN_SHOW] forKey:LOCAL_ENTER_BACK_GROUND];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //请求版本
    [GlobalMethod requestVersion:nil];
    [[LocationRecordInstance sharedInstance]upLocation:nil];
    //清空角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
//    if (_mainController) {
//        [_mainController didReceiveLocalNotification:notification];
//    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{

    //消息进入 直接跳转
    ModelApns * model = [ModelApns modelObjectWithDictionary:response.notification.request.content.userInfo];
    if (model.type == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
        [GlobalMethod jumpToOrderList];
    }else if(model.type == 3){
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_MSG_REFERSH object:nil];
        [GlobalMethod jumpToMsgVC];
    }

    completionHandler();
}

- (void)easemobApplication:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    ModelApns * model = [ModelApns modelObjectWithDictionary:userInfo];
    [[TopAlertView sharedInstance]showWithModel:model];
    if (model.type == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];

    }else if(model.type == 3){
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_MSG_REFERSH object:nil];

    }

    //进行消息处理 通过字段进行区分是否是即时通讯消息
    //如果是leancloud 来的消息
    //阿里回执
    [CloudPushSDK sendNotificationAck:userInfo];
    
    //    NSString * strJson = [GlobalMethod exchangeDicToJson:userInfo];

}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    [WXApi handleOpenUniversalLink:userActivity delegate:self];
    return true;
}

@end
