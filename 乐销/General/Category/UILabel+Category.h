//
//  UILabel+Category.h
//中车运
//
//  Created by 刘惠萍 on 2017/4/29.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

@property (nonatomic, assign) CGFloat lineSpace;//行间距 只有扩展方法适配才能计算
@property (nonatomic, assign) CGFloat fontNum;//设置字号
@property (nonatomic, assign) int numLimit;//字符数限制

//获取刷新客户标签
-(void)resetCustomerType:(double)type;


/**
 固定宽度
 
 @param width 宽度
 */
- (void)fitFixed:(CGFloat)width;
/**
 固定宽度
 @param title 内容
 @param width 宽度
 */
- (void)fitTitle:(NSString *)title fixed:(CGFloat)width;

/**
 可变宽度
 
 @param width 宽度
 */
- (void)fitVariable:(CGFloat)width;
/**
 可变宽度
 @param title 内容
 @param width 宽度
 */
- (void)fitTitle:(NSString *)title variable:(CGFloat)width;


/**
 attribute label 固定宽度
 
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrFixed:(CGFloat)width models:(NSArray *)models;

/**
 attribute label 固定宽度
 
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrFixed:(CGFloat)width models:(NSArray *)models lineSpace:(CGFloat)lineSpace;

/**
 attribute label 可变宽度
 
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrVariable:(CGFloat)width models:(NSArray *)models;

/**
 attribute label 可变宽度
 
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrVariable:(CGFloat)width models:(NSArray *)models lineSpace:(CGFloat)lineSpace;


//计算高度的方法
- (CGSize)fetchRectWithString:(NSString *)string width:(CGFloat)width;


//fetch rect of range
- (CGRect)boundingRectForCharacterRange:(NSRange)range;
//limit width then subtract text
- (void)configStringWithLimitWidth;

//fetch height
+ (CGFloat)fetchHeightFontNum:(CGFloat)numFont string:(NSString *)title lineSpace:(CGFloat)lineSpace widthLimit:(CGFloat)widthLimit heightLimit:(CGFloat)heightLimit;
//fetch widht
+ (CGFloat)fetchWidthFontNum:(CGFloat)num text:(NSString *)str;

//设置label默认阴影
-(void)setNormalShadow;
//设置label阴影
-(void)setShadowColor:(UIColor *)shadowColor range:(NSRange)range offsetsize:(CGSize)size;
#pragma mark logical
//价格与累积采购之间添加I
-(void)setPriceLabelSpaceMark:(NSString*)attributeStr;


@end
