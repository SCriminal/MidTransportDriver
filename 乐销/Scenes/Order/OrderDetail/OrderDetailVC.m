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
@property (nonatomic, strong) OrderDetailReturnAddressView *returnStationView;
@property (nonatomic, strong) OrderDetailPackageView *packageView;
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
- (OrderDetailPackageView *)packageView {
    if (!_packageView) {
        _packageView = [OrderDetailPackageView new];
        _packageView.topToUpView = W(15);
    }
    return _packageView;
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
        [self reconfigTimeAxle];
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
- (OrderDetailReturnAddressView *)returnStationView{
    if (!_returnStationView) {
        _returnStationView = [OrderDetailReturnAddressView new];
        _returnStationView.topToUpView = W(15);
        [_returnStationView resetViewWithModel:self.modelOrder];
    }
    return _returnStationView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.pathView,self.loadInfoView,self.stationView,self.modelOrder.orderType == ENUM_ORDER_TYPE_OUTPUT?self.returnStationView:[NSNull null],isStr(self.modelOrder.iDPropertyDescription)?self.remarkView:[NSNull null]]];
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
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,isAry(self.statusView.aryDatas)?self.statusView:[NSNull null],self.pathView,isAry(self.packageView.aryDatas)?self.packageView:[NSNull null],self.loadInfoView,self.stationView,self.modelOrder.orderType == ENUM_ORDER_TYPE_OUTPUT?self.returnStationView:[NSNull null],isStr(self.modelOrder.iDPropertyDescription)?self.remarkView:[NSNull null],isAry(self.accessoryView.aryDatas)?self.accessoryView:[NSNull null]]];
}
#pragma mark request
- (void)requestGoodsInfo{
    [RequestApi requestGoosListWithId:self.modelOrder.iDProperty entID:self.modelOrder.shipperId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageInfo"];
        [self.packageView resetViewWithAry:ary];
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
        
        [self reconfigTimeAxle];
        
        [self.loadInfoView resetViewWithModel:self.modelOrder];
        [self.stationView resetViewWithModel:self.modelOrder];
        [self.returnStationView resetViewWithModel:self.modelOrder];
        [self.pathView resetViewWithModel:self.modelOrder];
        [self.remarkView resetViewWithModel:self.modelOrder];
        
        
        [self reconfigTableHeaderView];
        [self requestGoodsInfo];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)reconfigTimeAxle{
    NSMutableArray * aryTimes = [NSMutableArray array];
    
    [aryTimes addObject:^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"接单";
        model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.acceptTime andFormatter:TIME_SEC_SHOW];
        return model;
    }()];
    [aryTimes addObject:^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"提箱";
        model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.stuffTime andFormatter:TIME_SEC_SHOW];
        return model;
    }()];
    [aryTimes addObject:^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"到场";
        model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.toFactoryTime andFormatter:TIME_SEC_SHOW];
        return model;
    }()];
    [aryTimes addObject:^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = self.modelOrder.orderType == ENUM_ORDER_TYPE_OUTPUT? @"装货":@"卸货";
        model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.handleTime andFormatter:TIME_SEC_SHOW];
        return model;
    }()];
    [aryTimes addObject:^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"还箱";
        model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.finishTime andFormatter:TIME_SEC_SHOW];
        return model;
    }()];
    
    [self.statusView resetViewWithAry:aryTimes];
}
@end
