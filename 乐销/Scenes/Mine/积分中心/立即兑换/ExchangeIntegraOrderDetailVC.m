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
        [l fitTitle:[NSString stringWithFormat:@"订单编号：%@",self.modelItem.orderNumber] variable:SCREEN_WIDTH - W(40)];
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
        m.subTitle = self.modelItem.skuName;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"下单时间：";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:self.modelItem.orderTime andFormatter:TIME_SEC_SHOW];
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"商品数量：";
        m.subTitle = [NSString stringWithFormat:@"x %@",NSNumber.dou(self.modelItem.qty).stringValue];
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"合计：";
        m.subTitle = [NSString stringWithFormat:@"%@积分",NSNumber.dou(self.modelItem.point).stringValue] ;
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
        m.title = [NSString stringWithFormat:@"%@ %@",UnPackStr(self.modelItem.contacter), UnPackStr(self.modelItem.contactPhone)];
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = self.modelItem.addr;
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
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark request
- (void)requestList{
    
}
@end
