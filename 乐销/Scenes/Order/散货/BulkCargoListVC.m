//
//  BulkCargoListVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "BulkCargoListVC.h"
//cell
#import "BulkCargoListCell.h"

//request
#import "RequestApi+BulkCargo.h"
//operate
#import "BulkCargoOperateVC.h"
//bottom view
#import "OrderManagementBottomView.h"

@interface BulkCargoListVC ()

@end

@implementation BulkCargoListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        _noResultView.verticalModify = -HEIGHT_ORDERMANAGEMENTBOTTOMVIEW/2.0;
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无散货运单信息"];

    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    
    [self.tableView registerClass:[BulkCargoListCell class] forCellReuseIdentifier:@"BulkCargoListCell"];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
 
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
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
    
    BulkCargoListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BulkCargoListCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [BulkCargoListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBulkCargoOrder * model = self.aryDatas[indexPath.row];
   
    BulkCargoOperateVC * operateVC = [BulkCargoOperateVC new];
    operateVC.modelOrder = model;
    WEAKSELF
    operateVC.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:operateVC animated:true];
}
#pragma mark request
- (void)requestList{
    NSString * strOrderType = nil;
    int sortCreateTime = 1;
    int sortAcceptTime = 1;
    int sortFinishTime = 1;
    switch (self.sortType) {
        case ENUM_ORDER_LIST_SORT_WAIT_RECEIVE:
            strOrderType = @"1";
            sortCreateTime = 3;
            break;
        case ENUM_ORDER_LIST_SORT_GOING:
            strOrderType = @"2,3";//2,3
            sortAcceptTime = 3;
            break;
        case ENUM_ORDER_LIST_SORT_ARRIVE:
            strOrderType = @"10";//2,3
            sortFinishTime = 3;
            break;
        case ENUM_ORDER_LIST_SORT_COMPLETE:
            strOrderType = @"11";
            sortFinishTime = 3;
            break;
        default:
            break;
    }
    [RequestApi requestBulkCargoOrderListWithwaybillStates:strOrderType
                                                      page:self.pageNum count:50
                                            sortAcceptTime:sortAcceptTime
                                            sortFinishTime:sortFinishTime
                                            sortCreateTime:sortCreateTime
                                                  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelBulkCargoOrder"];
        if (self.blockTotal) {
            self.blockTotal(self.sortType , [response intValueForKey:@"total"]);
        }
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

@end
