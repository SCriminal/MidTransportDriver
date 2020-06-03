//
//  UIImage+info.h
//  自定义相机
//
//  Created by macbook on 16/9/3.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (info)

+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size;
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
/**
 生成纯色图片带文字文字居中
 
 @param text 文字
 @param bgColor 背景颜色
 @param size 绘制图片大小
 @return 图片
 */
+(UIImage *)circleImageWithText:(NSString *)text bgColor:(UIColor *)bgColor size:(CGSize)size;



/**
 // 1.将文字添加到图片上;tImage 图片名字， text 需画的字体
 
 @param tImage 图片名字
 @param text 需画的文字
 @param textColor 文字颜色
 @param textFont 文字大小
 @param pointX 距离左侧距离 0-1  居中0.5
 @param pointY 距离顶部距离 0-1  居中0.5
 @return 图片
 */
+(UIImage *)createShareImage:(UIImage *)tImage context:(NSString *)text textColor:(UIColor *)textColor  textFont:(CGFloat)textFont x:(CGFloat)pointX y:(CGFloat)pointY;

/**
 // 2.在图片上添加图片;tImage 1.底部图片名字imageName， image2 需添加的图片
 
 @param tImage 底部图片名
 @param image2 需添加的图片
 @param isClip 是否椭圆（如果矩形是正方形  为正圆）
 @param pointX 距离左侧距离 0-1  居中0.5
 @param pointY 距离顶部距离 0-1  居中0.5
 @param zoom 添加图片缩放比
 @return 图片
 */
+(UIImage *)createShareImage:(UIImage *)tImage ContextImage:(UIImage *)image2 isClip:(BOOL)isClip x:(CGFloat)pointX y:(CGFloat)pointY zoom:(CGFloat)zoom;
@end
