//
//  AccountListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/16.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderAccountListCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelPrice;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) ModelAccountList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end


@interface OrderAccountBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *labelSum;
@property (strong, nonatomic) UIButton *btnManage;
@property (nonatomic, strong) void (^blockClick)();

#pragma mark 刷新view
- (void)resetViewWithModel:(double)model;

@end

@interface OrderAccountBottomEditView : UIView
//属性
@property (strong, nonatomic) UILabel *labelSum;
@property (strong, nonatomic) UIButton *btnManage;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (nonatomic, strong) void (^blockClick)();
@property (nonatomic, strong) void (^blockSelectAllClick)(BOOL);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)refreshStatus:(NSArray *)ary;

@end
