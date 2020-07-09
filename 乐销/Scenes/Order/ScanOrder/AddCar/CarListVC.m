//
//  CarListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/5/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "CarListVC.h"
//cell
#import "CarListCell.h"
//request
#import "RequestApi+Order.h"
#import "AddCarVC.h"
#import "CarDetailVC.h"
@interface CarListVC ()

@end

@implementation CarListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_attach" title:@"暂无车辆"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_CAR_REFERSH object:nil];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[CarListCell class] forCellReuseIdentifier:@"CarListCell"];
    [self addRefreshHeader];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"我的车辆" rightTitle:@"添加" rightBlock:^{
        
        AddCarVC * vc = [AddCarVC new];
        vc.blockBack = ^(UIViewController *item) {
            [weakSelf refreshHeaderAll];
        };
        [GB_Nav pushViewController:vc animated:true];
    }]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CarListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDelete = ^(ModelCar *model) {
        [weakSelf requestDeleteCar:model];
    };
    cell.blockEdit = ^(ModelCar *model) {
        AddCarVC * vc = [AddCarVC new];
        vc.carID = model.iDProperty;
        [GB_Nav pushViewController:vc animated:true];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CarListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelCar * model = self.aryDatas[indexPath.row];
    CarDetailVC * detailVC = [CarDetailVC new];
    detailVC.carID = model.iDProperty;
    [GB_Nav pushViewController:detailVC animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestPersonalCarListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.aryDatas removeAllObjects];
        self.aryDatas = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCar"];
        [self.tableView reloadData];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDeleteCar:(ModelCar *)model{
    [RequestApi requestDeleteCarWithId:model.iDProperty entId:model.entId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
