//
//  OrderDetailTopView.h
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailView : UIView
@property (nonatomic, strong) ModelTransportOrder *model;

- (void)resetViewWithModel:(ModelTransportOrder *)model;
@end




@interface OrderDetailTrackCell : UITableViewCell

@property (strong, nonatomic) UILabel *l;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIView *dot;
@property (strong, nonatomic) UIView *line;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelLocationItem *)model;

@end
