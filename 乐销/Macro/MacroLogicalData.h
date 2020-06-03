//
//  MacroLogicalData.h
//  
//
//  Created by 隋林栋 on 2018/11/9.
//

#ifndef MacroLogicalData_h
#define MacroLogicalData_h


//key
//用户身份
#define KEY_USER_TYPE_DRIVER @"d16e21683e56d9836c2a3ff5a45991ac"
#define KEY_USER_TYPE_OWNER @"dca1117a4a9933499a4a870b4190065a"
#define KEY_USER_TYPE_MOTORCADE @"9a9bda581061a47a96551f36dbf9f508"
#define KEY_USER_TYPE_SELF_MOTORCADE @"a97d327c6206ad17d6b1982171b9ca26"
//订单类型
#define KEY_ORDER_CLASS_ENTER @"7055eced15538bfb7c07f8a5b28fc5d0"
#define KEY_ORDER_CLASS_EXPORT @"dca1117a4a9933499a4a870b4190065a"
#define KEY_ORDER_CLASS_ZERO @"72b9a3c47a328fcaf24722442a74dd97"

/*
 "code": "90000",
 "msg": "加载成功",
 "data": [
 {
 "ids": "7055eced15538bfb7c07f8a5b28fc5d0",
 "type_name": "待发布"
 },
 {
 "ids": "dca1117a4a9933499a4a870b4190065a",
 "type_name": "已发布"
 },
 {
 "ids": "a36abd601b784b2ece294786ee83e834",
 "type_name": "已接单"
 },
 {
 "ids": "7488b072f817428c95041dedfae7d3c2",
 "type_name": "退单"
 },
 {
 "ids": "72b9a3c47a328fcaf24722442a74dd97",
 "type_name": "待运输"
 },
 {
 "ids": "9a9bda581061a47a96551f36dbf9f508",
 "type_name": "待提箱"
 },
 {
 "ids": "d16e21683e56d9836c2a3ff5a45991ac",
 "type_name": "已提箱"
 },
 {
 "ids": "9559d221333c25fad35ede24023b6c0a",
 "type_name": "返厂中"
 },
 {
 "ids": "45796e9e6385fb878e900c49d3077ed8",
 "type_name": "已到厂"
 },
 {
 "ids": "88950b12016202c8798ffe8d0bb46eea",
 "type_name": "待装货"
 },
 {
 "ids": "c8180c19e5a1278cddf5248331ef7fa5",
 "type_name": "已装货"
 },
 {
 "ids": "174a9535b7fd93ceecbe1fc0392fa0f2",
 "type_name": "待还箱"
 },
 {
 "ids": "a97d327c6206ad17d6b1982171b9ca26",
 "type_name": "已还箱"
 },
 {
 "ids": "317a2f77738f0e57c915e9699e89e7dd",
 "type_name": "待结算"
 },
 {
 "ids": "bf340d1d423c380536d220f1938de4e5",
 "type_name": "货主费用确认"
 },
 {
 "ids": "408431e60292898d4fd04f3d04884dcb",
 "type_name": "车队费用确认"
 },
 {
 "ids": "3d91517db259db2a89ddccda86408310",
 "type_name": "平台费用确认"
 },
 {
 "ids": "d5c7a62068deec875d2aa4fcbb4128c0",
 "type_name": "驳回费用"
 },
 {
 "ids": "e184776632516cfcaa4518cacb328a6b",
 "type_name": "货主结算中"
 },
 {
 "ids": "f3d270ec982fdcbde29636f39fa69712",
 "type_name": "车队结算中"
 },
 {
 "ids": "2a09e52f6df41dc6d9e41c20abb950b2",
 "type_name": "平台结算中"
 },
 {
 "ids": "dd2c739b9b3fe8f849b5cec87727f41d",
 "type_name": "结算完成"
 },
 {
 "ids": "dc5f99b6f4c98baedf5e572e240235a8",
 "type_name": "待评价"
 },
 {
 "ids": "ccc3243dcb6a1c8b7eb180fa215d0c7d",
 "type_name": "关闭订单"
 },
 {
 "ids": "3bdbfcdf17d0b6d0162ea6bf5be30d97",
 "type_name": "无效订单"
 }
 ]
 }
 货主：待发布(1)、已发布(2)、待运输(3,4,5)、已运输(6,7,8,9,10,11,12,13)、待结算(14,15,16,17,18,19,20,21)、已结算(22,23)
 
 车队 个体车队：待发布(1)、已发布(2)、待运输(3,4,5)、已运输(6,7,8,9,10,11,12,13)、待结算(14,15,16,17,18,19,20,21)、已结算(22,23)
 
 司机：待运输(3,4,5)、已运输(6,7,8,9,10,11,12,13)、待结算(14,15,16,17,18,19,20,21)、已结算(22,23)
 */

//订单状态
#define KEY_ORDER_STATE_WAIT_UP @"7055eced15538bfb7c07f8a5b28fc5d0"//"待发布"
#define KEY_ORDER_STATE_ALREADY_UP @"dca1117a4a9933499a4a870b4190065a"// "已发布"
#define KEY_ORDER_STATE_ALREADY_RECEIVE @"a36abd601b784b2ece294786ee83e834"// "已接单"
#define KEY_ORDER_STATE_RETURN @"7488b072f817428c95041dedfae7d3c2"//"退单"
#define KEY_ORDER_STATE_WAIT_TRANSPORT @"72b9a3c47a328fcaf24722442a74dd97"//"待运输"
#define KEY_ORDER_STATE_WAIT_PICKUP @"9a9bda581061a47a96551f36dbf9f508"//"待提箱"
#define KEY_ORDER_STATE_ALREADY_PICKUP @"d16e21683e56d9836c2a3ff5a45991ac"//"已提箱"
#define KEY_ORDER_STATE_BACK_FACTORY @"9559d221333c25fad35ede24023b6c0a"//"返厂中"
#define KEY_ORDER_STATE_ALREADY_BACK_FACTORY @"45796e9e6385fb878e900c49d3077ed8"//"已到厂"
#define KEY_ORDER_STATE_WAIT_LOAD @"88950b12016202c8798ffe8d0bb46eea"//"待装货"
#define KEY_ORDER_STATE_ALREADY_LOAD @"c8180c19e5a1278cddf5248331ef7fa5"//"已装货"
#define KEY_ORDER_STATE_WAIT_RETURN_CONTAINER @"174a9535b7fd93ceecbe1fc0392fa0f2"//"待还箱"
#define KEY_ORDER_STATE_ALREADY_RETURN_CONTAINER @"a97d327c6206ad17d6b1982171b9ca26"//"已还箱"
#define KEY_ORDER_STATE_WAIT_PAY @"317a2f77738f0e57c915e9699e89e7dd"//"待结算"
#define KEY_ORDER_STATE_OWNER_RECHECK @"bf340d1d423c380536d220f1938de4e5"// "货主费用确认"
#define KEY_ORDER_STATE_MOTOCADE_RECHECK @"408431e60292898d4fd04f3d04884dcb"//"车队费用确认"
#define KEY_ORDER_STATE_PLATFORM_RECHECK @"3d91517db259db2a89ddccda86408310"//"平台费用确认"
#define KEY_ORDER_STATE_REJECT_SETTLEMENT @"d5c7a62068deec875d2aa4fcbb4128c0"//"驳回费用"
#define KEY_ORDER_STATE_OWNER_SETTLEMENT @"e184776632516cfcaa4518cacb328a6b"//"货主结算中"
#define KEY_ORDER_STATE_MOTORCADE_SETTLEMENT @"f3d270ec982fdcbde29636f39fa69712"// "车队结算中"
#define KEY_ORDER_STATE_PLATFORM_SETTLEMENT @"2a09e52f6df41dc6d9e41c20abb950b2"//"平台结算中"
#define KEY_ORDER_STATE_SETTLEMENT_COMPLETE @"dd2c739b9b3fe8f849b5cec87727f41d"// "结算完成"
#define KEY_ORDER_STATE_WAIT_COMMENT @"dc5f99b6f4c98baedf5e572e240235a8"//"待评价"
#define KEY_ORDER_STATE_CLOSE_ORDER @"ccc3243dcb6a1c8b7eb180fa215d0c7d"//"关闭订单"
#define KEY_ORDER_STATE_INVALIDE_ORDER @"3bdbfcdf17d0b6d0162ea6bf5be30d97"//"无效订单"


//补贴类型
#define KEY_ORDER_SUBSIDY_MONEY @"money"//补贴金额，取整 结果：/100'
#define KEY_ORDER_SUBSIDY_INTEGRAL @"integral"//补贴积分，取整
#define KEY_ORDER_SUBSIDY_OIL @"oil"//补贴油
#endif /* MacroLogicalData_h */
