//
//  OrderDetailVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/19.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderDetailVC.h"
//nav
#import "BaseNavView+Logical.h"
//sub view
#import "OrderDetailTopView.h"
#import "OrderDetailAccessoryView.h"
//request
#import "RequestApi+Order.h"
//share
#import "ShareView.h"
#import "OrderListCellBtnView.h"

@interface OrderDetailVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) OrderDetailView *topView;
@property (nonatomic, strong) OrderListCellBtnView *btnView;
@property (nonatomic, strong) UIView *bottomView;


@end

@implementation OrderDetailVC

#pragma mark lazy init
- (BaseNavView *)nav{
    if (!_nav) {
        WEAKSELF
        _nav = [BaseNavView initNavBackTitle:@"运单详情" rightView:nil];
        [_nav configBackBlueStyle];
        _nav.line.hidden = true;
    }
    return _nav;
}
- (OrderListCellBtnView *)btnView{
    if (!_btnView) {
        _btnView = [OrderListCellBtnView new];
        [_btnView resetViewWithModel:self.modelOrder];
    }
    return _btnView;
}

- (OrderDetailView *)topView{
    if (!_topView) {
        _topView = [OrderDetailView new];
        [_topView resetViewWithModel:self.modelOrder];
    }
    return _topView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.btnView];
        self.btnView.centerXTop = XY(SCREEN_WIDTH/2.0, W(10));
        _bottomView.width = SCREEN_WIDTH;
        _bottomView.height = self.btnView.height + W(20) + iphoneXBottomInterval;
        _bottomView.bottom = SCREEN_HEIGHT;
    }
    return _bottomView;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    [self.view addSubview:self.bottomView];
    [self addRefreshHeader];
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark refresh table header view
- (void)reconfigTableHeaderView{
        self.tableView.tableHeaderView = self.topView;
}
#pragma mark request
- (void)requestList{
    [RequestApi requestOrderDetailWithId:self.modelOrder.iDProperty  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelOrder = [ModelOrderList modelObjectWithDictionary:response];
        
        [self.topView resetViewWithModel:self.modelOrder];
        [self.btnView resetViewWithModel:self.modelOrder];

        [self reconfigTableHeaderView];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
