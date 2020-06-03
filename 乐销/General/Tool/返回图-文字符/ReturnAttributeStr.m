//
//  ReturnAttributeStr.m
//  天下农商
//
//  Created by Mac on 2016/12/30.
//  Copyright © 2016年 mirror. All rights reserved.
//

#import "ReturnAttributeStr.h"
//MD5
#import <CommonCrypto/CommonDigest.h>

@implementation ReturnAttributeStr

#pragma mark - 返回图文字符串
+ (NSMutableAttributedString *)setAttributeTitle:(NSString * )title imageName:(NSString *)imageName imageRect:(CGRect)rect withIndex:(NSUInteger)index;
{
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:imageName];
    attch.bounds = rect;
    
    NSAttributedString * string1 = [NSAttributedString attributedStringWithAttachment:attch];
    NSMutableAttributedString * tittleAttr = [[NSMutableAttributedString alloc]initWithString:title];
    
    [tittleAttr insertAttributedString:string1 atIndex:index];
    
    return tittleAttr;
}

#pragma mark - md5加密
+ (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16]= "0123456789abcdef";
    // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - 封装地址 -
+ (NSString *)getAdressWithProvience:(NSString *)provience City:(NSString *)city
{
    city = [city stringByReplacingOccurrencesOfString:provience withString:@""];
    
    NSString * adress = [NSString stringWithFormat:@"%@ %@",provience,city];
    
    adress = [adress stringByReplacingOccurrencesOfString:@"自治区" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"回族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"壮族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"维吾尔" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"朝鲜族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"哈尼族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"彝族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"土家族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"苗族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"藏族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"回族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"羌族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"布依族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"侗族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"傣族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"白族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"景颇族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"傈僳族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"蒙古族" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"地区" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"自治县" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"柯尔克孜" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"哈萨克" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"香港" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"澳门" withString:@""];
    adress = [adress stringByReplacingOccurrencesOfString:@"台湾" withString:@""];
    
    if (adress.length < 2)
    {
        adress = @"老刀网友";
    }
    
    NSString * str = [adress substringFromIndex:adress.length-1];
    if ([str isEqualToString:@" "])
    {
        adress = [adress stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return adress;
}

#pragma mark - 返回NSAttributedString
+ (NSAttributedString *)returnNSAttributedStringWithDetailStr:(NSString *)labelStr withlineSpacing:(CGFloat)lineSpacing withAlignment:(NSInteger)alignment withFont:(UIFont *)font
{
    NSString * detailStr = labelStr;
    
    if (detailStr.length > 0 && ![detailStr isEqualToString:@"<null>"] && ![detailStr isEqualToString:@"(null)"])
    {
        NSMutableAttributedString * detailAttrString = [[NSMutableAttributedString alloc]initWithString:detailStr];
        NSMutableParagraphStyle * detailParagtaphStyle = [[NSMutableParagraphStyle alloc]init];
        detailParagtaphStyle.alignment = alignment;      //设置两端对齐(3)
        detailParagtaphStyle.lineSpacing = lineSpacing;  //行间距
        NSDictionary * detaiDic = @{NSFontAttributeName : font,
                                    //NSKernAttributeName : [NSNumber numberWithInteger:W(0)],
                                    NSParagraphStyleAttributeName : detailParagtaphStyle,
                                    NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
        
        [detailAttrString setAttributes:detaiDic range:NSMakeRange(0, detailAttrString.length)];
        NSAttributedString * resultAttrString = [detailAttrString copy];
        
        return resultAttrString;
    }
    else
    {
        return nil;
    }
}

#pragma mark - 返回NSAttributedString并且带图片
+ (NSAttributedString *)returnNSAttributedStringWithContentStr:(NSString *)labelStr withlineSpacing:(CGFloat)lineSpacing withAlignment:(NSInteger)alignment withFont:(UIFont *)font withImageName:(NSString *)imageName withImageRect:(CGRect)rect withAtIndex:(NSUInteger)index
{
    NSString * detailStr = labelStr;
    
    if (detailStr.length > 0 && ![detailStr isEqualToString:@"<null>"] && ![detailStr isEqualToString:@"(null)"])
    {
        NSMutableAttributedString * detailAttrString = [[NSMutableAttributedString alloc]initWithString:detailStr];
        NSMutableParagraphStyle * detailParagtaphStyle = [[NSMutableParagraphStyle alloc]init];
        detailParagtaphStyle.alignment = alignment;      //设置两端对齐(3)
        detailParagtaphStyle.lineSpacing = lineSpacing;  //行间距
        NSDictionary * detaiDic = @{NSFontAttributeName : font,
                                    //NSKernAttributeName : [NSNumber numberWithInteger:W(0)],
                                    NSParagraphStyleAttributeName : detailParagtaphStyle,
                                    NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
        
        [detailAttrString setAttributes:detaiDic range:NSMakeRange(0, detailAttrString.length)];
        
        //设置图片
        NSTextAttachment * attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:imageName];
        attch.bounds = rect;
        NSAttributedString * string1 = [NSAttributedString attributedStringWithAttachment:attch];
        [detailAttrString insertAttributedString:string1 atIndex:index];
        
        NSAttributedString * resultAttrString = [detailAttrString copy];
        
        return resultAttrString;
    }
    else
    {
        return nil;
    }
}

#pragma mark - 返回不一样额字体大小
/**
 *  返回不一样的字体大小
 *
 *  @param needText    文字内容
 *  @param big         大字体
 *  @param small       小字体
 *  @param rangeArray  范围range数组
 */
+ (NSMutableAttributedString *) returnDifferentFontWithText:(NSString*)needText bigFont:(CGFloat)big smallFont:(CGFloat)small rangeArray:(NSMutableArray *)rangeArray;
{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    
    UIFont * bigFont = [UIFont systemFontOfSize:big];
    UIFont * smallFont = [UIFont systemFontOfSize:small];
    
    [attrString addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange( 0, needText.length)];
    
    for ( NSValue * value in rangeArray)
    {
        [attrString addAttribute:NSFontAttributeName value:bigFont range:value.rangeValue];
    }
    
    return attrString;
}

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
+ (NSAttributedString *)returnDifferentTextColorWithText:(NSString *)labelStr lineSpacing:(CGFloat)lineSpacing alignment:(NSInteger)alignment rangArray:(NSMutableArray *)rangArray color:(UIColor *)color
{
    NSString * detailStr = labelStr;
    if (isStr(detailStr))
    {
        NSMutableAttributedString * detailAttrString = [[NSMutableAttributedString alloc]initWithString:detailStr];
        
        NSMutableParagraphStyle * detailParagtaphStyle = [[NSMutableParagraphStyle alloc]init];
        detailParagtaphStyle.alignment = alignment;      //设置两端对齐(3)
        detailParagtaphStyle.lineSpacing = lineSpacing;  //行间距
        NSDictionary * detaiDic = @{NSParagraphStyleAttributeName : detailParagtaphStyle,
                                    NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
        
        [detailAttrString addAttributes:detaiDic range:NSMakeRange(0, detailAttrString.length)];
        
        for (NSValue * rangeVal in rangArray)
        {
            [detailAttrString addAttributes:@{NSForegroundColorAttributeName : color} range:rangeVal.rangeValue];
        }
        
        NSAttributedString * resultAttrString = [detailAttrString copy];
        
        return resultAttrString;
    }
    else
    {
        return nil;
    }
}


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
+ (NSAttributedString *)returnDifferentTextColorAndImageWithText:(NSString * )title imageName:(NSString *)imageName imageRect:(CGRect)rect color:(NSString *)color index:(NSUInteger)index rangArray:(NSMutableArray *)rangArray color2:(UIColor *)color2
{
    NSTextAttachment * attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:imageName];
    attch.bounds = rect;
    
    NSAttributedString *string1 = [NSAttributedString attributedStringWithAttachment:attch];
    NSMutableAttributedString *tittleAttr = [[NSMutableAttributedString alloc]initWithString:title];
    
    [tittleAttr insertAttributedString:string1 atIndex:index];
    
    [tittleAttr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:color] range:NSMakeRange(0,tittleAttr.length)];
    
    for (NSValue * rangeVal in rangArray)
    {
        [tittleAttr addAttributes:@{NSForegroundColorAttributeName : color2} range:rangeVal.rangeValue];
    }
    
    return tittleAttr;
}


@end
