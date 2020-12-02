//
//  OrderListCell.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListCellBtnView.h"

@interface OrderListCell : UITableViewCell
@property (strong, nonatomic) UILabel *addressFrom;
@property (strong, nonatomic) UILabel *addressTo;
@property (strong, nonatomic) UIImageView *iconAddress;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) OrderListCellBtnView *btnView;


@property (nonatomic, strong) void (^blockDetail)(ModelOrderList *);

@property (nonatomic, strong) ModelOrderList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderList *)model;

@end

