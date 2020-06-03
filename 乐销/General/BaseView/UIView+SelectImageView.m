//
//  UIView+SelectImageView.m
//中车运
//
//  Created by 隋林栋 on 2017/1/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIView+SelectImageView.h"
//需要上传的image
#import "BaseImage.h"
//photo asset
#import <AssetsLibrary/AssetsLibrary.h>
//photo
#import <Photos/Photos.h>

@implementation UIView (SelectImageView)

//选择图片
- (void)showImageVC:(NSInteger)imageNum{
    ImagePickerVC * vc = [[ImagePickerVC alloc]init];
    vc.photoNumber = imageNum;
    vc.delegate = self;
    [GB_Nav pushViewController:vc animated:true];
}


#pragma mark 选择图片回调
- (void)ImagePickerVC: (ImagePickerVC *)ivc finishClick:(NSArray *)assetArray{
    [GlobalMethod fetchPhotoAuthorityBlock:^{
        
        NSMutableArray * aryAll = [NSMutableArray array];
        PHImageManager *imageManager = [[PHImageManager alloc] init];
        PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
        //    opt.resizeMode = PHImageRequestOptionsResizeModeNone;
        opt.synchronous = YES;
        opt.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;;
        for (PHAsset *asset in assetArray) {
            [imageManager requestImageForAsset:asset targetSize:CGSizeMake(SCREEN_WIDTH/2.0,SCREEN_HEIGHT/2.0) contentMode:PHImageContentModeAspectFit options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                [aryAll addObject: [BaseImage imageWithCGImage:result.CGImage imageAsset:asset]];
            }];
        }
        if (aryAll.lastObject) {
            [self  imageSelect:aryAll.lastObject];
        }
        [self imagesSelect:aryAll];
    }];
}



/**
 *  点击第一张图片（照相机）的回调
 *
 *  @param image 拍照的image
 */
- (void)ImagePickerVC: (ImagePickerVC *)ivc firstImageClick:(UIImage *)image{
    [GlobalMethod fetchPhotoAuthorityBlock:^{
        BaseImage *imageBase = [BaseImage imageWithCGImage:image.CGImage imageAsset:nil];
        [self  imageSelect:imageBase];
        
        NSMutableArray * muAry = [NSMutableArray array];
        [muAry addObject:imageBase];
        [self imagesSelect:muAry];
        
        [GB_Nav popViewControllerAnimated:true];
    }];
}

#pragma mark 图片选择
- (void)imageSelect:(BaseImage *)image{
    
}
- (void)imagesSelect:(NSArray *)aryImages{
    
}
@end
