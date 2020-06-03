//
//  BaseImage.m
//中车运
//
//  Created by 隋林栋 on 2017/1/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseImage.h"

@implementation BaseImage
+ (BaseImage *)imageWithCGImage:(CGImageRef)cgImage imageAsset:(PHAsset *)asset{
    BaseImage * baseImage = [[BaseImage alloc]initWithCGImage:cgImage];
    baseImage.asset = asset;
    return baseImage;
}
+ (BaseImage *)imageWithImage:(UIImage *)image url:(NSURL *)url{
    BaseImage * baseImage = [[BaseImage alloc]initWithData:UIImagePNGRepresentation(image)];
    baseImage.imageURL = url.absoluteString;
    return baseImage;
}
+ (NSString *)fetchUrl:(UIImage *)image{
    if ([image isKindOfClass:BaseImage.class]) {
        BaseImage * baseImage = (BaseImage *)image;
        return baseImage.imageURL;
    }
    return nil;
}

@end
