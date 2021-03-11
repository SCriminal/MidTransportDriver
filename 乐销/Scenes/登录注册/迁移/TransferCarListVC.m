//
//  TransferCarListVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/3/11.
//Copyright © 2021 ping. All rights reserved.
//

#import "TransferCarListVC.h"
//request
#import "RequestDriver2.h"

@interface TransferCarListVC ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation TransferCarListVC
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
            [btn setTitle:@"马上迁移" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
            [btn addTarget:self action:@selector(transferClick)];
            return btn;
        }()];
        _footerView.height = W(75);
    }
    return _footerView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:TransferCarListCell.class forCellReuseIdentifier:@"TransferCarListCell"];
    self.tableView.top = 0;
    self.tableView.height = SCREEN_HEIGHT;
    self.tableView.tableFooterView = self.footerView;
    [self reconfigView];
    //request
    [self requestList];
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
        l.lineSpace = W(0);
        [l fitTitle:@"温馨提示" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(30), W(40)+NAVIGATIONBAR_HEIGHT);
        [self.headerView addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(8);
        [l fitTitle:@"为了更好的体验，您需要进行一次认证信息迁移操作" variable:SCREEN_WIDTH - W(60)];
        l.leftTop = XY(W(30), W(20)+top);
        [self.headerView addSubview:l];
        top = l.bottom;
    }
    if (self.aryDatas.count) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_RED;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(8);
        [l fitTitle:@"检测到您目前含有2辆车，请选择您最常运的车辆开始吧" variable:SCREEN_WIDTH - W(60)];
        l.leftTop = XY(W(30), W(50)+top);
        [self.headerView addSubview:l];
        top = l.bottom;
    }
    self.headerView.height = top + W(50);
    self.tableView.tableHeaderView = self.headerView;
}


#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.aryDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransferCarListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TransferCarListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TransferCarListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)transferClick{
    
}

#pragma mark request
- (void)requestList{
    [self reconfigView];

}
@end


@implementation TransferCarListCell
#pragma mark 懒加载
- (UILabel *)carNumber{
    if (_carNumber == nil) {
        _carNumber = [UILabel new];
        _carNumber.textColor = COLOR_666;
        _carNumber.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _carNumber.textAlignment = NSTextAlignmentCenter;
        _carNumber.widthHeight = XY(W(157), W(39));
    }
    return _carNumber;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.carNumber];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.carNumber.text  = @"";
    self.carNumber.centerXTop = XY(SCREEN_WIDTH/2.0,0);

    //设置总高度
    self.height = self.carNumber.bottom + W(30);
}

@end
