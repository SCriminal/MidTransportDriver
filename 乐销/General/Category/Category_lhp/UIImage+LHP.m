//
//  UIImage+LHP.m
//中车运
//
//  Created by 刘惠萍 on 2017/7/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIImage+LHP.h"
//runtime
#import <objc/runtime.h>

@implementation UIImage (LHP)

#pragma mark swtich method
+ (void)load{
    method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)), class_getClassMethod(self, @selector(sld_imageNamed:)));
}

+ (instancetype)sld_imageNamed:(NSString *)name{
    if (name && [name isKindOfClass:NSString.self] && name.length > 0 ) {
        return [self sld_imageNamed:name];
    }
    return nil;
}

#pragma init image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+(UIImage *)creatCodeGeneratorWithMessage:(NSString *)message withSize:(CGFloat)size;
{
    //1,创建过滤器
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2,恢复默认
    [filter setDefaults];
    //3,给过滤器添加数据
    NSString * dataString = [NSString stringWithFormat:@"%@",message];
    NSData   * data       = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    //4,给View设置二维码
    return [UIImage imageBlackToTransparent:[UIImage createNonInterpolatedUIImageFormCIImage:[filter outputImage] withSize:size] withRed:0 andGreen:0 andBlue:0];
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
void ProviderReleaseData (void *info, const void *data, size_t size){
    
    free((void*)data);
    
}

+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t      bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
            
        {
            
            // 改成下面的代码，会将图片转成想要的颜色
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            
            ptr[3] = red; //0~255
            
            ptr[2] = green;
            
            ptr[1] = blue;
            
        }
        
        else
            
        {
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            
            ptr[0] = 0;
            
        }
        
    }
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        
                                        NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
    
}


#pragma mark - SaveCurrentScreen
+(UIImage *)captureImageFromView:(UIView *)view
{
    return [self captureImageFromView:view size:view.bounds.size];
}

+(UIImage *)captureImageFromView:(UIView *)view size:(CGSize)size
{
    //清晰度高
    UIGraphicsBeginImageContextWithOptions(size,NO, [[UIScreen mainScreen] scale]);
    //清晰度低
    //    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - SaveCurrentScreen
+(UIImage *)customImageFromView:(NSArray *)images

{
    CGFloat  width = 0.0f;
    CGFloat height = 0.0f;
    for (UIImage * image in images) {
        width = image.size.width>width?image.size.width:width;
        height += image.size.height;
    }
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(size,NO, [[UIScreen mainScreen] scale]);
    
    CGFloat top = 0.0f;
    for (UIImage * image in images) {
        [image drawInRect:CGRectMake(0, top, image.size.width, image.size.height)];
        top += image.size.height;
    }
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

//压缩图片至100k以下
+(NSData *)imageData:(UIImage *)myimage{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {
            //1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
            
        }else if (data.length>512*1024) {
            //0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
            
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
            
        }
    }
    return data;
    
}

+(NSData *)thumbDataWithImageData:(NSData *)imageData {
    
    
    NSData *newImageData = imageData;
    
    UIImage *image = [UIImage imageWithData:newImageData];
    CGRect newRect = CGRectMake((image.size.width-200)/2, (image.size.height-200)/2, 200, 200);
    image = [self clipWithImageRect:newRect clipImage:image];
    
    UIGraphicsBeginImageContext(newRect.size);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newRect.size.width, (NSInteger)newRect.size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  UIImageJPEGRepresentation(newImage,0.1);
}

//返回裁剪区域图片,返回裁剪区域大小图片

+ (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage

{
    CGImageRef imageRef = CGImageCreateWithImageInRect([clipImage CGImage], clipRect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
    
}

@end
