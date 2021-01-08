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
//#import "ScheConfirmView.h"

@interface ScheduleOrderInfoVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) ScheduleInfoTopView *topView;
@property (nonatomic, strong) ScheduleInfoPathView *pathView;

@property (nonatomic, strong) ScheduleBottomView *bottomView;
@property (nonatomic, strong) ScheConfirmView *confirmView;

@end

@implementation ScheduleOrderInfoVC

#pragma mark lazy init
- (BaseNavView *)nav{
    if (!_nav) {
        WEAKSELF
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"扫码运单" rightView:nil];
        [nav configBackBlueStyle];
        _nav = nav;
    }
    return _nav;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (ScheduleBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ScheduleBottomView new];
        _bottomView.topToUpView = W(10);
        WEAKSELF
        _bottomView.blockClick = ^{
//            if (weakSelf.confirmView.aryDatas.count == 0) {
//                [GlobalMethod showAlert:@"当前无可运输车辆"];
//                return ;
//            }
//            [weakSelf.confirmView resetViewWithModel:weakSelf.modelOrder.isPlanNoEnd];
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

- (ScheConfirmView *)confirmView{
    if (!_confirmView) {
        _confirmView = [ScheConfirmView new];
        WEAKSELF
//        _confirmView.blockComplete = ^(ModelValidCar *model, NSString *phone) {
//            [weakSelf requestConfirm:model phone:phone endAddrId:0 endAddr:nil endContact:nil endPhone:nil endEntName:nil];
//        };
//        _confirmView.blockAllComplete = ^(ModelValidCar *model, NSString *phone, NSString *companyName, double addressId, NSString *addressDetail, NSString *receiverName, NSString *receiverPhone) {
//            [weakSelf requestConfirm:model phone:phone endAddrId:addressId endAddr:addressDetail endContact:receiverName endPhone:receiverPhone endEntName:companyName];
//        };
    }
    return _confirmView;
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
    self.bottomView.bottom = SCREEN_HEIGHT;
    [self.view addSubview:self.bottomView];
    
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
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
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.pathView]];
}
#pragma mark reques car
- (void)requestCarList{
    [RequestApi requestValidCarListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelValidCar"];
//        self.confirmView.aryDatas = ary;
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestConfirm:(ModelValidCar *)model phone:(NSString *)phone endAddrId:(double)endAddrId endAddr:(NSString *)endAddr endContact:(NSString *)endContact endPhone:(NSString *)endPhone endEntName:(NSString *)endEntName{
    [RequestApi requestScheduleConfirmWithPlannumber:self.modelOrder.number vehicleId:model.iDProperty driverPhone:phone endAddrId:endAddrId endAddr:endAddr endLng:nil endLat:nil endContact:endContact endPhone:endPhone endEntName:endEntName delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"下单成功"];
        NSMutableArray * ary = [NSMutableArray arrayWithArray:GB_Nav.viewControllers];
        for (BaseTableVC * vc in ary) {
            if ([vc isKindOfClass:NSClassFromString(@"ScanOrderListVC")]) {
                [vc refreshHeaderAll];
            }
        }
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
