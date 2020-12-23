//
//  CreditListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreditListVC.h"

@interface CreditListVC ()

@end

@implementation CreditListVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[CreditListCell class] forCellReuseIdentifier:@"CreditListCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"信用明细" rightView:nil];
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
    CreditListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CreditListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CreditListCell fetchHeight:self.aryDatas[indexPath.row]];
}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end



@implementation CreditListCell
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
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
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_333;
        _num.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _num;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.num];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
        [self.name fitTitle:@"运单评价" variable:0];
    self.name.leftTop = XY(W(15),W(18));
    [self.time fitTitle:@"2020-11-19 12:10:20" variable:0];
    self.time.leftTop = XY(W(15),self.name.bottom+W(13));
    self.height = self.time.bottom + W(18);
    
    [self.num fitTitle:@"+10" variable:0];
    self.num.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0 );
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end
