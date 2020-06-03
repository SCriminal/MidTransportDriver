//
//  UIImage+info.m
//  自定义相机
//
//  Created by macbook on 16/9/3.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "UIImage+info.h"

@implementation UIImage (info)

/**
 *将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size{
    
    // 得到图片上下文，指定绘制范围
    UIGraphicsBeginImageContext(size);
    
    // 将图片按照指定大小绘制
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前图片上下文中导出图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 当前图片上下文出栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}
/**
 生成纯色图片带文字文字居中
 
 @param text 文字
 @param bgColor 背景颜色
 @param size 绘制图片大小
 @return 图片
 */
+(UIImage *)circleImageWithText:(NSString *)text bgColor:(UIColor *)bgColor size:(CGSize)size{
    NSDictionary *fontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:W(20)], NSForegroundColorAttributeName: [UIColor whiteColor]};
    if (CGColorEqualToColor(bgColor.CGColor, [UIColor whiteColor].CGColor)) {
        bgColor = [UIColor blueColor];
    }
    CGSize textSize = [text sizeWithAttributes:fontAttributes];
    
    CGPoint drawPoint = CGPointMake((size.width - textSize.width)/2, (size.height - textSize.height)/2);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    
    CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
    
    [path fill];
    
    [text drawAtPoint:drawPoint withAttributes:fontAttributes];
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImg;
}



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
+(UIImage *)createShareImage:(UIImage *)tImage context:(NSString *)text textColor:(UIColor *)textColor  textFont:(CGFloat)textFont x:(CGFloat)pointX y:(CGFloat)pointY
{
    UIImage *sourceImage = tImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    
    //画 自己想要画的内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:textFont],NSForegroundColorAttributeName: textColor};
    CGSize textSize = [text sizeWithAttributes:attributes];
    [text drawAtPoint:CGPointMake((imageSize.width - textSize.width)*pointX,(imageSize.height-textSize.height)*pointY) withAttributes:attributes];
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

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
+(UIImage *)createShareImage:(UIImage *)tImage ContextImage:(UIImage *)image2 isClip:(BOOL)isClip x:(CGFloat)pointX y:(CGFloat)pointY zoom:(CGFloat)zoom
{
    UIImage *sourceImage = tImage;
    UIImage *addImage = image2;
    CGSize imageSize; //画的背景 大小
    CGSize addImageSize; //添加的图片 大小
    imageSize = [sourceImage size];
    addImageSize = [addImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //画 自己想要画的内容(添加的图片)
    CGContextDrawPath(context, kCGPathStroke);
    
    CGRect rect = CGRectMake( (imageSize.width-addImageSize.width * zoom) * pointX,(imageSize.height-addImageSize.height * zoom) * pointY , addImageSize.width * zoom, addImageSize.height * zoom);
    //椭圆（如果矩形是正方形  为正圆）
    if (isClip) {
        CGContextAddEllipseInRect(context, rect);
    }else{
        //添加矩形
        CGContextAddRect(context, rect);
    }
    CGContextClip(context);
    
    [image2 drawInRect:rect];
    
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}



@end

