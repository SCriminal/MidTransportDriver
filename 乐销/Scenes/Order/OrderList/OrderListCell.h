//
//  OrderListCell.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
@property (strong, nonatomic) UILabel *addressFrom;
@property (strong, nonatomic) UILabel *addressTo;
@property (strong, nonatomic) UIView *iconAddress;
@property (strong, nonatomic) UILabel *packageAddress;
@property (strong, nonatomic) UILabel *import;
@property (strong, nonatomic) UILabel *loadAddress;
@property (strong, nonatomic) UIImageView *ivBg;

@property (strong, nonatomic) UIButton *btnLeft;
@property (strong, nonatomic) UIButton *btnRight;
@property (nonatomic, strong) void (^blockDetail)(ModelOrderList *);

@property (nonatomic, strong) ModelOrderList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderList *)model;

@end

