//
//  IntegralCollectionCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIView *viewFather;
@property (strong, nonatomic) UIImageView *productImage;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *limit;
@property (strong, nonatomic) UILabel *score;
@property (nonatomic, strong) ModelIntegralProduct *model;



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralProduct  *)model;

@end
