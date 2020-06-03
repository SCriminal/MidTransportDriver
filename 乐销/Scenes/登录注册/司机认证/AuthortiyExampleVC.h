//
//  AuthortiyExampleVC.h
//  Driver
//
//  Created by 隋林栋 on 2019/8/23.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface AuthortiyExampleVC : BaseTableVC



@end
@interface AuthortiyExampleCell : UITableViewCell

@property (strong, nonatomic) UIImageView *ivImage;
@property (strong, nonatomic) UILabel *labelExplain;
@property (nonatomic, strong) UIView *line;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;

@end
