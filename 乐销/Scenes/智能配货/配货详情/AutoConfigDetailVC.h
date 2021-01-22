//
//  AutoConfigDetailVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/1.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
#import "AutoNewsView.h"

@interface AutoConfigDetailVC : BaseTableVC
@property (nonatomic, strong) ModelAutOrderListItem *modelList;

@end

@interface AutoConfigDetailView : UIView
//属性
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UILabel *addressFrom;
@property (strong, nonatomic) UILabel *addressTo;
@property (strong, nonatomic) UIImageView *iconAddress;
@property (nonatomic, strong) AutoNewsView *newsView;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAutOrderListItem *)model;

@end
