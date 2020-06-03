//
//  UIImageView+Category.h
//中车运
//
//  Created by 隋林栋 on 2017/12/4.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//图片信息
#import "ModelImage.h"
@interface UIImageView (Category)
@property (nonatomic, strong) id model;
@property (nonatomic, assign) double identity;


//sdweb image category
- (void)sd_setProductImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

//show image with modelImage
- (void)sd_setImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName;
- (void)sd_setSmallImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName;
@end
