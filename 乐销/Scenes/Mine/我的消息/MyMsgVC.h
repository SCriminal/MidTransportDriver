//
//  MyMsgVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface MyMsgVC : BaseTableVC

@end


@interface MyMsgCell : UITableViewCell

@property (strong, nonatomic) UILabel *stateKey;
@property (strong, nonatomic) UILabel *msgTitle;
@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) UIImageView *arrow;
@property (nonatomic, strong) ModelBtn *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
