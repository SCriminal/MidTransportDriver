//
//  NSString+Category.h
//中车运
//
//  Created by 刘惠萍 on 2017/3/25.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
@property (class,nonatomic, readonly) NSNumber * (^num)(NSString *);

@property (class,nonatomic, readonly) NSString * (^price)(double);

@property (class,nonatomic, readonly) NSString * (^dou)(double);

@property (class,nonatomic, readonly) NSString * (^str)(NSNumber *);
//替换url 的子参数
@property (nonatomic, readonly) NSString * (^replaceSubparameter)(NSDictionary *);


@property (nonatomic, readonly) NSString *smallImage;
@property (nonatomic, readonly) NSString *middleImage;
@property (nonatomic, readonly) NSString * (^smallImageCustomSize)(NSInteger);

/**
 safe separate string; if self.length is equal 0 return empty array
 */
- (NSArray *)componentsValidSeparatedByString:(NSString *)strKey;

+ (BOOL)isAllValid:(NSArray *)aryStrs;//全部有效
+ (BOOL)isHasOneValid:(NSArray *)aryStrs;//有一个有效
//截取字符串
+ (NSString *)subStr:(NSString *)string num:(NSInteger)num;
- (BOOL)hasString:(NSString *)str;//has string in self
//获取高度
- (CGFloat)fetchHeightWidthLimint:(CGFloat)width fontNum:(CGFloat)fontNum lineSpace:(CGFloat)lineSpace;
#pragma mark - Base64编码
- (NSString *)base64Encode;
#pragma mark - Base64解码
- (NSString *)base64Decode;
@end

