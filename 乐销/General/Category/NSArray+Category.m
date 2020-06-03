//
//  NSArray+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/1/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

- (CGFloat)height{
    if (self.count > 0) {
        CGFloat numReturn = 0;
        for (UIView * view in self) {
            if ([view isKindOfClass:[UIView class]]) {
                numReturn += view.topToUpView + view.height;
            }
        }
        return numReturn;
    }
    return 0;
}


//转换已选择model
- (void)fetchSelectModels:(NSArray *)arySelect compareKey:(NSString *)compareKey exchangeKey:(NSString *)exchangeKey{
    if (!arySelect) {
        return;
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (id model in arySelect) {
        if ([model respondsToSelector:NSSelectorFromString(compareKey)] && [model valueForKeyPath:compareKey]) {
            [dic setValue:[NSNumber numberWithBool:true] forKey:[model valueForKeyPath:compareKey]];
        }
    }
    for (id model in self) {
        if ([model isKindOfClass:[ModelAryIndex class]]) {
            ModelAryIndex * modelSection = (ModelAryIndex *)model;
            for (id model in modelSection.aryMu) {
                if ([model respondsToSelector:NSSelectorFromString(compareKey)]&&[model valueForKeyPath:compareKey]) {
                    id isEqual =[dic objectForKey:[model valueForKeyPath:compareKey]];
                    if ([model respondsToSelector:NSSelectorFromString(exchangeKey)]) {
                        [model setValue:[NSNumber numberWithBool:isEqual?true:false] forKeyPath:exchangeKey];
                    }
                }
            }
        }else{
            if ([model respondsToSelector:NSSelectorFromString(compareKey)]&&[model valueForKeyPath:compareKey]) {
                NSNumber * num = [model valueForKeyPath:compareKey];
                id isEqual =[dic objectForKey:[model valueForKeyPath:compareKey]];
                if ([model respondsToSelector:NSSelectorFromString(exchangeKey)]) {
                    [model setValue:[NSNumber numberWithBool:isEqual?true:false] forKeyPath:exchangeKey];
                }
            }
        }
    }
}


//获取选中的数据
- (NSMutableArray *)fetchSelectModelsCompareModel:(id)model keyPath:(NSString *)keyPath{
    NSMutableArray * aryReturn = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if ([model respondsToSelector:NSSelectorFromString(keyPath)]&&[model valueForKeyPath:keyPath]) {
        [dic setValue:[NSNumber numberWithBool:true] forKey:[model valueForKeyPath:keyPath]];
    }
    for (id model in self) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]&&[model valueForKeyPath:keyPath]) {
            id isEqual =[dic objectForKey:[model valueForKeyPath:keyPath]];
            if (isEqual) {
                [aryReturn addObject:model];
            }
        }
    }
    return aryReturn;
}

//获取选中的数据
- (NSMutableArray *)fetchSelectModelsKeyPath:(NSString *)keyPath value:(id)value{
    NSMutableArray * aryReturn = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if (!value) {
        return aryReturn;
    }
    [dic setValue:[NSNumber numberWithBool:true] forKey:value];

    for (id model in self) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]&&[model valueForKeyPath:keyPath]) {
            id isEqual =[dic objectForKey:[model valueForKeyPath:keyPath]];
            if (isEqual) {
                [aryReturn addObject:model];
            }
        }
    }
    return aryReturn;
}

//组成字符串
- (NSString *)componentsJoinedByString:(NSString *)separator keyPath:(NSString *)keyPath{
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (id model in self) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]&&[model valueForKeyPath:keyPath]) {
            NSString * str = [NSString stringWithFormat:@"%@",UnPackStr([model valueForKeyPath:keyPath])];
            if (isStr(str)) {
                [aryReturn addObject:str];
            }
        }
    }
    return [aryReturn componentsJoinedByString:separator];
}
//组成固定key Json字符串
- (NSString *)fetchJsonkeyPath:(NSString *)keyPath{
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (id model in self) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]&&[model valueForKeyPath:keyPath]) {
            
            [aryReturn addObject:@{keyPath:[model valueForKeyPath:keyPath]}];
          
        }
    }
    return [GlobalMethod exchangeDicToJson:aryReturn];
}

//获取keypath 组成的数组
- (NSMutableArray *)fetchValues:(NSString *)keyPath{
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (id model in self) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]&&[model valueForKeyPath:keyPath]) {
            [aryReturn addObject:[model valueForKeyPath:keyPath]];
        }
    }
    return aryReturn;
}

//获取元素ary
- (NSMutableArray *)fetchValuesComponentAry:(NSString *)keyPath{
    NSMutableArray * aryMu = [NSMutableArray array];
    for (id modelItem in self) {
        {
            if ([modelItem respondsToSelector:NSSelectorFromString(keyPath)]) {
                NSArray * value = [modelItem valueForKeyPath:keyPath];
                if (isAry(value)) {
                    [aryMu addObjectsFromArray:value];
                }
            }
        }
    }
    return aryMu;
}

//组成dic
- (NSMutableDictionary *)exchangeDicWithKeyPath:(NSString *)keyPath{
    if (!isStr(keyPath)) {
        return [NSMutableDictionary dictionary];
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (id model in self) {
         if([model respondsToSelector:NSSelectorFromString(keyPath)]&&[model valueForKeyPath:keyPath]) {
            [dic setObject:model forKey:[model valueForKeyPath:keyPath]];
        }
    }
    return dic;
}
//组成dic
- (NSMutableDictionary *)exchangeStrAryToDic{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSString * model in self) {
        if (isStr(model)) {
            [dic setObject:model forKey:model];
        }
    }
    return dic;
}

//获取相同的model
- (id)fetchSameModelKeyPath:(NSString *)keyPath model:(id)model{
    if ([model respondsToSelector:NSSelectorFromString(keyPath)] && [model valueForKeyPath:keyPath]) {
        //集成元素
        NSMutableDictionary * dicMu = [NSMutableDictionary dictionary];
        for (id modelItem in self) {
            if ([modelItem isKindOfClass:[ModelAryIndex class]]) {
                ModelAryIndex * modelSection = (ModelAryIndex *)modelItem;
                for (id modelItem in modelSection.aryMu) {
                    if ([modelItem respondsToSelector:NSSelectorFromString(keyPath)]&&[modelItem valueForKeyPath:keyPath]) {
                        [dicMu setObject:modelItem forKey:[modelItem valueForKeyPath:keyPath]];
                    }
                }
            }else{
                if ([modelItem respondsToSelector:NSSelectorFromString(keyPath)]&&[modelItem valueForKeyPath:keyPath]) {
                    [dicMu setObject:modelItem forKey:[modelItem valueForKeyPath:keyPath]];
                }
            }
        }
        //获取指定元素
        return [dicMu objectForKey:[model valueForKeyPath:keyPath]];
    }
    return nil;
}
//获取相同的model
- (id)fetchSameModelKeyPath:(NSString *)keyPath value:(id)value{
    if (!value) {
        return nil;
    }
    //集成元素
    NSMutableDictionary * dicMu = [NSMutableDictionary dictionary];
    for (id modelItem in self) {
        if ([modelItem respondsToSelector:NSSelectorFromString(keyPath)]&&[modelItem valueForKeyPath:keyPath]) {
            [dicMu setObject:modelItem forKey:[modelItem valueForKeyPath:keyPath]];
        }
    }
    //获取指定元素
    return [dicMu objectForKey:value];
}
//获取不同的model
- (NSMutableArray *)fetchDifferentElementKeyPath:(NSString *)keyPath{
    if (!isStr(keyPath)) {
        return nil;
    }
    //集成元素
    NSMutableDictionary * dicMu = [NSMutableDictionary dictionary];
    NSMutableArray *aryReturn = [NSMutableArray array];
    for (id modelItem in self) {
        if ([modelItem respondsToSelector:NSSelectorFromString(keyPath)]&&[modelItem valueForKeyPath:keyPath]) {
            if (![dicMu objectForKey:[modelItem valueForKeyPath:keyPath]]) {
                [dicMu setObject:modelItem forKey:[modelItem valueForKeyPath:keyPath]];
                [aryReturn addObject:modelItem];
            }
        }
    }
    //获取指定元素
    return aryReturn;
}
//获取相同的model
- (NSMutableArray *)fetchSameElementKeyPath:(NSString *)keyPath aryCompare:(NSArray *)aryCompare{
    if (!isStr(keyPath)) {
        return nil;
    }
    if (!isAry(aryCompare)) {
        return nil;
    }
    //集成元素
    NSMutableDictionary * dicMu = [NSMutableDictionary dictionary];
    for (id modelItem in aryCompare) {
        if ([modelItem respondsToSelector:NSSelectorFromString(keyPath)]&&[modelItem valueForKeyPath:keyPath]) {
            [dicMu setObject:modelItem forKey:[modelItem valueForKeyPath:keyPath]];
        }
    }
    NSMutableArray *aryReturn = [NSMutableArray array];
    for (id modelItem in self) {
        if ([modelItem respondsToSelector:NSSelectorFromString(keyPath)]&&[modelItem valueForKeyPath:keyPath]) {
            if ([dicMu objectForKey:[modelItem valueForKeyPath:keyPath]]) {
                [aryReturn addObject:modelItem];
            }
        }
    }
    //获取指定元素
    return aryReturn;
}
//转换ary to section
- (NSMutableArray *)exchangeToSectionWithKeyPath:(NSString *)keyPath {
    //init ary all
    NSMutableDictionary * dicAllKey = [NSMutableDictionary dictionary];
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (id model in self) {
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            NSString * strKey = [model valueForKeyPath:keyPath];
            if (![dicAllKey objectForKey:UnPackStr(strKey)]) {
                ModelAryIndex * modelSection = [ModelAryIndex initWithStrFirst:UnPackStr(strKey)];
                [dicAllKey setObject:modelSection forKey:UnPackStr(strKey)];
                [aryReturn addObject:modelSection];
                [modelSection.aryMu addObject:model];
            }else{
                ModelAryIndex * modelSection = [dicAllKey objectForKey:UnPackStr(strKey)];
                [modelSection.aryMu addObject:model];
            }
        }
    }
    return aryReturn;
}
- (NSInteger)fetchSameModelIndexKeyPath:(NSString *)keyPath model:(id)model{
    id modelIndex = [self fetchSameModelKeyPath:keyPath model:model];
    if (modelIndex) {
        return  [self indexOfObject:modelIndex];
    }
    return -1;
}
- (NSInteger)fetchSameModelIndexKeyPath:(NSString *)keyPath value:(id)value{
    id modelIndex = [self fetchSameModelKeyPath:keyPath value:value];
    if (modelIndex) {
        return  [self indexOfObject:modelIndex];
    }
    return -1;
}
//获取临时固定ary
- (NSArray *)tmpAry{
    return [NSArray arrayWithArray:self];
}
- (NSMutableArray *)tmpMuAry{
    return [NSMutableArray arrayWithArray:self];
}
- (NSMutableArray *)copyModelMuAry{
    NSMutableArray * aryMu = [NSMutableArray array];
    for (id modelItem in self) {
        if ([modelItem respondsToSelector:NSSelectorFromString(@"dictionaryRepresentation")]) {
            NSDictionary * dic = [GlobalMethod performSelector:@"dictionaryRepresentation" delegate:modelItem object:nil isHasReturn:true];
            if (dic) {
                id modelCopy = [GlobalMethod performSelector:@"modelObjectWithDictionary:"  delegate:[modelItem class] object:dic isHasReturn:true];
                [aryMu addObject:modelCopy];
            }
        }else {
            [aryMu addObject:modelItem];
        }
    }
    return aryMu;
}



//将model 转换成字典
- (NSMutableArray *)exchangeModelToDicAry{
    NSMutableArray * aryMu = [NSMutableArray array];
    for (id modelItem in self) {
        if ([modelItem respondsToSelector:NSSelectorFromString(@"dictionaryRepresentation")]) {
            NSDictionary * dic = [GlobalMethod performSelector:@"dictionaryRepresentation" delegate:modelItem object:nil isHasReturn:true];
            if (dic) {
                [aryMu addObject:dic];
            }
            
        }else if ([modelItem isKindOfClass:NSDictionary.class]){
            [aryMu addObject:modelItem];
        }
    }
    return aryMu;
}

- (void)writeToLocal:(NSString *)localKey{
    NSArray * aryTmp = self.tmpAry;
    [GlobalMethod asynthicBlock:^{
        [GlobalMethod writeAry:aryTmp key:localKey];
    }];
}



//获取model  同一类
- (NSMutableArray * )fetchModelsClassName:(NSString *)className{
    if (!isStr(className))return [NSMutableArray array];
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (id model in self.tmpAry) {
        if (model && [model isKindOfClass:NSClassFromString(className)]) {
            [aryReturn addObject:model];
        }
    }
    return aryReturn;
}

#pragma mark logical method
//fetch image request string
- (NSString *)imageRequestStr{
    return [GlobalMethod exchangeDicToJson:self.imageAryOfDic];
}
- (NSMutableArray *)imageAryOfDic{
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (ModelImage * modelItem in self) {
        if ([modelItem isKindOfClass:[ModelImage class]]){
            if (modelItem.image) {
                CGSize size = modelItem.image.size;
                [aryReturn addObject:@{@"url":UnPackStr(modelItem.image.imageURL),@"desc":UnPackStr(modelItem.desc),@"type":@"0",@"width":strDotF(size.width),@"height":strDotF(size.height)}];
            }else{
                [aryReturn addObject:@{@"url":UnPackStr(modelItem.url),@"desc":UnPackStr(modelItem.desc),@"type":@"0",@"width":strDotF(modelItem.width),@"height":strDotF(modelItem.width)}];
            }
        }
    }
    return aryReturn;
}

#pragma mark exchange to model
- (NSMutableArray *)exchangeToModel:(NSString *)modelName{
    NSMutableArray * aryReturn = [NSMutableArray new];
    for (id modelItem in self) {
        if (NSClassFromString(modelName)) {
            if ([modelItem respondsToSelector:NSSelectorFromString(@"exchangeToModel:")]) {                 id modelNew = [GlobalMethod performSelector:@"exchangeToModel:" delegate:modelItem object:modelName isHasReturn:true];
                if (modelNew) {
                    [aryReturn addObject:modelNew];
                }
            }
        }
    }
    return aryReturn;
}
/**
 recofig views in the direction vertical
 */
- (void)reconfigVerticalViews{
    if (self.count > 0) {
        CGFloat numTop = 0;
        for (UIView * view in self) {
            if ([view isKindOfClass:[UIView class]]) {
                view.top = numTop + view.topToUpView;
                numTop += view.topToUpView + view.height;
            }
        }
    }
}

@end
