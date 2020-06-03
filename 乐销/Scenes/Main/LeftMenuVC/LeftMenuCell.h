//
//  LeftMenuCell.h
//  Driver
//
//  Created by 隋林栋 on 2018/11/30.
//Copyright © 2018 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuCell : UITableViewCell
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *labelTitle;
@property (nonatomic, strong) ModelBtn *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model;

@end
