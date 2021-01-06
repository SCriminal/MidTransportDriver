//
//  FeedBackHistoryListVC.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/6.
//Copyright © 2021 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface FeedBackHistoryListVC : BaseTableVC

@end

@interface FeedBackHistoryListCell : UITableViewCell

@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *arrow;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end

@interface SuggestHistoryListVC : BaseTableVC

@end
