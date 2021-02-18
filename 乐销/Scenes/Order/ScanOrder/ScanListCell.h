//
//  ScanListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/11/19.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanListCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconArrow;
@property (strong, nonatomic) UILabel *labelFrom;
@property (strong, nonatomic) UILabel *labelTo;
@property (strong, nonatomic) UILabel *labelAddressFrom;
@property (strong, nonatomic) UILabel *labelAddressTo;

@property (strong, nonatomic) UIImageView *ivBg;

@property (nonatomic, strong) ModelScheduleList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelScheduleList *)model;

+ (CGFloat)addTitle:(ModelBtn *)modelBtn  view:(UIView *)superView top:(CGFloat)top;

@end
