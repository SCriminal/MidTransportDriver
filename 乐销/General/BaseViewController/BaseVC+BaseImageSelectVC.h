//
//  BaseVC+BaseImageSelectVC.h
//中车运
//
//  Created by 隋林栋 on 2017/1/2.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC.h"
//选择图片
#import "ImagePickerVC.h"
//select video
#import "VideoPickerVC.h"

@class BaseImage;
@interface BaseVC (BaseImageSelectVC)<ImagePickerVCDelegate>
//选择图片
- (void)showImageVC:(int)imageNum;
- (UIViewController *)fetchImageVC:(int)imageNum;
- (void)imageSelect:(BaseImage *)image;
- (void)imagesSelect:(NSArray *)aryImages;

//选择视频
- (void)showVideoVC:(int)imageNum;

@end
