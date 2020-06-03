//
//  BaseTableVC+Select.m
//中车运
//
//  Created by 隋林栋 on 2018/4/10.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "BaseTableVC+Select.h"
static const char BaseTableVCArySelectedKey = '\0';
static const char BaseTableVCBlockCompleteKey = '\0';

@implementation BaseTableVC (Select)
#pragma mark 运行时
- (void)setArySelected:(NSMutableArray *)arySelected{
    if (!arySelected || [arySelected isKindOfClass:NSMutableArray.class]) {
        objc_setAssociatedObject(self, &BaseTableVCArySelectedKey, arySelected.copyModelMuAry, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (NSMutableArray *)arySelected{
    NSMutableArray * arySelect = objc_getAssociatedObject(self, &BaseTableVCArySelectedKey);
    if (!arySelect || [arySelect isKindOfClass:NSMutableArray.class]) {
        return arySelect;
    }
    return nil;
}
- (void)setBlockComplete:(void (^)(NSMutableArray *))blockComplete{
    objc_setAssociatedObject(self, &BaseTableVCBlockCompleteKey, blockComplete, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(NSMutableArray *))blockComplete{
    return objc_getAssociatedObject(self, &BaseTableVCBlockCompleteKey);
}



@end
