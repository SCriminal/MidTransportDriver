//
//  NSString+Category.m
//中车运
//
//  Created by 刘惠萍 on 2017/3/25.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
//运行时 安全
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(substringToIndex:)), class_getInstanceMethod(self, @selector(sldSubstringToIndex:)));
        
        method_exchangeImplementations(class_getClassMethod(self, @selector(substringFromIndex:)), class_getClassMethod(self, @selector(sldSubstringFromIndex:)));
        
    });
}

- (NSString *)sldSubstringToIndex:(NSUInteger)to{
    if (self.length<to) {
        return @"";
    }
    return [self sldSubstringToIndex:to];
}
- (NSString *)sldSubstringFromIndex:(NSUInteger)to{
    if (self.length<to) {
        return @"";
    }
    return [self sldSubstringFromIndex:to];
}

+ (NSNumber * (^)(NSString *))num{
    return ^(NSString *num){
        if (isStr(num)) {
            if ([num doubleValue]) {
                return [NSNumber numberWithDouble:[num doubleValue]];
            }
        }
        return @0;
    };
}
+ (NSString * (^)(NSNumber *))str{
    return ^(NSNumber *num){
        if (isNum(num)) {
            return [NSString stringWithFormat:@"%@",num];
        }
        return @"";
    };
}

+ (NSString * (^)(double))price{
    return ^(double num){
        return [NSString stringWithFormat:@"%.2f",num];
    };
}
+ (NSString * (^)(double))dou{
    return ^(double num){
        return [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:num]];
    };
}


- (NSString *(^)(NSDictionary *))replaceSubparameter{
    return ^(NSDictionary *parameters){
        if (isDic(parameters) && [self rangeOfString:@":"].location != NSNotFound) {
            NSArray * aryColon = [self componentsSeparatedByString:@":"];
            NSString * strOrigin = [[NSString alloc]initWithString:self];
            for (int i = 1; i< aryColon.count; i++) {
                NSString * strItem = aryColon[i];
                NSString * strKey = [strItem componentsSeparatedByString:@"/"].firstObject;
                if ([parameters objectForKey:strKey]) {
                    strOrigin = [strOrigin stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@":%@",strKey] withString:[NSString stringWithFormat:@"%@",[parameters objectForKey:strKey]]].mutableCopy;
                }
            }
            return strOrigin;
        }
        return self;
    };
}

- (NSString *)smallImage{
    return self.smallImageCustomSize(200);
}
- (NSString *)middleImage{
    return self.smallImageCustomSize(400);
}
-(NSString *(^)(NSInteger size))smallImageCustomSize{
    if ([self hasPrefix:IMAGEURL_HEAD]) {
        if ([[SDWebImageManager sharedManager].imageCache diskImageExistsWithKey:self]) {
            return ^(NSInteger size){
                return self;
            };
        }
        return ^(NSInteger size){
            return [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_lfit,h_%ld,w_%ld",self,size,size];
        };
    }
    return ^(NSInteger size){
        return self;
    };
}
/**
 safe separate string; if self.length is equal 0 return empty array
 */
- (NSArray *)componentsValidSeparatedByString:(NSString *)strKey{
    if (!isStr(strKey)) {
        return @[];
    }
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (NSString * str in [self componentsSeparatedByString:strKey]) {
        if (isStr(str)) {
            [aryReturn addObject:str];
        }
    }
    return  aryReturn;
}
//全部有效
+ (BOOL)isAllValid:(NSArray *)aryStrs{
    if (!isAry(aryStrs)) {
        return false;
    }
    for (NSString * strItem in aryStrs) {
        if (!isStr(strItem)) {
            return false;
        }
    }
    return true;
}
//有一个有效
+ (BOOL)isHasOneValid:(NSArray *)aryStrs{
    for (NSString * strItem in aryStrs) {
        if (isStr(strItem)) {
            return true;
        }
    }
    return false;
}

//截取字符串
+ (NSString *)subStr:(NSString *)string num:(NSInteger)num{
    if (!isStr(string)) {
        return @"";
    }
    if (string.length >= num) {
        return [string substringToIndex:num];
    }else{
        return string;
    }
    return @"";
}
//has string in self
- (BOOL)hasString:(NSString *)str{
    if (!isStr(str)) return false;
    NSRange range = [self rangeOfString:str];
    return range.location != NSNotFound;
}

//获取高度
- (CGFloat)fetchHeightWidthLimint:(CGFloat)width fontNum:(CGFloat)fontNum lineSpace:(CGFloat)lineSpace{
    //fetch height
    UIFont * font = [UIFont systemFontOfSize:fontNum];
    CGRect frame = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:lineSpace?@{NSParagraphStyleAttributeName:[NSMutableParagraphStyle initWithLineSpace:lineSpace],NSFontAttributeName:font}:@{NSFontAttributeName:font} context:nil];
    //如果只有一行
    if (lineSpace && CGRectGetHeight(frame) == font.lineHeight + lineSpace) {
        return  font.lineHeight;
    }
    return  CGRectGetHeight(frame);
}


#pragma mark - Base64编码
- (NSString *)base64Encode
{
    //先将string转换成data
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return baseString;
}

#pragma mark - Base64解码
- (NSString *)base64Decode
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

@end

