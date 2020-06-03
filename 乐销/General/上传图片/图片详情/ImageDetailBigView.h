//
//  ImageDetailBigView.h
//中车运
//
//  Created by 隋林栋 on 2017/3/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"

@class  UpImageWithTextModel;
@interface ImageDetailBigView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextViewDelegate>
@property (nonatomic, strong) BaseNavView *navView;
@property (nonatomic, strong) NSMutableArray * aryDatas;
@property (nonatomic, strong) PlaceHolderTextView *label;
@property (nonatomic, strong) UIScrollView *viewBG;
@property (nonatomic, strong) UICollectionView *collectionImageDetail;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, strong) void (^blockRefresh)(void);

- (void)resetView:(NSMutableArray *)ary isEdit:(BOOL)isEdit index:(NSInteger)index;
- (void)showInView:(UIView *)view imageViewShow:(UIImageView *)iv;
@end

@interface UpImageDetailImageViewCell : UICollectionViewCell<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UpImageWithTextModel *model;
@property (nonatomic, strong) ModelImage *modelItem;
@property (nonatomic, strong) UIScrollView *scBG;
@property (nonatomic, strong) void (^blockClick)();
@property (nonatomic, strong) void (^hidenBlockClick)();
@property (nonatomic, strong) UIView  *detailBigView;
@property (nonatomic, strong) UIView  *navView;
@property (nonatomic, strong) UIView  *viewBG;


#pragma mark 获取cell高度
+ (CGSize)fetchHeight;
#pragma mark 刷新view
- (void)resetWithModel:(ModelImage*)model isEdit:(BOOL)isEdit;
//recover scroll view
- (void)recoverScrollView;
@end
