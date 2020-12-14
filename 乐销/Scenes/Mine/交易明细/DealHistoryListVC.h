//
//  DealHistoryListVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface DealHistoryListVC : BaseTableVC

@end
@interface DealHistoryListCell : UITableViewCell

@property (strong, nonatomic) UILabel *state;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *stateShow;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
