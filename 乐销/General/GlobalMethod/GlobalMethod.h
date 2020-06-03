//
//  GlobalMethod.h
//  米兰港
//
//  Created by 隋林栋 on 15/3/3.
//  Copyright (c) 2015年 Sl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class NSDictionary;

@interface GlobalMethod : NSObject



//解析错误信息
+ (NSString *)returnErrorMessage:(id)error;

//去掉空格
+ (NSString *)exchangeEmpty:(NSString *)str;
//去掉换行
+ (NSString *)exchangeBlack:(NSString *)str;
//处理小数点
+ (NSString *)exchangeNum:(double)num;

//转换为jsong
+ (NSString *)exchangeDicToJson:(id)object;
//转换为jsong
+ (NSString *)exchangeModelsToJson:(NSArray *)object;
//转换json
+ (NSString *)exchangeModelToJson:(id)model;

//delegate 执行  selector
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate;
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object isHasReturn:(BOOL)isHasReturn;
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object object:(id)object2 isHasReturn:(BOOL)isHasReturn;
//转换String to dic
+ (NSDictionary *)exchangeStringToDic:(NSString *)str;
//转换data to dic
+ (NSDictionary *)exchangeDataToDic:(NSData *)data;
//转换String to ary
+ (NSArray *)exchangeStringToAry:(NSString *)str;
//转换 dic to model
+ (id)exchangeDicToModel:(id)dic modelName:(NSString *)strName;
//转换dic to ary
+ (NSMutableArray *)exchangeDic:(id)response toAryWithModelName:(NSString *)modelName;
+ (NSMutableArray *)exchangeAryModelToAryDic:(NSArray *)response;
//移除空白
+ (void)removeEmpty:(NSMutableArray *)ary key:(NSString *)strKey;
//十六进制转颜色
+ (UIColor *)exchangeColorWith16:(NSString*)hexColor;
//十六进制转颜色 alpha
+ (UIColor *)exchangeColorWith16:(NSString*)hexColor alpha:(CGFloat)alpha;
//隐藏显示tag视图
+ (void)showHideViewWithTag:(int)tag inView:(UIView *)view isshow:(BOOL)isShow;

//显示提示
+ (void)showAlert:(NSString *)strAlert;
+ (void)showBigAlert:(NSString *)alert;

//获取版本号
+ (NSString *)getVersion;
//获取APP名字
+ (NSString *)getAppName;
/**
 *获取设备型号
 */
+ (NSString *)LookDeviceName;

//适配label字号
+ (CGFloat)adaptLabelFont:(CGFloat)fontNum;

#pragma mark 角标清零
+ (void)zeroIcon;

#pragma mark 根据推送的消息进行跳转
+ (void)jumpWithPushJson;

+(NSString *)removeHTML:(NSString *)html;

#pragma mark 拼写文件名
+ (NSString *)fetchDoumentPath:(NSString *)name;

#pragma mark 弹出提示
+ (void)showNotiInStatusBar:(NSString *)strMsg bageNum:(int)msgCount;

#pragma mark 跳转页面


#pragma mark 判断推送状态
//+ (BOOL)IsEnablePush;

#pragma mark 判断网络状态
+ (BOOL)IsEnableNetwork;
+ (BOOL)IsEnableWifi;
+ (BOOL)IsENable3G;

#pragma mark 获取文件大小
+ (NSString *)fetchDoumentSize;

#pragma mark encode  decode
+(NSString*)encodeString:(NSString*)unencodedString;
+(NSString*)decodeString:(NSString*)encodedString;

#pragma mark 获取汉字首字母
+ (NSString *)fetchFirstCharactorWithString:(NSString *)str;

#pragma mark 收键盘
+ (void)hideKeyboard;
#pragma mark - 获取地图Bundle中turnIcon图片
+(UIImage *)getImageFromAMapNaviBundle:(NSString *)imageName;

#pragma mark - 将某个时间戳转化成时间格式
// timestamp毫秒，用的时候要除以1000转化成秒
+ (NSString *)exchangeTimeWithStamp:(double)timestamp andFormatter:(NSString *)format;
+ (NSDate *)exchangeTimeStampToDate:(double)timestamp;
@end
