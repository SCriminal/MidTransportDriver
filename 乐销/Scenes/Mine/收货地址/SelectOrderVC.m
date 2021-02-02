
//
//  SelectOrderVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectOrderVC.h"
//cell
#import "SelectOrderCell.h"
//yellow btn
//request
#import "RequestDriver2.h"

@interface SelectOrderVC ()
@property (nonatomic, strong) ModelTransportOrder *modelOrder;

@end

@implementation SelectOrderVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_address" title:@"暂无运单"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.height = SCREEN_HEIGHT - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.tableView registerClass:[SelectOrderCell class] forCellReuseIdentifier:@"SelectOrderCell"];
    [self addRefreshHeader];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"选择运单" rightTitle:@"" rightBlock:^{
    }]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectOrderCell"];
    ModelTransportOrder * model = self.aryDatas[indexPath.row];
    [cell resetCellWithModel:model];
    cell.iconSelected.highlighted = [model.orderNumber isEqualToString:self.modelOrder.orderNumber];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectOrderCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.modelOrder = self.aryDatas[indexPath.row];
    [self.tableView reloadData];
    if (self.blockSelected) {
        self.blockSelected(self.modelOrder);
    }
    [GB_Nav popViewControllerAnimated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestOrderListWithPage:self.pageNum count:20 orderNumber:nil shipperName:nil plateNumber:nil driverName:nil                       startTime:0
                                 endTime:0
                            orderStatues:nil
                                delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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


@end


