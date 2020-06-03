//
//  GlobalMethod+Data.h
//中车运
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "GlobalMethod.h"
#import <SystemConfiguration/CaptiveNetwork.h>
//address
#import <CoreLocation/CoreLocation.h>
//amap data
#import <AMapSearchKit/AMapSearchKit.h>

@class ModelWifi;
@class DynamicLineModifier;
@class YYLabel;
@interface GlobalMethod (Data)

//验证手机号码
+(BOOL)isMobileNumber:(NSString *)mobileNum;

//从本地读取数据
+(NSDictionary *)readDataFromeLocal;

#pragma mark - 返回NSAttributedString并且带图片
+ (NSAttributedString *)returnNSAttributedStringWithContentStr:(NSString *)labelStr titleColor:(UIColor *)titleColor withlineSpacing:(CGFloat)lineSpacing withAlignment:(NSInteger)alignment withFont:(UIFont *)font withImageName:(NSString *)imageName withImageRect:(CGRect)rect withAtIndex:(NSUInteger)index;

//获取订单补贴数据
+ (NSString *)subSidyFromID:(NSString *)identity;

//ary to section ary
+ (NSMutableArray *)exchangeAryToSectionWithAlpha:(NSArray *)aryResponse keyPath:(NSString *)keyPath;

//转化车辆类型
+ (NSString *)exchangeCarType:(double)typeId;
@end
