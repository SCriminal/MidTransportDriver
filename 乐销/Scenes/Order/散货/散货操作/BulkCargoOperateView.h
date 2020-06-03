//
//  BulkCargoOperateView.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BulkCargoOperateTopView : UIView
@property (strong, nonatomic) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *ivLeft;
@property (nonatomic, strong) UIImageView *ivRight;
@property (nonatomic, strong) UIImageView *ivBg;

//属性
@property (nonatomic, strong) ModelBulkCargoOrder *model;
@property (nonatomic, strong) void (^blockClick)();
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;

@end


@interface BulkCargoOperateMidView : UIView
//属性
@property (strong, nonatomic) UIView *viewBg;
@property (strong, nonatomic) UILabel *labelCarNum;
@property (strong, nonatomic) UIImageView *ivHead;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UILabel *billNo;
@property (nonatomic, strong) UIControl *conClick;
@property (nonatomic, strong) void (^blockBottomClick)();

@property (nonatomic, strong) ModelBulkCargoOrder *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;

@end


@interface BulkCargoOperateBottomView : UIView
//属性

@property (strong, nonatomic) UIButton *btnOperate;
@property (nonatomic, strong) UILabel *labelCargoName;
@property (nonatomic, strong) UILabel *labelWeight;
@property (nonatomic, strong) UILabel *labelDetail;
@property (nonatomic, strong) UIImageView *ivCargoName;
@property (nonatomic, strong) UIImageView *ivWeight;
@property (nonatomic, strong) UIImageView *ivArrow;
@property (nonatomic, strong) UIControl *conDetail;

@property (nonatomic, strong) void (^blockDetailClick)( );
@property (nonatomic, strong) void (^blockOperateClick)( );

@property (nonatomic, strong) ModelBulkCargoOrder *modelOrder;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;

@end





