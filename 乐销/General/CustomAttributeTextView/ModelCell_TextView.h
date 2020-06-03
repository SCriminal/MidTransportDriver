//
//  ModelCell_TextView.h
//  乐销
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelCell_TextView : NSObject
@property (nonatomic, strong) NSString *titleHead;
@property (nonatomic, strong) NSString *imageHeadName;
@property (nonatomic, strong) NSString *placeHolderStr;
@property (nonatomic, strong) NSString *requestStr;
@property (nonatomic, strong) NSAttributedString *attributeStr;

#pragma mark 创建
+ (instancetype)initWithTitleHead:(NSString *)titleHead
                    imageHeadName:(NSString *)imageHeadName
                   placeHolderStr:(NSString *)placeHolderStr
                       requestStr:(NSString *)requestStr;

- (void)resetWithTitleHead:(NSString *)titleHead
             imageHeadName:(NSString *)imageHeadName
            placeHolderStr:(NSString *)placeHolderStr
                requestStr:(NSString *)requestStr;

@end
