//
//  NSMutableParagraphStyle+Category.h
//中车运
//
//  Created by 隋林栋 on 2017/6/23.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableParagraphStyle (Category)
/**
 初始化
 
 @param lineSpace 行高
 @return 行高属性
 */
+ (instancetype)initWithLineSpace:(CGFloat)lineSpace;

@end
