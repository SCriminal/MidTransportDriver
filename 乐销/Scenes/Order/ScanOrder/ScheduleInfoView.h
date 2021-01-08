//
//  ScheduleInfoView.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleInfoTopView : UIView
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model;
@end

@interface ScheduleInfoPathView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model;
@end

@interface ScheduleBottomView : UIView
//属性
@property (strong, nonatomic) UIButton *btnConfirm;
@property (strong, nonatomic) UIButton *btnDismiss;

@property (nonatomic, strong) void (^blockClick)(void);
@property (nonatomic, strong) void (^blockDismiss)(void);

@end


@interface ScheConfirmView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tfPhone;

@property (nonatomic, strong) void (^blockClick)(void);
@property (nonatomic, strong) void (^blockDismiss)(void);
- (void)show;
@end
