//
//  CarTeamListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/11.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTeamListCell : UITableViewCell

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAttaceedCompany *)model;

@end
