//
//  CardListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/9/20.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardListCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelBankName;
@property (nonatomic, strong) UILabel *labelCardNum;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIImageView *iconEdit;
@property (nonatomic, strong) UILabel *labelEdit;
@property (nonatomic, strong) UIImageView *iconDelete;
@property (nonatomic, strong) UILabel *labelDelete;
@property (nonatomic, strong) UIImageView *ivBG;
@property (nonatomic, strong) void (^blockEditClick)(ModelBank *);
@property (nonatomic, strong) void (^blockDeleteClick)(ModelBank *);
@property (nonatomic, strong) ModelBank *model;




#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBank *)model;

@end
