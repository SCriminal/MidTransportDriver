//
//  CarListCell.h
//  Driver
//
//  Created by 隋林栋 on 2020/5/29.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarListCell : UITableViewCell

@property (strong, nonatomic) UILabel *carNumber;
@property (strong, nonatomic) UILabel *carOwner;
@property (strong, nonatomic) UILabel *weight;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *statusDetail;
@property (strong, nonatomic) UIImageView *deleteIcon;
@property (strong, nonatomic) UIImageView *editIcon;
@property (nonatomic, strong) ModelCar *model;
@property (nonatomic, strong) void (^blockDelete)(ModelCar *);
@property (nonatomic, strong) void (^blockEdit)(ModelCar *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
