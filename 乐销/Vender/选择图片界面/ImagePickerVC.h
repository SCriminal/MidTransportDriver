//
//  ImagePickerVC.h
//中车运
//
//  Created by 隋林栋 on 2017/4/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC.h"
#import <AssetsLibrary/AssetsLibrary.h>


@class ImagePickerVC;
@class ImagePickerBottomView;
@class DownListViewBG;
@class ImagePikcerListBGVIew;
@protocol ImagePickerVCDelegate <NSObject>
@optional

/**
 *  点击确定的回调
 *
 *  @param assetArray 选中的照片的url数组
 */
- (void)ImagePickerVC: (ImagePickerVC *)ivc finishClick:(NSArray *)assetArray;


/**
 *  点击第一张图片（照相机）的回调
 *
 *  @param image 拍照的image
 */
- (void)ImagePickerVC: (ImagePickerVC *)ivc firstImageClick:(UIImage *)image;


@end

@interface ImagePickerVC : BaseVC<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) id<ImagePickerVCDelegate>delegate;
@property (strong,  nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *selectAssetArray;
@property (nonatomic,strong) NSMutableArray *imageAssetAray;
//sld
@property (nonatomic, strong) ImagePickerBottomView *bottomView;
@property (nonatomic, strong) BaseNavView *navView;
@property (strong, nonatomic) ImagePikcerListBGVIew *viewListBG;
@property (nonatomic, assign) NSInteger  photoNumber;  //限定图片选择的个数

//view set
@property (nonatomic, assign) PHAssetMediaType assetType;//assetType default PHAssetMediaTypeImage

- (void)okBtnClick:(UIButton *)sender;

@end



