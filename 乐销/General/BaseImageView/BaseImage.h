//
//  BaseImage.h
//中车运
//
//  Created by 隋林栋 on 2017/1/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//photo asset
#import <AssetsLibrary/AssetsLibrary.h>
//photo
#import <Photos/Photos.h>

@interface BaseImage : UIImage
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) BOOL upHightQualityComplete;
@property (nonatomic, assign) BOOL upComplete;
@property (nonatomic, strong) NSString *identity;

+ (BaseImage *)imageWithCGImage:(CGImageRef)cgImage imageAsset:(PHAsset *)asset;
+ (BaseImage *)imageWithImage:(UIImage *)image url:(NSURL *)url;

+ (NSString *)fetchUrl:(UIImage *)image;
@end
