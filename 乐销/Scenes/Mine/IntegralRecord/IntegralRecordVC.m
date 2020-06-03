//
//  IntegralRecordVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/11.
//Copyright © 2019 ping. All rights reserved.
//

#import "IntegralRecordVC.h"
//cell
#import "IntegralRecordCell.h"

@interface IntegralRecordVC ()

@end

@implementation IntegralRecordVC
@synthesize noResultView = _noResultView;
#pragma mark noresult view
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_integral_default" title:@"暂无积分记录"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    self.tableBackgroundView.backgroundColor = [UIColor whiteColor];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[IntegralRecordCell class] forCellReuseIdentifier:@"IntegralRecordCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"积分记录" rightView:nil]];
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
    IntegralRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralRecordCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [IntegralRecordCell fetchHeight:nil];
}

#pragma mark request
- (void)requestList{
//    self.aryDatas = @[@"",@"",@""].mutableCopy;
//    [self.tableView reloadData];
    [self showNoResult];
}
@end
