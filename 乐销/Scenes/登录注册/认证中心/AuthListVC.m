//
//  AuthListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthListVC.h"

@interface AuthListVC ()

@end

@implementation AuthListVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[AuthListCell class] forCellReuseIdentifier:@"AuthListCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"认证中心" rightView:nil];
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
    AuthListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AuthListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AuthListCell fetchHeight:self.aryDatas[indexPath.row]];
}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end


@implementation AuthListCell
#pragma mark 懒加载
- (UILabel *)infoName{
    if (_infoName == nil) {
        _infoName = [UILabel new];
        _infoName.textColor = COLOR_333;
        _infoName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _infoName;
}
- (UILabel *)submitTime{
    if (_submitTime == nil) {
        _submitTime = [UILabel new];
        _submitTime.textColor = COLOR_999;
        _submitTime.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _submitTime;
}
- (UILabel *)authTime{
    if (_authTime == nil) {
        _authTime = [UILabel new];
        _authTime.textColor = COLOR_999;
        _authTime.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _authTime;
}
- (UILabel *)reason{
    if (_reason == nil) {
        _reason = [UILabel new];
        _reason.textColor = COLOR_RED;
        _reason.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _reason;
}
-(UIButton *)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.tag = 1;
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = [UIColor clearColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_btn setTitle:@"重新认证" forState:(UIControlStateNormal)];
        [_btn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btn.widthHeight = XY(W(78),W(40));

    }
    return _btn;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.infoName];
    [self.contentView addSubview:self.submitTime];
    [self.contentView addSubview:self.authTime];
    [self.contentView addSubview:self.reason];
    [self.contentView addSubview:self.btn];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
       
    [self.infoName fitTitle:@"司机信息" variable:0];
    self.infoName.leftTop = XY(W(15),W(18));
    [self.submitTime fitTitle:@"提交时间：2020-11-19 12:10:20" variable:0];
    self.submitTime.leftTop = XY(W(15),self.infoName.bottom+W(13));
    
    CGFloat top = self.submitTime.bottom;
    if (self.submitTime) {
            [self.authTime fitTitle:@"审核时间：2020-11-19 12:10:20" variable:0];
        self.authTime.leftTop = XY(W(15),top+W(13));
        top = self.authTime.bottom;
    }
    if (self.reason) {
            [self.reason fitTitle:@"驳回原因：身份证照片不清晰" variable:SCREEN_WIDTH - W(30)];
        self.reason.leftTop = XY(W(15),top+W(13));
        top = self.reason.bottom;
    }
    self.btn.rightCenterY = XY(SCREEN_WIDTH,self.infoName.centerY);

    //设置总高度
    self.height = top + W(18);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height- 1, SCREEN_WIDTH - W(30), 1)];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (self.blockClick) {
        self.blockClick();
    }
}

@end
