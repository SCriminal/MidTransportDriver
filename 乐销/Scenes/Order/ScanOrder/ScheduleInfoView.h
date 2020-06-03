//
//  ScheduleInfoView.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleInfoTopView : UIView
//属性
@property (strong, nonatomic) UILabel *labelBill;
@property (strong, nonatomic) UILabel *labelBillNo;

@property (strong, nonatomic) UIImageView *ivBg;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model;
@end





@interface ScheduleInfoPathView : UIView
//属性
@property (strong, nonatomic) UILabel *labelFrom;
@property (strong, nonatomic) UILabel *labelTo;
@property (strong, nonatomic) UIImageView *iconArrow;
@property (nonatomic, strong) UILabel *labelAddressFrom;
@property (nonatomic, strong) UILabel *labelAddressTo;
@property (strong, nonatomic) UIImageView *ivBg;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model;
@end

@interface ScheduleInfoSendView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) ModelScheduleInfo *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model;
@end


@interface ScheduleInfoReceiveView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) ModelScheduleInfo *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model;
@end

@interface ScheduleBottomView : UIView
//属性
@property (strong, nonatomic) UIButton *btnConfirm;
@property (nonatomic, strong) void (^blockClick)(void);
@end





@interface ScheduleRemarkView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelSubTitle;
@property (strong, nonatomic) UIImageView *ivBg;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model;

@end
