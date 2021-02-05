//
//  ExchangeIntegraOrderListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "ExchangeIntegraOrderListVC.h"
#import "ExchangeIntegraOrderDetailVC.h"
//request
#import "RequestDriver2.h"
@interface ExchangeIntegraOrderListVC ()

@end

@implementation ExchangeIntegraOrderListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无订单"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[ExchangeIntegraOrderListCell class] forCellReuseIdentifier:@"ExchangeIntegraOrderListCell"];
    //request
    [self requestList];
    [self addRefresh];
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
    vc.modelItem = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestIntegralOrderListWithPage:self.pageNum count:40 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelIntegralOrder"];
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
- (void)resetCellWithModel:(ModelIntegralOrder *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
        [self.orderNum fitTitle:[NSString stringWithFormat:@"订单编号：%@",model.orderNumber] variable:W(300)];
    self.orderNum.leftTop = XY(W(15),W(18));
    [self.name fitTitle:[NSString stringWithFormat:@"商品名称：%@",model.skuName] variable:W(300)];
    self.name.leftTop = XY(W(15),W(46));
    
    [self.time fitTitle:[NSString stringWithFormat:@"下单时间：%@",[GlobalMethod exchangeTimeWithStamp:model.orderTime andFormatter:TIME_SEC_SHOW]] variable:W(300)];
    self.time.leftTop = XY(W(15),W(71));

    self.height = W(100);
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end
