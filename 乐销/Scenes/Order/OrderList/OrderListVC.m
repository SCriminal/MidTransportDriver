//
//  OrderListVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderListVC.h"
//cell
#import "OrderListCell.h"

//request
//request
#import "RequestDriver2.h"
//detail
#import "OrderDetailVC.h"
//operate
#import "DriverOperateVC.h"
//bottom view
#import "OrderManagementBottomView.h"
#import "OrderFilterView.h"

@interface OrderListVC ()
@property (nonatomic, strong) OrderFilterView *filterView;

@end

@implementation OrderListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        _noResultView.verticalModify = -HEIGHT_ORDERMANAGEMENTBOTTOMVIEW/2.0;
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无运单信息"];
    }
    return _noResultView;
}
- (OrderFilterView *)filterView{
    if (!_filterView) {
        _filterView = [OrderFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSInteger index, NSString *billNo, NSDate *dateStart, NSDate *dateEnd) {
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavTitle:@"运单中心" leftImageName:@"nav_auto" leftImageSize:CGSizeMake(W(23), W(23)) leftBlock:^{
        
    } rightImageName:@"nav_filter_white" rightImageSize:CGSizeMake(W(23), W(23)) righBlock:^{
        [weakSelf.filterView show];

    }];
    [nav configBlueStyle];
    [self.view addSubview:nav];
    [self.tableView registerClass:[OrderListCell class] forCellReuseIdentifier:@"OrderListCell"];
    self.tableView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT);

    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(12), 0);
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDetail = ^(ModelTransportOrder *model) {
        [weakSelf jumpToDetail:model];
    };
    cell.btnView.blockClick = ^(ENUM_ORDER_LIST_BTN type,ModelTransportOrder * model) {
        [weakSelf requestOperate:type model:model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelTransportOrder * model = self.aryDatas[indexPath.row];
    [self jumpToDetail:model];
    
}
- (void)jumpToDetail:(ModelTransportOrder *)model{
    OrderDetailVC * operateVC = [OrderDetailVC new];
    operateVC.orderList = model;
    WEAKSELF
    operateVC.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:operateVC animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestOrderListWithPage:self.pageNum count:20 orderNumber:nil shipperName:nil plateNumber:nil driverName:nil delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelTransportOrder"];
      
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)requestOperate:(ENUM_ORDER_LIST_BTN)type model:(ModelTransportOrder *)model{
    switch (type) {
        case ENUM_ORDER_LIST_BTN_REJECT:
        {
            
        }
            break;
        case ENUM_ORDER_LIST_BTN_RECEIVE:
        {
            [RequestApi requestAcceptWithNumber:model.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [self refreshHeaderAll];
                        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                            
                        }];
        }
            break;
        case ENUM_ORDER_LIST_BTN_LOAD_CAR:
        {
            
        }
            break;
        case ENUM_ORDER_LIST_BTN_ARRIVE:
        {
            
        }
            break;
        case ENUM_ORDER_LIST_BTN_NAVIGATION:
        {
            
        }
            break;
        default:
            break;
    }
}

@end
