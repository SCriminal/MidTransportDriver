//
//  ScanListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/11/19.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanListCell : UITableViewCell

@property (strong, nonatomic) UILabel *labelStatus;
@property (strong, nonatomic) UILabel *labelFrom;
@property (strong, nonatomic) UILabel *labelTo;
@property (strong, nonatomic) UILabel *labelAddressFrom;
@property (strong, nonatomic) UILabel *labelAddressTo;
@property (strong, nonatomic) UIImageView *iconNo;
@property (strong, nonatomic) UIImageView *iconScheduleNo;

@property (strong, nonatomic) UIImageView *iconCargo;
@property (strong, nonatomic) UIImageView *iconWeight;
@property (strong, nonatomic) UILabel *labelBillNo;
@property (strong, nonatomic) UILabel *labelScheduleNo;

@property (strong, nonatomic) UILabel *labelWeight;
@property (strong, nonatomic) UILabel *labelCargo;
@property (strong, nonatomic) UIImageView *iconArrow;
@property (strong, nonatomic) UIImageView *ivBg;

@property (nonatomic, strong) ModelScheduleList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelScheduleList *)model;

@end
