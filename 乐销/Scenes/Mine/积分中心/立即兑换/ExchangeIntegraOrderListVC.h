//
//  ExchangeIntegraOrderListVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface ExchangeIntegraOrderListVC : BaseTableVC

@end


@interface ExchangeIntegraOrderListCell : UITableViewCell

@property (strong, nonatomic) UILabel *orderNum;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *arrow;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
