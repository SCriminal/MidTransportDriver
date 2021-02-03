//
//  MyMsgListVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface MyMsgListVC : BaseTableVC
@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSString *channel;

@end

@interface MyMsgListCell : UITableViewCell

@property (strong, nonatomic) UILabel *state;
@property (strong, nonatomic) UILabel *msgTitle;
@property (strong, nonatomic) UILabel *msgContent;
@property (strong, nonatomic) UIImageView *iconArrow;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelMsgItem *)model;

@end
