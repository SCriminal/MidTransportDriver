//
//  AuthListVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface AuthListVC : BaseTableVC

@end


@interface AuthListCell : UITableViewCell

@property (strong, nonatomic) UILabel *infoName;
@property (strong, nonatomic) UILabel *submitTime;
@property (strong, nonatomic) UILabel *authTime;
@property (strong, nonatomic) UILabel *reason;
@property (strong, nonatomic) UIButton *btn;
@property (nonatomic, strong) void (^blockClick)(void);

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
