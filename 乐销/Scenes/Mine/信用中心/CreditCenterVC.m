//
//  CreditCenterVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreditCenterVC.h"

@interface CreditCenterVC ()

@end

@implementation CreditCenterVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    [self requestList];
    [self reconfigView];
}
- (void)reconfigView{
    self.tableView.tableHeaderView = ^(){
        UIView * viewAll = [UIView new];
        viewAll.backgroundColor = COLOR_BACKGROUND;
        viewAll.clipsToBounds = true;
        viewAll.width = SCREEN_WIDTH;
        {
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:@"creditbg"];
            iv.widthHeight = XY(W(375),W(210));
            iv.leftTop = XY(0,-W(64));
            [viewAll addSubview:iv];
        }
        {
            UIView * view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view.widthHeight = XY(W(345), W(164));
            view.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
            [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
            [viewAll addSubview:view];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"当前信用分" variable:SCREEN_WIDTH - W(30)];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(41));
            [viewAll addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(40) weight:UIFontWeightRegular];
            l.textColor = COLOR_BLUE;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"90.00" variable:SCREEN_WIDTH - W(30)];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(77));
            [viewAll addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_BLUE;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"信用极好" variable:SCREEN_WIDTH - W(30)];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(141));
            [viewAll addSubview:l];
        }
        {
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:@"creditAlert"];
            iv.widthHeight = XY(W(345), W(381));
            iv.centerXTop = XY(SCREEN_WIDTH/2.0, W(191));
            [viewAll addSubview:iv];
        }
        viewAll.height = W(581);
        return viewAll;
    }();
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"信用中心" rightTitle:@"明细" rightBlock:^{
        [GB_Nav pushVCName:@"CreditListVC" animated:true];
    }];
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
