//
//  CarTeamListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/11.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarTeamListVC.h"
//cell
#import "CarTeamListCell.h"
//request
#import "RequestApi+UserApi.h"


@interface CarTeamListVC ()

@end

@implementation CarTeamListVC
@synthesize noResultView = _noResultView;
#pragma mark noresult view
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_motorcade_default" title:@"暂无车队信息"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableBackgroundView.backgroundColor = [UIColor whiteColor];
    //table
    [self.tableView registerClass:[CarTeamListCell class] forCellReuseIdentifier:@"CarTeamListCell"];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarTeamListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CarTeamListCell"];
    ModelAttaceedCompany * model = self.aryDatas[indexPath.row];
    model.isAttached = self.isAttached;
    [cell resetCellWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelAttaceedCompany * model = self.aryDatas[indexPath.row];
    model.isAttached = self.isAttached;
    return [CarTeamListCell fetchHeight:model];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelAttaceedCompany * model = self.aryDatas[indexPath.row];
    NSString * strCopy = [NSString stringWithFormat:@"挂靠车队：%@\n企业码：%@\n车牌号码：%@\n状态：%@",UnPackStr(model.nameShow),UnPackStr(model.codeShow),isStr(model.vehicleNumber)?model.vehicleNumber:@"暂未绑定车辆",self.isAttached?@"已挂靠":@"已申请"];
    [GlobalMethod copyToPlte:strCopy];
    [GlobalMethod showAlert:@"企业信息已复制"];
}
#pragma mark request
- (void)requestList{
    if (self.isAttached) {
        [RequestApi requestAttachedCompanyListWithPage:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.pageNum ++;
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAttaceedCompany"];
           
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
    }else{
        [RequestApi requestAttacApplyCompanyListWithPage:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.pageNum ++;
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAttaceedCompany"];
            
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
   
}
@end
