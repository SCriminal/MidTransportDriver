//
//  ExchangeIntegraOrderDetailVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "ExchangeIntegraOrderDetailVC.h"

@interface ExchangeIntegraOrderDetailVC ()
@property (nonatomic, strong) UIView *headerView;

@end

@implementation ExchangeIntegraOrderDetailVC
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor  = [UIColor whiteColor];
        _headerView.width = SCREEN_WIDTH;
    }
    return _headerView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.backgroundColor = [UIColor whiteColor];
    //request
    [self requestList];
    [self reconfigView];
}
- (void)reconfigView{
    [self.headerView removeAllSubViews];
    CGFloat top = 0;
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"订单编号：22300012992300002222" variable:SCREEN_WIDTH - W(40)];
        l.leftTop = XY(W(20), W(20));
        [self.headerView addSubview:l];
        top = l.bottom;
    }
    NSArray * ary = @[^(){
        ModelBtn * m = [ModelBtn new];
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.subTitle = @"交易单号";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"商品名称：";
        m.subTitle = @"小米米家智能体重秤智能体脂称充电式";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"下单时间：";
        m.subTitle = @"2020-11-19 12:10:20";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"商品数量：";
        m.subTitle = @"x 1";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"合计：";
        m.subTitle = @"3000积分";
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.subTitle = @"收货信息";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"李林 15634834990";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"山东省潍坊市奎文区梨园街道世博国际大";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        return m;
    }()];
    for (ModelBtn *m in ary) {
        top += W(20);
        if (m.title.length == 0 && m.subTitle.length == 0) {
            top = [self.headerView addLineFrame:CGRectMake(W(20), top, SCREEN_WIDTH - W(40), 1)];
            continue;
        }
        if (m.title.length == 0) {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_999;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:m.subTitle variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(20), top);
            [self.headerView addSubview:l];
            top = l.bottom;
            continue;
        }
        if (m.subTitle.length == 0) {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(5);
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(40)];
            l.leftTop = XY(W(20), top);
            [self.headerView addSubview:l];
            top = l.bottom;
            continue;
        }
        
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(40)];
            l.leftTop = XY(W(20), top);
            [self.headerView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = m.isSelected?COLOR_RED:COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(5);
            [l fitTitle:m.subTitle variable:SCREEN_WIDTH - W(20)-W(95)];
            l.leftTop = XY(W(95), top);
            [self.headerView addSubview:l];
            top = l.bottom;
        }
    }
    self.headerView.height = top;
    self.tableView.tableHeaderView = self.headerView;
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"订单明细" rightView:nil];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
    //    [self.view addSubview:[BaseNavView initNavBackTitle:<#导航栏标题#> rightView:nil]];
    [self reconfigView];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark request
- (void)requestList{
    
}
@end
