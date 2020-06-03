//
//  BulkCargoOrderDetailView.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BulkCargoOrderDetailTopView : UIView
//属性
@property (strong, nonatomic) UILabel *labelBill;
@property (strong, nonatomic) UILabel *labelBillNo;

@property (strong, nonatomic) UIImageView *ivBg;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;
@end

@interface BulkCargoOrderDetailStatusView : UIView
//属性
@property (strong, nonatomic) UILabel *labelStatus;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) NSArray *aryDatas;
#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary ;
@end



@interface BulkCargoOrderDetailPathView : UIView
//属性
@property (strong, nonatomic) UILabel *labelPath;
@property (nonatomic, strong) UILabel *labelAddressFrom;
@property (nonatomic, strong) UILabel *labelAddressTo;
@property (strong, nonatomic) UIImageView *ivBg;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;
@end

@interface BulkCargoOrderDetailSendView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) ModelBulkCargoOrder *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;
@end


@interface BulkCargoOrderDetailReceiveView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) ModelBulkCargoOrder *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;
@end

@interface BulkCargoOrderDetailDriverView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelPhone;
@property (strong, nonatomic) UIImageView *ivHead;
@property (strong, nonatomic) UIImageView *ivPhone;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) ModelBulkCargoOrder *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;
@end


@interface BulkCargoOrderDetailRemarkView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelSubTitle;
@property (strong, nonatomic) UIImageView *ivBg;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model;

@end

@interface BulkLoadImageView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) NSMutableArray *aryDatas;

#pragma mark 刷新view
- (void)resetViewWithLoadModel:(ModelBulkCargoOrder *)model;
- (void)resetViewWithUnloadModel:(ModelBulkCargoOrder *)model;

@end


