//
//  OrderDetailVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/19.
//Copyright © 2018年 ping. All rights reserved.
//

#import "ScheduleOrderInfoVC.h"
//nav
#import "BaseNavView+Logical.h"
//sub view
#import "ScheduleInfoView.h"
//request
#import "RequestApi+Schedule.h"
//share
#import "ShareView.h"
//confirm view
#import "ScheduleConfirmView.h"

@interface ScheduleOrderInfoVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) ScheduleInfoTopView *topView;
@property (nonatomic, strong) ScheduleInfoPathView *pathView;
@property (nonatomic, strong) ScheduleInfoSendView *sendView;
@property (nonatomic, strong) ScheduleInfoReceiveView *receiveView;
@property (nonatomic, strong) ScheduleBottomView *bottomView;
@property (nonatomic, strong) ScheduleConfirmView *confirmView;
@property (nonatomic, strong) ScheduleRemarkView *remarkView;

@end

@implementation ScheduleOrderInfoVC

#pragma mark lazy init
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"运单确认" rightTitle:nil rightBlock:nil];
    }
    return _nav;
}
- (ScheduleBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ScheduleBottomView new];
        _bottomView.topToUpView = W(10);
        WEAKSELF
        _bottomView.blockClick = ^{
            if (weakSelf.confirmView.aryDatas.count == 0) {
                [GlobalMethod showAlert:@"当前无可运输车辆"];
                return ;
            }
            [weakSelf.confirmView show];
        };
    }
    return _bottomView;
}
- (ScheduleInfoTopView *)topView{
    if (!_topView) {
        _topView = [ScheduleInfoTopView new];
        [_topView resetViewWithModel:self.modelOrder ];
        _topView.topToUpView = W(10);
    }
    return _topView;
}
- (ScheduleInfoPathView *)pathView{
    if (!_pathView) {
        _pathView = [ScheduleInfoPathView new];
        _pathView.topToUpView = W(10);
        [_pathView resetViewWithModel:self.modelOrder];
        
    }
    return _pathView;
}
- (ScheduleInfoSendView *)sendView{
    if (!_sendView) {
        _sendView = [ScheduleInfoSendView new];
        _sendView.topToUpView = W(10);
        [_sendView resetViewWithModel:self.modelOrder];
    }
    return _sendView;
}
- (ScheduleInfoReceiveView *)receiveView{
    if (!_receiveView) {
        _receiveView = [ScheduleInfoReceiveView new];
        _receiveView.topToUpView = W(10);
        [_receiveView resetViewWithModel:self.modelOrder];
    }
    return _receiveView;
}
- (ScheduleConfirmView *)confirmView{
    if (!_confirmView) {
        _confirmView = [ScheduleConfirmView new];
        WEAKSELF
        _confirmView.blockComplete = ^(ModelValidCar *model, NSString *phone) {
            [weakSelf requestConfirm:model phone:phone];
        };
    }
    return _confirmView;
}
- (ScheduleRemarkView *)remarkView{
    if (!_remarkView) {
        _remarkView = [ScheduleRemarkView new];
        _remarkView.topToUpView = W(15);
        [_remarkView resetViewWithModel:self.modelOrder];
    }
    return _remarkView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self reconfigTableHeaderView];
    
    self.tableView.tableFooterView = ^(){
        UIView * view = [UIView new];
        view.height = W(20);
        view.backgroundColor = [UIColor clearColor];
        return view;
    }();
//    [self addRefreshHeader];
    //request
    [self reconfigTableHeaderView];
    [self requestCarList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark refresh table header view
- (void)reconfigTableHeaderView{
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.pathView,self.sendView,self.receiveView,isStr(self.modelOrder.iDPropertyDescription)?self.remarkView:[NSNull null],self.bottomView]];
}
#pragma mark reques car
- (void)requestCarList{
    [RequestApi requestValidCarListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelValidCar"];
        self.confirmView.aryDatas = ary;
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestConfirm:(ModelValidCar *)model phone:(NSString *)phone{
    [RequestApi requestScheduleConfirmWithPlannumber:self.modelOrder.number vehicleId:model.vehicleId driverPhone:phone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"下单成功"];
        BaseTableVC * tableVC =  (BaseTableVC *)GB_Nav.lastSecondVC;
        if ([tableVC isKindOfClass:BaseTableVC.class]) {
            [tableVC refreshHeaderAll];
        }
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
