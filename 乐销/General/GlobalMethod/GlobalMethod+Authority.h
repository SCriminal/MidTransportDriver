//
//  GlobalMethod+Authority.h
//中车运
//
//  Created by 隋林栋 on 2017/6/16.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod.h"

//权限类型
typedef NS_ENUM(NSUInteger, AUTHORITY_TYPE) {
    AUTHORITY_PHOTO,
    AUTHORITY_CAMERA,
    AUTHORITY_ADDRESSBOOK,
    AUTHORITY_MIC,
    AUTHORITY_LOCAL,//没写
};

@interface GlobalMethod (Authority)
//获取相册权限
+ (void)fetchPhotoAuthorityBlock:(void (^)(void))block;
//获取照相机权限
+ (void)fetchCameraAuthorityBlock:(void (^)(void))block;
// 通讯录
+ (void)fetchAddressBookAuthorityBlock:(void (^)(void))block;
// 麦克风
+ (void)fetchMicAuthorityBlock:(void (^)(void))block;
#pragma mark - 定位
+ (BOOL)fetchLocalAuthorityBlock:(void (^)(void))block;
/**
 调用电话功能
 
 @param ViewController 调用类
 @param phoneStr 电话号码
 */
+(void)gotoCallPhoneClick:(UIViewController *)ViewController  phone:(NSString *)phoneStr;
//短信
+(void)gotoMessageClick:(UIViewController *)ViewController  phone:(NSString *)phoneStr;
/**
 获取设备唯一信息 包括 UUID系统(逻辑)  运营商 版本号  系统名
 */
+ (NSString *)fetchDeviceID;
//设备名称
+ (NSString *)deviceName;
@end
