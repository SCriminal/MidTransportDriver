//
//  MacroLocalKey.h
//中车运
//
//  Created by 隋林栋 on 2017/7/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#ifndef MacroLocalKey_h
#define MacroLocalKey_h

//颜色
#define COLOR_LINE [UIColor colorWithHexString:@"f1f1f1"]//229
//#define COLOR_LINE [UIColor colorWithHexString:@"#FBFBFC"]
#define COLOR_DARK [UIColor colorWithHexString:@"485572"]
#define COLOR_MAIN [UIColor colorWithHexString:@"1F4BA5"]
#define COLOR_TITLE [UIColor colorWithHexString:@"4b4f63"]
#define COLOR_SUBTITLE [UIColor colorWithRed:75/255.0 green:79/255.0 blue:99/255.0 alpha:0.6]
//#define COLOR_BACKGROUND [UIColor colorWithHexString:@"FBFBFB"]//251
#define COLOR_BACKGROUND [UIColor colorWithHexString:@"F3F4F8"]//237

#define COLOR_999 [UIColor colorWithHexString:@"999999"]
#define COLOR_666 [UIColor colorWithHexString:@"666666"]
#define COLOR_333 [UIColor colorWithHexString:@"333333"]

#define COLOR_BLUE [UIColor colorWithHexString:@"00B2FF"]
#define COLOR_RED [UIColor colorWithHexString:@"FF0000"]

#define COLOR_ORANGE [UIColor colorWithHexString:@"F5A623"]
#define COLOR_GREEN [UIColor colorWithHexString:@"#66CC00"]




//透明度
#define COLOR_BLACK_ALPHA_PER60 [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6]
#define COLOR_BLACK_ALPHA_PER90 [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.9]
//map放大倍数
#define MAPZOOMNUM 14.076151

#define IMAGE_HEAD_DEFAULT @"head_default"
#define IMAGE_HEAD_COMPANY_DEFAULT @"company_logo"//use in company info
#define IMAGE_BIG_DEFAULT @"image_default"//user for image in detail

#define IMAGE_ARROW_RIGHT @"ic_more_list" //24*24
#define IMAGE_ARROW_LEFT @"ic_back_black"

#define IMAGE_WHITE_BG [[UIImage imageNamed:@"whiteWithShadowBG"]resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch]


#define UIColorFromHexRGB(rgbValue)  ^(){\
unsigned int hexNumber;\
sscanf([[rgbValue stringByReplacingOccurrencesOfString:@"#" withString:@"0x"] cStringUsingEncoding:NSUTF8StringEncoding], "%x", &hexNumber);\
return [UIColor colorWithRed:((float)((hexNumber & 0xFF0000) >> 16))/255.0 green:((float)((hexNumber & 0xFF00) >> 8))/255.0 blue:((float)(hexNumber & 0xFF))/255.0 alpha:1.0];\
}()




//更改版
#define TIME_MONTH_SHOW @"yyyy-MM"
#define TIME_DAY_SHOW @"yyyy-MM-dd"
#define TIME_HOUR_SHOW @"yyyy-MM-dd HH"
#define TIME_MIN_SHOW @"yyyy-MM-dd HH:mm"
#define TIME_SEC_SHOW @"yyyy-MM-dd HH:mm:ss"
#define TIME_MONTH_DAY_SHOW @"MM-dd"
//中文版
#define TIME_MONTH_CN @"yyyy年MM月"
#define TIME_DAY_CN @"yyyy年MM月dd日"
#define TIME_HOUR_CN @"yyyy年MM月dd日 HH"
#define TIME_MIN_CN @"yyyy年MM月dd日 HH:mm"
#define TIME_SEC_CN @"yyyy年MM月dd HH:mm:ss"
#define TIME_MONTH_DAY_CN @"MM月dd日"
#define TIME_HOUR_MIN_CN @"HH:mm"


#define LOCAL_KEY @"LOCAL_KEY"//本地存储用户key值
#define LOCAL_USERMODEL @"LOCAL_USERMODEL"//本地存储用户信息
#define LOCAL_ENTER_BACK_GROUND @"LOCAL_ENTER_BACK_GROUND"//进入后台时间
#define LOCAL_PHONE @"LOCAL_PHONE"//本地存储最后一个手机号
#define LOCAL_SHOWED_GUIDE_BEFORE @"LOCAL_SHOWED_GUIDE_BEFORE"//显示引导页
#define LOCAL_LOCATION_RECORD @"LOCAL_LOCATION_RECORD"//定位地址
#define LOCAL_LOCATION_UPTODATE @"LOCAL_LOCATION_UPTODATE"//最新定位地址

#define LOCAL_PROVINCE_LIST @"LOCAL_PROVINCE_LIST"//获取省
#define LOCAL_PACKAGE_TYPE @"LOCAL_PACKAGE_TYPE"//箱型

#define LOCAL_KEY_HEAD @"LOCAL_LD_"



//通知
#define NOTICE_SELFMODEL_CHANGE @"NOTICE_SELFMODEL_CHANGE"//个人信息更改
#define NOTICE_LOCATION_CHANGE @"NOTICE_LOCATION_CHANGE"//个人地理位置更改
#define NOTICE_LOCATION_UP_SUCCESS @"NOTICE_LOCATION_UP_SUCCESS"//个人地理位置更改上传成功

#define NOTICE_ORDER_REFERSH @"NOTICE_ORDER_REFERSH"//订单修改
#define NOTICE_MSG_REFERSH @"NOTICE_MSG_REFERSH"//消息修改


#endif /* MacroLocalKey_h */
