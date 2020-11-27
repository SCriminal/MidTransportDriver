//
//  AutoConfigOrderListCell.h
//  Driver
//
//  Created by 隋林栋 on 2020/11/27.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoConfigOrderListCell : UITableViewCell
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


@interface AutoConfigOrderListFilterView : UIView
//属性
@property (strong, nonatomic) UILabel *addressFrom;
@property (strong, nonatomic) UILabel *addressTo;
@property (strong, nonatomic) UILabel *labelAuto;
@property (strong, nonatomic) UILabel *filter;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

