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
@interface OrderDetailVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) OrderDetailTopView *topView;
@property (nonatomic, strong) OrderDetailStatusView *statusView;
@property (nonatomic, strong) OrderDetailPathView *pathView;
@property (nonatomic, strong) OrderDetailLoadView *loadInfoView;
@property (nonatomic, strong) OrderDetailStationView *stationView;
@property (nonatomic, strong) OrderDetailDriverView *driverView;
@property (nonatomic, strong) OrderDetailRemarkView *remarkView;
@property (nonatomic, strong) OrderDetailAccessoryView *accessoryView;

@end

@implementation OrderDetailVC

#pragma mark lazy init
- (BaseNavView *)nav{
    if (!_nav) {
        WEAKSELF
        _nav = [BaseNavView initNavBackWithTitle:@"运单详情" rightImageName:@"orderTopShare" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
            [ShareView show:weakSelf.modelOrder];

        }];
        _nav.line.hidden = true;
    }
    return _nav;
}
- (OrderDetailDriverView *)driverView{
    if (!_driverView) {
        _driverView = [OrderDetailDriverView new];
        _driverView.topToUpView = W(15);
        [_driverView resetViewWithModel:self.modelOrder];
    }
    return _driverView;
}
- (OrderDetailRemarkView *)remarkView{
    if (!_remarkView) {
        _remarkView = [OrderDetailRemarkView new];
        _remarkView.topToUpView = W(15);
        [_remarkView resetViewWithModel:self.modelOrder];

    }
    return _remarkView;
}
- (OrderDetailTopView *)topView{
    if (!_topView) {
        _topView = [OrderDetailTopView new];
        [_topView resetViewWithModel:self.modelOrder goodlist:nil];
        _topView.topToUpView = W(15);
    }
    return _topView;
}
- (OrderDetailStatusView *)statusView{
    if (!_statusView) {
        _statusView = [OrderDetailStatusView new];
        _statusView.topToUpView = W(15);
    }
    return _statusView;
}
- (OrderDetailPathView *)pathView{
    if (!_pathView) {
        _pathView = [OrderDetailPathView new];
        _pathView.topToUpView = W(15);
        [_pathView resetViewWithModel:self.modelOrder];

    }
    return _pathView;
}
- (OrderDetailLoadView *)loadInfoView{
    if (!_loadInfoView) {
        _loadInfoView = [OrderDetailLoadView new];
        _loadInfoView.topToUpView = W(15);
        [_loadInfoView resetViewWithModel:self.modelOrder];
    }
    return _loadInfoView;
}
- (OrderDetailStationView *)stationView{
    if (!_stationView) {
        _stationView = [OrderDetailStationView new];
        _stationView.topToUpView = W(15);
        [_stationView resetViewWithModel:self.modelOrder];
    }
    return _stationView;
}
- (OrderDetailAccessoryView *)accessoryView{
    if (!_accessoryView) {
        _accessoryView = [OrderDetailAccessoryView new];
        _accessoryView.topToUpView = W(15);
    }
    return _accessoryView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.pathView,self.loadInfoView,self.stationView,isStr(self.modelOrder.iDPropertyDescription)?self.remarkView:[NSNull null],self.driverView]];
    self.tableView.tableFooterView = ^(){
        UIView * view = [UIView new];
        view.height = W(20);
        view.backgroundColor = [UIColor clearColor];
        return view;
    }();
    [self addRefreshHeader];
    //request
    [self requestGoodsInfo];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark refresh table header view
- (void)reconfigTableHeaderView{
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,isAry(self.statusView.aryDatas)?self.statusView:[NSNull null],self.pathView,self.loadInfoView,self.stationView,isStr(self.modelOrder.iDPropertyDescription)?self.remarkView:[NSNull null],isAry(self.accessoryView.aryDatas)?self.accessoryView:[NSNull null],self.driverView]];
}
#pragma mark request
- (void)requestGoodsInfo{
    [RequestApi requestGoosListWithId:self.modelOrder.iDProperty entID:self.modelOrder.shipperId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageInfo"];
        [self.topView resetViewWithModel:self.modelOrder goodlist:ary];
        [self reconfigTableHeaderView];
        [self requestTimeAxle];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestTimeAxle{
    [RequestApi requestDriverOrderTimeAxleWithFormid:self.modelOrder.iDProperty entId:self.modelOrder.shipperId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelOrderOperateTimeItem"];
        [self.statusView resetViewWithAry:ary modelOrder:self.modelOrder];
        [self reconfigTableHeaderView];
        [self requestAccessory];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestAccessory{
    [RequestApi requestAccessoryListWithFormid:self.modelOrder.iDProperty formType:0 entId:self.modelOrder.shipperId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAccessoryItem"];
        [self.accessoryView resetViewWithAry:ary modelOrder:self.modelOrder];
        [self reconfigTableHeaderView];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestList{
    [RequestApi requestOrderDetailWithId:self.modelOrder.iDProperty  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelOrder = [ModelOrderList modelObjectWithDictionary:response];

        [self.loadInfoView resetViewWithModel:self.modelOrder];
        [self.stationView resetViewWithModel:self.modelOrder];
        [self.pathView resetViewWithModel:self.modelOrder];
        [self.driverView resetViewWithModel:self.modelOrder];
        [self.remarkView resetViewWithModel:self.modelOrder];


        [self reconfigTableHeaderView];
        [self requestGoodsInfo];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
