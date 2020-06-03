//
//  ImagePickerCollectionCell.h
//中车运
//
//  Created by 隋林栋 on 2017/4/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//photo asset
#import <AssetsLibrary/AssetsLibrary.h>
//photo
#import <Photos/Photos.h>
//通用选择按钮
#import "ImageControl.h"

@interface ImagePickerCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) ImageControl *rightButton;
@property (nonatomic, strong) void(^blockClick)(ImagePickerCollectionCell *);//单选使用
@property (nonatomic, strong) PHImageRequestOptions *opt;//image fetch opt
@property (nonatomic, strong) PHImageManager *imageManager;//image fetch manager

#pragma mark 刷新cell
- (void)resetCellWithImage:(PHAsset *)image isSelected:(BOOL)iseSelected;
@end

@interface ImagePickerBottomView : UIView
//属性
@property (strong, nonatomic) UIButton *btnComplete;
@property (strong, nonatomic) UIButton *btnSelectAlbum;
@property (strong, nonatomic) UIImageView *iconArrow;

#pragma mark 创建
+ (instancetype)initWithModel:(id)model;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface ImagePikcerListBGVIew : UIControl//属性
@property (strong, nonatomic) UIView *listView;
@property (strong, nonatomic) UIControl *viewBG;
@property (strong, nonatomic) NSArray *aryDatas;
@property BOOL isAnimate;
@property (nonatomic, strong) void (^blockSelect)(PHAssetCollection *);
#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)arydatas height:(CGFloat)height;
#pragma mark 动画显示
- (void)hideAnimation;
- (void)showAnimation;
@end

