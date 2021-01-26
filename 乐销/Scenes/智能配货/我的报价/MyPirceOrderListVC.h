//
//  MyPirceOrderListVC.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/26.
//Copyright © 2021 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface MyPirceOrderListVC : BaseTableVC
@property (nonatomic, assign) double status;
@property (nonatomic, strong) void (^refreshAll)(void);

@end

@interface MyPirceOrderListCell : UITableViewCell
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) UIButton *btnView;

@property (nonatomic, strong) void (^blockDismiss)(ModelAutOrderListItem *);

@property (nonatomic, strong) ModelAutOrderListItem *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAutOrderListItem *)model;

@end
