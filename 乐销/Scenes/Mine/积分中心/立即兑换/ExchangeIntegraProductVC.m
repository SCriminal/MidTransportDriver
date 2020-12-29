//
//  ExchangeIntegraProductVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/25.
//Copyright © 2020 ping. All rights reserved.
//

#import "ExchangeIntegraProductVC.h"
#import "ExchangeIntegraProductView.h"

@interface ExchangeIntegraProductVC ()
@property (nonatomic, strong) ExchangeIntegraProductView *numView;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) ExchangeIntegraAddressView *addressView;
@property (nonatomic, strong) ExchangeIntegraView *integralView;


@end

@implementation ExchangeIntegraProductVC
- (ExchangeIntegraProductView *)numView{
    if (!_numView) {
        _numView = [ExchangeIntegraProductView new];
        [_numView resetViewWithModel:nil];
    }
    return _numView;
}
- (ExchangeIntegraAddressView *)addressView{
    if (!_addressView) {
        _addressView = [ExchangeIntegraAddressView new];
        WEAKSELF
        _addressView.blockClick = ^{
            [weakSelf.addressView resetViewWithModel:@"1"];
            [weakSelf reconfigView];
        };
        [_addressView resetViewWithModel:nil];
    }
    return _addressView;
}
- (UIView *)btnView{
    if (!_btnView) {
        _btnView = [UIView new];
        _btnView.backgroundColor = [UIColor clearColor];
        UIButton * btn = [UIButton createBottomBtn:@"确认兑换"];
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        [btn addTarget:self action:@selector(exchangeClick)];
        [_btnView addSubview:btn];
        _btnView.height = btn.bottom;
        _btnView.width = SCREEN_WIDTH;

    }
    return _btnView;
}
- (ExchangeIntegraView *)integralView{
    if (!_integralView) {
        _integralView = [ExchangeIntegraView new];
    }
    return _integralView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    [self reconfigView];
    //request
    [self requestList];
}
- (void)reconfigView{
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.numView,self.addressView,self.integralView,self.btnView]];
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"商品兑换" rightView:nil];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
- (void)exchangeClick{
    
}
@end
