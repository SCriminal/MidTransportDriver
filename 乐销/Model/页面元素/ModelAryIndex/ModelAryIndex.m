//
//  ModelAryIndex.m
//中车运
//
//  Created by 隋林栋 on 2016/12/30.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "ModelAryIndex.h"

@implementation ModelAryIndex

- (NSMutableArray *)aryMu{
    if (_aryMu == nil) {
        _aryMu = [NSMutableArray new];
    }
    return _aryMu;
}

#pragma mark 创建 
+ (instancetype)initWithStrFirst:(NSString *)strFirst
{
    ModelAryIndex *model = [[ModelAryIndex alloc]init];
    [model resetWithStrFirst: strFirst];
    return model;
}

- (void)resetWithStrFirst:(NSString *)strFirst
{
    self.strFirst = strFirst;    
}
@end
