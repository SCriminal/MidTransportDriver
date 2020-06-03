//
//  ModelCell_TextView.m
//  乐销
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "ModelCell_TextView.h"

@implementation ModelCell_TextView

#pragma mark lazy init
- (NSAttributedString *)attributeStr{
    if (!_attributeStr) {
        _attributeStr = [NSAttributedString new];
    }
    return _attributeStr;
}

#pragma mark - 创建
+ (instancetype)initWithTitleHead:(NSString *)titleHead
                    imageHeadName:(NSString *)imageHeadName
                   placeHolderStr:(NSString *)placeHolderStr
                       requestStr:(NSString *)requestStr
{
    ModelCell_TextView *model = [[ModelCell_TextView alloc]init];
    [model resetWithTitleHead: titleHead
                imageHeadName: imageHeadName
               placeHolderStr: placeHolderStr
                   requestStr: requestStr];
    return model;
}

- (void)resetWithTitleHead:(NSString *)titleHead
             imageHeadName:(NSString *)imageHeadName
            placeHolderStr:(NSString *)placeHolderStr
                requestStr:(NSString *)requestStr
{
    self.titleHead = titleHead;
    self.imageHeadName = imageHeadName;
    self.placeHolderStr = placeHolderStr;
    self.requestStr = requestStr;
}

@end
