//
//  OrderListCell.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell

@property (strong, nonatomic) UILabel *labelBillNo;
@property (strong, nonatomic) UILabel *labelOrderNo;
@property (strong, nonatomic) UILabel *labelStatus;
@property (strong, nonatomic) UILabel *labelAddressFrom;
@property (strong, nonatomic) UILabel *labelAddressTo;
@property (strong, nonatomic) UILabel *labelConnect;
@property (strong, nonatomic) UILabel *labelOperateTime;
@property (strong, nonatomic) UIImageView *ivUser;
@property (strong, nonatomic) UIImageView *ivCompany;
@property (strong, nonatomic) UIImageView *ivPortType;
@property (strong, nonatomic) UILabel *labelPortType;
@property (strong, nonatomic) UILabel *labelCompany;
@property (strong, nonatomic) UIImageView *ivPhone;
@property (strong, nonatomic) UIImageView *ivBg;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UIView *dotBlue;
@property (strong, nonatomic) UIView *lineVertical;
@property (strong, nonatomic) UIView *dotRed;
@property (strong, nonatomic) UIView *colorLine;
@property (strong, nonatomic) UIControl *conPhone;

@property (nonatomic, strong) ModelOrderList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderList *)model;

@end

