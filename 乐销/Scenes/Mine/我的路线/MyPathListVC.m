//
//  MyPathListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "MyPathListVC.h"

@interface MyPathListVC ()

@end

@implementation MyPathListVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
//    [self.view addSubview:[BaseNavView initNavBackTitle:<#导航栏标题#> rightView:nil]];
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
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFLOAT_MIN;
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark request
- (void)requestList{
    
}
@end
