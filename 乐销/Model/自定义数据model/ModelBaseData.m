//
//  ModelBaseData.m
//中车运
//
//  Created by 隋林栋 on 2017/6/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "ModelBaseData.h"

@implementation ModelBaseData

#pragma mark lazy init
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}


@end
