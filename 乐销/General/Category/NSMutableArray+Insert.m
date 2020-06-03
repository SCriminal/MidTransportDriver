//
//  NSMutableArray+Insert.m
//中车运
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "NSMutableArray+Insert.h"

@implementation NSMutableArray (Insert)
- (void)insertArray:(NSArray *)newAdditions atIndex:(NSUInteger)index{
    if (newAdditions.count == 0) {
        return;
    }
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    for(NSUInteger i = index;i < newAdditions.count+index;i++)
    {
        [indexes addIndex:i];
    }
    [self insertObjects:newAdditions atIndexes:indexes];
}
//移除重复
- (void)removeRepeatWithKey:(NSString *)strKey{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (id model in self.copy) {
        if ([model respondsToSelector:NSSelectorFromString(strKey)]) {
            id key = [model valueForKey:strKey];
            if (key) {
                if ([dic objectForKey:key]) {
                    [self removeObject:model];
                }else{
                    [dic setValue:model forKey:key];
                }
            }
        }
    }
}


//移除相同的model
- (void)removeObjectForKeyPath:(NSString *)keyPath object:(id)model{
    [self removeObjectForKeyPath:keyPath object:model objectKeyPath:keyPath];
}
//移除 KeyPath不同 model
- (void)removeObjectForKeyPath:(NSString *)keyPath object:(id)model objectKeyPath:(NSString *)objKeyPath{
    if (![model respondsToSelector:NSSelectorFromString(objKeyPath)]) {
        return;
    }
    id keyOrigin = [model valueForKeyPath:objKeyPath];
    
    NSArray * aryTmp = [NSArray arrayWithArray:self];
    for (id model in aryTmp) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            id key = [model valueForKey:keyPath];
            if ([[NSString stringWithFormat:@"%@",key] isEqualToString:[NSString stringWithFormat:@"%@",keyOrigin]]) {
                [self removeObject:model];
            }
        }
    }
}
//移除空的model
- (void)removeEmptyObjectForKeyPath:(NSString *)keyPath {
    NSArray * aryTmp = [NSArray arrayWithArray:self];
    for (id model in aryTmp) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            if (![model valueForKey:keyPath]) {
                [self removeObject:model];
            }
        }
    }
}
//移除相同的model
- (void)removeObjectForKeyPath:(NSString *)keyPath ary:(NSArray *)aryExist{
    if (!isAry(aryExist)) {
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (id model in aryExist) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            id key = [model valueForKey:keyPath];
            if (key) {
                [dic setValue:model forKey:key];
            }
        }
    }
    for (id model in self.tmpAry) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            id key = [model valueForKey:keyPath];
            if ([dic objectForKey:key]) {
                [self removeObject:model];
            }
        }
    }
}
//替换相同key 元素  没有的不增加
- (void)replaceSameItemFofrKeyPath:(NSString *)keyPath ary:(NSArray *)aryExist{
    if (!isAry(aryExist)) {
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (id model in self) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            id key = [model valueForKey:keyPath];
            if (key) {
                [dic setValue:model forKey:key];
            }
        }
    }
    for (id model in aryExist) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            id key = [model valueForKey:keyPath];
            if ([dic objectForKey:key]) {
                [dic setValue:model forKey:key];
            }
        }
    }
    [self removeAllObjects];
    [self addObjectsFromArray:dic.allValues];
    
}
//补充model
- (void)addModelNum:(NSInteger)num modelName:(NSString *)modelName{
   NSInteger numAll = self.count%num == 0 ? self.count : self.count/num *num + num;
    for ( NSInteger i = self.count; i< numAll; i++) {
        [self addObject:[NSClassFromString(modelName) new]];
    }
}
//添加数组非重复元素
- (void)addObjectsWithOutRepeatFromArray:(NSArray *)aryNew compareKeyPath:(NSString *)keyPath{
    NSMutableDictionary * dicSelf = [self exchangeDicWithKeyPath:keyPath];
    for (id model in aryNew) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            NSString * strKey = [model valueForKeyPath:keyPath];
            if (![dicSelf objectForKey:strKey]) {
                [self addObject:model];
            }
        }
    }
}
//移除空白
- (void)removeEmptyStrWithKey:(NSString *)keyPath{
    if (!isStr(keyPath))return;
    for (id model in self.tmpAry) {
        if (model && [model respondsToSelector:NSSelectorFromString(keyPath)]) {
            NSString * strValue = [model valueForKeyPath:keyPath];
            if (!isStr(strValue)) {
                [self removeObject:model];
            }
        }
    }
}

//移除类型
- (void)removeObjectsClassName:(NSString *)className{
    if (!isStr(className))return;
    for (id model in self.tmpAry) {
        if (model && [model isKindOfClass:NSClassFromString(className)]) {
            [self removeObject:model];
        }
    }
}





@end
