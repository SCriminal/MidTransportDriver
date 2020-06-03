//
//  DriverDetailTopView.h
//  Driver
//
//  Created by 隋林栋 on 2018/12/27.
//Copyright © 2018 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverDetailTopView : UIView

//属性
@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *brief;
@property (nonatomic, strong) void (^blockClick)(void);

@end



@interface DriverDetailCell : UITableViewCell

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *subTitle;
@property (strong, nonatomic) UILabel *labelAlert;

@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UIView *line;
@property (nonatomic, strong) ModelBtn *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model;

@end

