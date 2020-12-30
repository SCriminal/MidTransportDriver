//
//  ExchangeIntegraOrderListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "ExchangeIntegraOrderListVC.h"
#import "ExchangeIntegraOrderDetailVC.h"
@interface ExchangeIntegraOrderListVC ()

@end

@implementation ExchangeIntegraOrderListVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[ExchangeIntegraOrderListCell class] forCellReuseIdentifier:@"ExchangeIntegraOrderListCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"订单列表" rightView:nil];
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

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangeIntegraOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeIntegraOrderListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ExchangeIntegraOrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangeIntegraOrderDetailVC * vc = [ExchangeIntegraOrderDetailVC new];
    [GB_Nav pushViewController:vc animated:true];
}

#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end


@implementation ExchangeIntegraOrderListCell
#pragma mark 懒加载
- (UILabel *)orderNum{
    if (_orderNum == nil) {
        _orderNum = [UILabel new];
        _orderNum.textColor = COLOR_333;
        _orderNum.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _orderNum;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_999;
        _name.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _name;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _time;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"setting_RightArrow"];
        _arrow.widthHeight = XY(W(25),W(25));
    }
    return _arrow;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.orderNum];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.arrow];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
        [self.orderNum fitTitle:@"订单编号：22300012992300002222" variable:W(300)];
    self.orderNum.leftTop = XY(W(15),W(18));
    [self.name fitTitle:@"商品名称：小米米家智能体重秤智能体脂称充电式" variable:W(300)];
    self.name.leftTop = XY(W(15),W(46));
    [self.time fitTitle:@"下单时间：2020-11-19 12:10:20" variable:W(300)];
    self.time.leftTop = XY(W(15),W(71));

    self.height = W(100);
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end
