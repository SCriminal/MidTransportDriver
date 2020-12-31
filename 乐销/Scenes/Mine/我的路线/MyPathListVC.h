//
//  MyPathListVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface MyPathListVC : BaseTableVC

@end

@interface MyPathListCell : UITableViewCell

@property (strong, nonatomic) UIButton *btnEdit;
@property (strong, nonatomic) UIButton *btnDelete;
@property (nonatomic, strong) void (^blockEditClick)(ModelShopAddress *);
@property (nonatomic, strong) void (^blockDeleteClick)(ModelShopAddress *);
@property (nonatomic, strong) ModelShopAddress *model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopAddress *)model;

@end
