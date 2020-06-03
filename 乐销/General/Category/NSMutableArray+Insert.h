//
//  NSMutableArray+Insert.h
//中车运
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Insert)
//插入元素
- (void)insertArray:(NSArray *)newAdditions atIndex:(NSUInteger)index;
//移除重复的
- (void)removeRepeatWithKey:(NSString *)strKey;
//移除相同的model
- (void)removeObjectForKeyPath:(NSString *)keyPath object:(id)model;
//移除 KeyPath不同 model
- (void)removeObjectForKeyPath:(NSString *)keyPath object:(id)model objectKeyPath:(NSString *)objKeyPath;
//移除空的model
- (void)removeEmptyObjectForKeyPath:(NSString *)keyPath;
//移除相同的model
- (void)removeObjectForKeyPath:(NSString *)keyPath ary:(NSArray *)aryExist;
//替换相同key 元素
- (void)replaceSameItemFofrKeyPath:(NSString *)keyPath ary:(NSArray *)arySelect;
//补充model
- (void)addModelNum:(NSInteger)num modelName:(NSString *)modelName;

//添加数组非重复元素
- (void)addObjectsWithOutRepeatFromArray:(NSArray *)aryNew compareKeyPath:(NSString *)keyPath;
//移除空白
- (void)removeEmptyStrWithKey:(NSString *)strKey;
//移除类型
- (void)removeObjectsClassName:(NSString *)className;
#pragma mark 业务处理
////增加时间model
- (void)insertDateModelFromKeyPath:(NSString *)keyPath;

@end
