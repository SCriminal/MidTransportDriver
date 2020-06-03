//
//  NSArray+Category.h
//中车运
//
//  Created by 隋林栋 on 2017/1/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)

@property (nonatomic, assign, readonly) CGFloat height;//高度，计算views

//@property (nonatomic, readonly) NSString *jsonStr;//获取jsonstr
@property (nonatomic, readonly) NSString *jsonStrCropWPro;//新建产品 json
@property (nonatomic, readonly) NSString *jsonStrCropWCus;//新建客户 json
@property (nonatomic, readonly) NSString *iDStr;

//查询相同的model
- (void)fetchSelectModels:(NSArray *)arySelect compareKey:(NSString *)compareKey exchangeKey:(NSString *)exchangeKey;

//获取选中的数据
- (NSMutableArray *)fetchSelectModelsCompareModel:(id)model keyPath:(NSString *)keyPath;
//获取选中的数据
- (NSMutableArray *)fetchSelectModelsKeyPath:(NSString *)keyPath value:(id)value;
//组成字符串
- (NSString *)componentsJoinedByString:(NSString *)separator keyPath:(NSString *)keyPath;
//组成固定key Json字符串
- (NSString *)fetchJsonkeyPath:(NSString *)keyPath;
//获取keypath 组成的数组
- (NSMutableArray *)fetchValues:(NSString *)keyPath;
//获取元素ary
- (NSMutableArray *)fetchValuesComponentAry:(NSString *)keyPath;
//组成dic
- (NSMutableDictionary *)exchangeDicWithKeyPath:(NSString *)keyPath;
- (NSMutableDictionary *)exchangeStrAryToDic;
//获取相同的model
- (id)fetchSameModelKeyPath:(NSString *)keyPath model:(id)model;
- (NSInteger)fetchSameModelIndexKeyPath:(NSString *)keyPath model:(id)model;
- (NSInteger)fetchSameModelIndexKeyPath:(NSString *)keyPath value:(id)value;
//获取相同的model
- (id)fetchSameModelKeyPath:(NSString *)keyPath value:(id)value;
//获取不同的model
- (NSMutableArray *)fetchDifferentElementKeyPath:(NSString *)keyPath;
//获取相同的model
- (NSMutableArray *)fetchSameElementKeyPath:(NSString *)keyPath aryCompare:(NSArray *)aryCompare;

//转换ary to section
- (NSMutableArray *)exchangeToSectionWithKeyPath:(NSString *)keyPath;
//获取临时固定ary
- (NSArray *)tmpAry;
- (NSMutableArray *)tmpMuAry;
- (NSMutableArray *)copyModelMuAry;

//将model 转换成字典
- (NSMutableArray *)exchangeModelToDicAry;
//写到本地
- (void)writeToLocal:(NSString *)localKey;

//获取model  同一类
- (NSMutableArray * )fetchModelsClassName:(NSString *)className;

#pragma mark logical method
- (NSString *)imageRequestStr;//fetch image request string
- (NSMutableArray *)imageAryOfDic;//fetch ary of dictionary from model
#pragma mark exchange to model
- (NSMutableArray *)exchangeToModel:(NSString *)modelName;
/**
 recofig views in the direction vertical
 */
- (void)reconfigVerticalViews;
@end
