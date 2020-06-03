//
//  UIView+SelectImageView.h
//中车运
//
//  Created by 隋林栋 on 2017/1/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//选择图片
#import "ImagePickerVC.h"

@class BaseImage;
@interface UIView (SelectImageView)<ImagePickerVCDelegate>
//选择图片
- (void)showImageVC:(NSInteger)imageNum;
- (void)imageSelect:(BaseImage *)image;
- (void)imagesSelect:(NSArray *)aryImages;

@end
