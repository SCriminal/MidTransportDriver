//
//  Collection_Image.h
//中车运
//
//  Created by 隋林栋 on 2017/1/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//上传图片
#import "UIView+SelectImageView.h"
#import "UpImageWithTextVC.h"//编辑图片
//up image type
#import "AliClient.h"

@interface Collection_Image : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
#pragma mark property datas
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) void(^blockUpComplete)(void);
#pragma mark property can change the view
/**
 if is edit the first is camera,default true
 */
@property (nonatomic, assign) BOOL isEditing;


/**
 the collection slide orientation,default is horizon
 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/**
 default CollectionImageCell, if change cell will exchange
 */
@property (nonatomic, strong) NSString *collectionCellName;

#pragma mark init
- (instancetype)initWithConfig:(BOOL)config;
#pragma mari init 
- (void)configView;
#pragma mark 刷新cell
- (void)resetWithAry:(NSMutableArray *)aryDatas;
#pragma mark 显示选中的图片
- (void)showSelectImage;
- (UpImageWithTextVC *)fetchTextImageVC;//show text vc
#pragma mark 获取请求数据
- (NSString *)fetchRequestImgString;
@end
