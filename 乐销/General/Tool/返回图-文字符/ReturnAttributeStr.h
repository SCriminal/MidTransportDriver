//
//  ReturnAttributeStr.h
//  天下农商
//
//  Created by Mac on 2016/12/30.
//  Copyright © 2016年 mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnAttributeStr : NSObject

#pragma mark - 返回图文字符串
/**
 *  返回图文字符串
 *
 *  @param title       文字内容
 *  @param imageName   图片名字
 *  @param rect        图片大小
 *  @param index       图片在文字中的位置
 */
+ (NSMutableAttributedString *)setAttributeTitle:(NSString * )title imageName:(NSString *)imageName imageRect:(CGRect)rect withIndex:(NSUInteger)index;

#pragma mark - MD5加密
+ (NSString *) md5:(NSString *)str;

#pragma mark - 封装地址
+ (NSString *)getAdressWithProvience:(NSString *)provience City:(NSString *)city;

#pragma mark - 返回NSAttributedString
+ (NSAttributedString *)returnNSAttributedStringWithDetailStr:(NSString *)labelStr withlineSpacing:(CGFloat)lineSpacing withAlignment:(NSInteger)alignment withFont:(UIFont *)font;

#pragma mark - 返回NSAttributedString并且带图片
+ (NSAttributedString *)returnNSAttributedStringWithContentStr:(NSString *)labelStr withlineSpacing:(CGFloat)lineSpacing withAlignment:(NSInteger)alignment withFont:(UIFont *)font withImageName:(NSString *)imageName withImageRect:(CGRect)rect withAtIndex:(NSUInteger)index;



#pragma mark - 返回不一样的字体大小（仅两种font）
/**
 *  返回不一样的字体大小
 *
 *  @param needText    文字内容
 *  @param big         大字体
 *  @param small       小字体
 *  @param rangeArray  范围range数组
 */
+ (NSMutableAttributedString *) returnDifferentFontWithText:(NSString*)needText bigFont:(CGFloat)big smallFont:(CGFloat)small rangeArray:(NSMutableArray *)rangeArray;

#pragma mark - 返回不一样字体颜色 (仅两种字体颜色)
/**
 *  返回不一样字体颜色
 *
 *  @param labelStr     文字内容
 *  @param lineSpacing  行间距
 *  @param alignment    居中？
 *  @param rangArray    范围range数组
 *  @param color        目标字体颜色
 */
+ (NSAttributedString *)returnDifferentTextColorWithText:(NSString *)labelStr lineSpacing:(CGFloat)lineSpacing alignment:(NSInteger)alignment rangArray:(NSMutableArray *)rangArray color:(UIColor *)color;

#pragma mark - 返回不一样字体颜色 (仅两种字体颜色) 并带有图片
/**
 返回不一样字体颜色 (仅两种字体颜色) 并带有图片

 @param title     内容
 @param imageName 图片
 @param rect      图片Frame
 @param color     内容颜色
 @param index     图片位置
 @param rangArray 范围range数组
 @param color2    目标颜色
 */
+ (NSAttributedString *)returnDifferentTextColorAndImageWithText:(NSString * )title imageName:(NSString *)imageName imageRect:(CGRect)rect color:(NSString *)color index:(NSUInteger)index rangArray:(NSMutableArray *)rangArray color2:(UIColor *)color2;



@end


