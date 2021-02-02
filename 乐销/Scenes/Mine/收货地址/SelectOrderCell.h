//
//  SelectOrderCell.h
//  Driver
//
//  Created by 隋林栋 on 2021/2/2.
//  Copyright © 2021 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectOrderCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconSelected;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UILabel *time;

@property (nonatomic, strong) ModelTransportOrder *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelTransportOrder *)model;
@end

NS_ASSUME_NONNULL_END
