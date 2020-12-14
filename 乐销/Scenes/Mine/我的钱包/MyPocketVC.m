//
//  MyPocketVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/12/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "MyPocketVC.h"
#import "RechargeInputView.h"
#import "WithdrawInputView.h"
@interface MyPocketVC ()
@property (nonatomic, strong) UILabel *accountNum;

@end

@implementation MyPocketVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    self.tableView.height = SCREEN_HEIGHT;
    self.tableView.top = 0;
    self.tableView.backgroundColor = [UIColor clearColor];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    UIView * topView = [UIView new];
    topView.backgroundColor = [UIColor clearColor];
    topView.widthHeight = XY(SCREEN_WIDTH, 0);
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"card_pocket_bg"];
        iv.widthHeight = XY(SCREEN_WIDTH,W(226)+iphoneXTopInterval);
        [topView addSubview:iv];
    }
    
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"我的钱包" rightTitle:nil rightBlock:nil];
    [nav configBackBlueStyle];
    nav.backgroundColor = [UIColor clearColor];
    [topView addSubview:nav];
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor =[UIColor whiteColor];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"当前余额（元）" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(20)+NAVIGATIONBAR_HEIGHT);
        [topView addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(35) weight:UIFontWeightMedium];
        l.textColor =[UIColor whiteColor];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"1000.00" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(45)+NAVIGATIONBAR_HEIGHT);
        [topView addSubview:l];
        self.accountNum = l;
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(345), W(61));
        view.centerXTop = XY(SCREEN_WIDTH/2.0, W(107)+NAVIGATIONBAR_HEIGHT);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
        [topView addSubview:view];
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"充值" variable:SCREEN_WIDTH - W(30)];
            l.centerXCenterY = XY(W(171)/2.0, view.height/2.0);
            [view addSubview:l];
            [view addControlFrame:CGRectMake(0, 0, view.width/2.0, view.height) belowView:l target:self action:@selector(rechargeClick)];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"提现" variable:SCREEN_WIDTH - W(30)];
            l.centerXCenterY = XY(view.width/2.0 + W(171)/2.0, view.height/2.0);
            [view addSubview:l];
            [view addControlFrame:CGRectMake(view.width/2.0, 0, view.width/2.0, view.height) belowView:l target:self action:@selector(withdrawClick)];
        }
        [view addLineFrame:CGRectMake(W(171), W(18), 1, W(25))];
    }
    
    NSArray * aryBtn = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"银行卡管理";
        m.imageName = @"card_card";
        m.blockClick = ^{
            [GB_Nav pushVCName:@"BankCardListVC" animated:true];
        };
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"交易明细";
        m.imageName = @"card_money";
        m.blockClick = ^{
            [GB_Nav pushVCName:@"DealHistoryListVC" animated:true];
        };
        return m;
    }()];
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(345), aryBtn.count *W(56));
        view.centerXTop = XY(SCREEN_WIDTH/2.0, W(183)+NAVIGATIONBAR_HEIGHT);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
        [topView addSubview:view];
        CGFloat btnTop = 0;
        for (ModelBtn *m in aryBtn) {
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:m.imageName];
            iv.widthHeight = XY(W(23),W(23));
            iv.leftCenterY = XY(20,btnTop + W(56)/2.0);
            [view addSubview:iv];
            
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftCenterY = XY(W(53), iv.centerY);
            [view addSubview:l];
            
            {
                UIImageView * iv = [UIImageView new];
                iv.backgroundColor = [UIColor clearColor];
                iv.contentMode = UIViewContentModeScaleAspectFill;
                iv.clipsToBounds = true;
                iv.image = [UIImage imageNamed:@"setting_RightArrow"];
                iv.widthHeight = XY(W(25),W(25));
                iv.rightCenterY = XY(view.width - W(20),l.centerY);
                [view addSubview:iv];
            }
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY(view.width, W(56));
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.modelBtn = m;
            btn.top = btnTop;
            [view addSubview:btn];
            btnTop = btn.bottom;
            if (m != aryBtn.lastObject) {
                [view addLineFrame:CGRectMake(W(20), btnTop, view.width - W(40), 1)];
            }
        }
        topView.height = view.bottom;

    }
    self.tableView.tableHeaderView = topView;
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (sender.modelBtn.blockClick) {
        sender.modelBtn.blockClick();
    }
}
-(void)rechargeClick{
    RechargeInputView * view = [RechargeInputView new];
    [view resetViewWithModel:nil];
    [self.view addSubview:view];
}
-(void)withdrawClick{
    WithdrawInputView * view = [WithdrawInputView new];
    [view resetViewWithModel:nil];
    [self.view addSubview:view];
}
#pragma mark request
- (void)requestList{
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
