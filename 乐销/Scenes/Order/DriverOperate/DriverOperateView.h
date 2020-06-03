//
//  DriverOperateView.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//yyimage
#import <YYKit.h>

@interface DriverOperateTopView : UIView
@property (strong, nonatomic) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *ivLeft;
@property (nonatomic, strong) UIImageView *ivRight;
@property (nonatomic, strong) UIImageView *ivBg;

//属性
@property (nonatomic, strong) ModelOrderList *model;
@property (nonatomic, strong) void (^blockClick)();
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model;

@end


@interface DriverOperateMidView : UIView
//属性
@property (strong, nonatomic) UIView *viewBg;
@property (strong, nonatomic) UILabel *labelCarNum;
@property (strong, nonatomic) UIImageView *ivHead;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UILabel *billNo;
@property (nonatomic, strong) UIControl *conClick;
@property (nonatomic, strong) void (^blockBottomClick)();

@property (nonatomic, strong) ModelOrderList *model;



#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model;

@end


@class DriverOperateBtn;
@interface DriverOperateBottomView : UIView
//属性
@property (strong, nonatomic) DriverOperateBtn *btnRecordPackageNo;
@property (strong, nonatomic) DriverOperateBtn *btnRecordPlumbumNo;
@property (strong, nonatomic) DriverOperateBtn *btnAccountBook;
@property (strong, nonatomic) DriverOperateBtn *btnCallDriverTeam;
@property (strong, nonatomic) UIButton *btnOperate;
@property (nonatomic, strong) void (^blockInputPackageNoClick)();
@property (nonatomic, strong) void (^blockInputPlumbumNoNoClick)( );
@property (nonatomic, strong) void (^blockInputAccountClick)( );
@property (nonatomic, strong) void (^blockDetailClick)( );
@property (nonatomic, strong) void (^blockOperateClick)( );

@property (nonatomic, strong) ModelOrderList *modelOrder;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model;

@end

@interface DriverOperateBtn : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivIcon;
@property (nonatomic, strong) ModelBtn *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBtn *)model;

@end



