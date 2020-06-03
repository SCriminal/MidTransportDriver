//
//  UIImage+LHP.h
//中车运
//
//  Created by 刘惠萍 on 2017/7/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LHP)
/**
 *  取消searchBar的背景色
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  生成个人二维码
 *
 *  @param message 用户ID
 *  @param size    大小
 *
 *  @return Image
 */
+(UIImage *)creatCodeGeneratorWithMessage:(NSString *)message withSize:(CGFloat)size;

/**
 *  生成屏幕截图
 *
 *  @param view 当前视图
 *
 *  @return Image
 */
+(UIImage *)captureImageFromView:(UIView *)view;
+(UIImage *)captureImageFromView:(UIView *)view size:(CGSize)size;
#pragma mark - SaveCurrentScreen
+(UIImage *)customImageFromView:(NSArray *)images;
//压缩图片至100k以下
+(NSData *)imageData:(UIImage *)myimage;
+(NSData *)thumbDataWithImageData:(NSData *)imageData;
//返回裁剪区域图片,返回裁剪区域大小图片
+ (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;


//这两个方法是为了设置 二维码的。因为在上面生成二维码的方法中将 网址写死了。只能将这两个方法拿出来
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
