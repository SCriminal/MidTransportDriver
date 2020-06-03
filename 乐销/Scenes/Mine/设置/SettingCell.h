//
//  SettingCell.h
//中车运
//
//  Created by 隋林栋 on 2018/10/16.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *subTitle;
@property (strong, nonatomic) UILabel *labelAlert;

@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UIView *line;
@property (nonatomic, strong) ModelBtn *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model;

@end


@interface SettingEmptyCell : UITableViewCell

@property (strong, nonatomic) UIView *line;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end

