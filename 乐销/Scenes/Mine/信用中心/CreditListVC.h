//
//  CreditListVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface CreditListVC : BaseTableVC

@end

@interface CreditListCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *num;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCreditListItem *)model;

@end
