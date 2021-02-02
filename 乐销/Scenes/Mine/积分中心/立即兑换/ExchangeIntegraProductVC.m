//
//  ExchangeIntegraProductVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/25.
//Copyright © 2020 ping. All rights reserved.
//

#import "ExchangeIntegraProductVC.h"
#import "ExchangeIntegraProductView.h"
//request
#import "RequestDriver2.h"
#import "SelectAddressVC.h"
@interface ExchangeIntegraProductVC ()
@property (nonatomic, strong) ExchangeIntegraProductView *numView;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) ExchangeIntegraAddressView *addressView;
@property (nonatomic, strong) ExchangeIntegraView *integralView;
@property (nonatomic, strong) ModelShopAddress *modelAddress;


@end

@implementation ExchangeIntegraProductVC
- (ExchangeIntegraProductView *)numView{
    if (!_numView) {
        _numView = [ExchangeIntegraProductView new];
        [_numView resetViewWithModel:self.modelDetail];
        WEAKSELF
        _numView.blockNumChange = ^(int num) {
            weakSelf.modelDetail.qty = num;
            [weakSelf.integralView resetViewWithModel:weakSelf.modelDetail];
        };
    }
    return _numView;
}
- (ExchangeIntegraAddressView *)addressView{
    if (!_addressView) {
        _addressView = [ExchangeIntegraAddressView new];
        WEAKSELF
        _addressView.blockClick = ^{
            SelectAddressVC * vc = [SelectAddressVC new];
            vc.blockSelected = ^(ModelShopAddress *item) {
                weakSelf.modelAddress = item;
                [weakSelf.addressView resetViewWithModel:weakSelf.modelAddress];
                [weakSelf reconfigView];
            };
            [GB_Nav pushViewController:vc animated:true];
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
        self.modelDetail.qty = 1;
        [_integralView resetViewWithModel:self.modelDetail];
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
    if (self.modelDetail.qty == 0) {
        [GlobalMethod showAlert:@"请选择数量"];
        return;
    }
    if (self.modelAddress.iDProperty == 0) {
        [GlobalMethod showAlert:@"请选择收货地址"];
        return;
    }
    [RequestApi requestExchangeProductWithSkuid:self.modelDetail.number qty:self.modelDetail.qty addrId:self.modelAddress.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GB_Nav popViewControllerAnimated:true];
        [GlobalMethod showAlert:@"兑换成功"];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
@end
