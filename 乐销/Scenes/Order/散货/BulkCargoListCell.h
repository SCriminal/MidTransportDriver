//
//  BulkCargoListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BulkCargoListCell : UITableViewCell

@property (strong, nonatomic) UILabel *addressFrom;
@property (strong, nonatomic) UILabel *addressTo;
@property (strong, nonatomic) UIImageView *iconAddress;
@property (strong, nonatomic) UIImageView *ivBg;
@property (strong, nonatomic) UIButton *btnLeft;
@property (strong, nonatomic) UIButton *btnRight;
@property (nonatomic, strong) void (^blockReject)(ModelBulkCargoOrder *);
@property (nonatomic, strong) void (^blockAccept)(ModelBulkCargoOrder *);
@property (nonatomic, strong) void (^blockLoad)(ModelBulkCargoOrder *);
@property (nonatomic, strong) void (^blockArrive)(ModelBulkCargoOrder *);
@property (nonatomic, strong) void (^blockDetail)(ModelBulkCargoOrder *);

@property (nonatomic, strong) ModelBulkCargoOrder *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBulkCargoOrder *)model;
+ (CGFloat)addTitle:(ModelBtn *)modelBtn  view:(UIView *)superView top:(CGFloat)top;

@end
