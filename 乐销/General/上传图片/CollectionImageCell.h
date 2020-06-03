//
//  CollectionImageCell.h
//中车运
//
//  Created by 隋林栋 on 2017/3/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "CollectionImageCell.h"


@interface CollectionImageCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *btnDelete;
@property  (nonatomic, strong) UIImageView *ivImage;
@property (nonatomic, strong) void (^blockDelete)(UICollectionViewCell *cell);
#pragma mark 获取cell高度
+ (CGSize)fetchHeight;
#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model;
- (void)resetCellWithCamera;

@end

@interface CollectionCustomeImageSizeCell : CollectionImageCell

@end

@interface CollectionCustomeImageReplyCell : CollectionImageCell

@end
