//
//  AuthTwoVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthTwoVC.h"
#import "AuthView.h"

@interface AuthTwoVC ()
@property (nonatomic, strong) AuthView *authTopView;

@end

@implementation AuthTwoVC
- (AuthView *)authTopView{
    if (!_authTopView) {
        _authTopView = [AuthView new];
        [_authTopView resetViewWithModel:1];
    }
    return _authTopView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    self.tableView.tableHeaderView = self.authTopView;

    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
BaseNavView * nav = [BaseNavView initNavBackTitle:@"认证中心" rightView:nil];
[nav configBackBlueStyle];
[self.view addSubview:nav];
    
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
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
