//
//  AutoConfigOrderListCell.h
//  Driver
//
//  Created by 隋林栋 on 2020/11/27.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoConfigTimeView.h"
#import "AutoNewsView.h"

@interface AutoConfigOrderListCell : UITableViewCell
@property (strong, nonatomic) UILabel *addressFrom;
@property (strong, nonatomic) UILabel *addressTo;
@property (strong, nonatomic) UIImageView *iconAddress;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UILabel *goodsInfo;
@property (strong, nonatomic) UILabel *goodsName;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *distance;
@property (nonatomic, strong) AutoConfigTimeView *timeView;
@property (nonatomic, strong) AutoNewsView *newsView;

@property (nonatomic, strong) void (^blockDetail)(ModelOrderList *);

@property (nonatomic, strong) ModelOrderList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderList *)model;


@end


@interface AutoConfigOrderListAutoFilterView : UIView
//属性
@property (strong, nonatomic) UILabel *addressFrom;
@property (strong, nonatomic) UILabel *addressTo;
@property (strong, nonatomic) UILabel *labelAuto;
@property (strong, nonatomic) UILabel *filter;
@property (nonatomic, strong) void (^blockAuto)(void);
@property (nonatomic, strong) void (^blockFilter)(void);
@property (nonatomic, strong) void (^blockStart)(void);
@property (nonatomic, strong) void (^blockEnd)(void);
@property (nonatomic, strong) void (^blockVoice)(void);
@property (nonatomic, assign) int indexSelected;
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

