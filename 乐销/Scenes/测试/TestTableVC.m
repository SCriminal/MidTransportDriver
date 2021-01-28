//
//  TestTableVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/27.
//Copyright © 2021 ping. All rights reserved.
//

#import "TestTableVC.h"
//request
#import "RequestDriver2.h"
#import "AutoConfigOrderListCell.h"
@interface TestTableVC ()

@end

@implementation TestTableVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[AutoConfigOrderListCell class] forCellReuseIdentifier:@"AutoConfigOrderListCell"];
    //request
    [self requestList];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"AutoConfigOrderListCell" rightView:nil]];
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
    AutoConfigOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AutoConfigOrderListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AutoConfigOrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    ModelAddress * location = [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
    [RequestApi requestAutoOrderListWithMode:nil startAreaId:nil endAreaId:nil createStartTime:0 createEndTime:0 page:self.pageNum count:20 lat:NSNumber.dou(location.lat).stringValue lng:NSNumber.dou(location.lng).stringValue sort:1 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAutOrderListItem"];
        
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
