//
//  UIFont+Category.m
//中车运
//
//  Created by 隋林栋 on 2018/6/13.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)
//获取字体高度
+ (CGFloat)fetchHeight:(CGFloat)fontNum{
    UIFont * font = [UIFont systemFontOfSize:fontNum];
    return font.lineHeight;
}
@end
