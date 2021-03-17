//
//  TransferSuccessVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/3/11.
//Copyright © 2021 ping. All rights reserved.
//

#import "TransferSuccessVC.h"
//request
#import "RequestDriver2.h"

@interface TransferSuccessVC ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation TransferSuccessVC
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.width = SCREEN_WIDTH;
    }
    return _headerView;
}
- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = [UIColor whiteColor];
        _footerView.width = SCREEN_WIDTH;
        [_footerView addSubview:^(){
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY(W(315), W(39));
            btn.backgroundColor = COLOR_BLUE;
            [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
            [btn setTitle:@"马上体验" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(203));
            [btn addTarget:self action:@selector(transferClick)];
            return btn;
        }()];
        [_footerView addSubview:^(){
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY(W(315), W(39));
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_999 forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(203)+W(5)+W(40));
            [btn addTarget:self action:@selector(dismissClick)];
            return btn;
        }()];
        _footerView.height = W(203)+W(5)+W(40) + W(50);
        
    }
    return _footerView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    self.tableView.top = 0;
    self.tableView.height = SCREEN_HEIGHT;
    self.tableView.tableFooterView = self.footerView;
    [self reconfigView];
    //request
    [self requestList];
    [GlobalData sharedInstance].GB_UserModel.isTransfered = 1;
    [GlobalData saveUserModel];
}

- (void)reconfigView{
    [self.headerView removeAllSubViews];
    CGFloat top = 0;
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(25) weight:UIFontWeightBold];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(20);
        [l fitTitle:@"迁移完成，\n欢迎体验全新版司机端" variable:SCREEN_WIDTH - W(60)];
        l.leftTop = XY(W(30), W(146)+NAVIGATIONBAR_HEIGHT);
        [self.headerView addSubview:l];
        top = l.bottom;
    }
   
    self.headerView.height = top ;
    self.tableView.tableHeaderView = self.headerView;
}


- (void)transferClick{
    [GB_Nav popToRootViewControllerAnimated:true];
}
- (void)dismissClick{
    [GlobalMethod clearUserInfo];
    [GB_Nav popToClass:@"LoginViewController"];
}
@end

