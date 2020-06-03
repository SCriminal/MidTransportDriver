//
//  NSMutableParagraphStyle+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/6/23.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSMutableParagraphStyle+Category.h"

@implementation NSMutableParagraphStyle (Category)

/**
 初始化

 @param lineSpace 行高
 @return 行高属性
 */
+ (instancetype)initWithLineSpace:(CGFloat)lineSpace{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = lineSpace;//行距
    return paragraphStyle;
    
}

@end
