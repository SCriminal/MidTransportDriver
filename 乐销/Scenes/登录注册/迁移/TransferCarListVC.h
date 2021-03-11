//
//  TransferCarListVC.h
//  Driver
//
//  Created by 隋林栋 on 2021/3/11.
//Copyright © 2021 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface TransferCarListVC : BaseTableVC

@end

@interface TransferCarListCell : UITableViewCell

@property (strong, nonatomic) UILabel *carNumber;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
