//
//  AuthListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthListVC.h"
//request
#import "RequestDriver2.h"
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
    [self addRefreshHeader];
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
    [RequestApi requestUserAuthAllInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthorityInfo * modelAuth = [ModelAuthorityInfo modelObjectWithDictionary:response];
        ModelBtn *mDriver = [ModelBtn new];
        ModelBtn *mCar = [ModelBtn new];
        ModelBtn *mBiz = [ModelBtn new];

        mDriver.title = @"司机信息";
        mCar.title = @"车辆信息";
        mBiz.title = @"运营信息";
        
        mDriver.subTitle = modelAuth.driverSubmitTime?[NSString stringWithFormat:@"提交时间：%@",[GlobalMethod exchangeTimeWithStamp:modelAuth.driverSubmitTime andFormatter:TIME_SEC_SHOW]]:@"未提交";
        mCar.subTitle = modelAuth.vehicleSubmitTime?[NSString stringWithFormat:@"提交时间：%@",[GlobalMethod exchangeTimeWithStamp:modelAuth.vehicleSubmitTime andFormatter:TIME_SEC_SHOW]]:@"未提交";
        mBiz.subTitle = modelAuth.bizSubmitTime?[NSString stringWithFormat:@"提交时间：%@",[GlobalMethod exchangeTimeWithStamp:modelAuth.bizSubmitTime andFormatter:TIME_SEC_SHOW]]:@"未提交";

        mDriver.thirdTitle = modelAuth.driverReviewTime?[NSString stringWithFormat:@"审核时间：%@",[GlobalMethod exchangeTimeWithStamp:modelAuth.driverReviewTime andFormatter:TIME_SEC_SHOW]]:@"";
        mCar.thirdTitle = modelAuth.vehicleReviewTime?[NSString stringWithFormat:@"审核时间：%@",[GlobalMethod exchangeTimeWithStamp:modelAuth.vehicleReviewTime andFormatter:TIME_SEC_SHOW]]:@"";
        mBiz.thirdTitle = modelAuth.bizReviewTime?[NSString stringWithFormat:@"审核时间：%@",[GlobalMethod exchangeTimeWithStamp:modelAuth.bizReviewTime andFormatter:TIME_SEC_SHOW]]:@"";
        
        mDriver.fourTitle = modelAuth.driverDescription;
        mCar.fourTitle = modelAuth.vehicleDescription;
        mBiz.fourTitle = modelAuth.bizDescription;
        
        mDriver.num = modelAuth.driverStatus;
        mCar.num = modelAuth.vehicleStatus;
        mBiz.num = modelAuth.bizStatus;
        self.aryDatas = @[mDriver,mCar,mBiz].mutableCopy;
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];}
@end


@implementation AuthListCell
#pragma mark 懒加载
- (UILabel *)status{
    if (!_status) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(10) weight:UIFontWeightMedium];
        l.textColor = [UIColor whiteColor];
        l.backgroundColor = [UIColor clearColor];
        l.textAlignment =NSTextAlignmentCenter;
        l.height = W(17);
        [GlobalMethod setRoundView:l color:[UIColor clearColor] numRound:4 width:0];
        _status = l;
    }
    return _status;
}
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
        [self.contentView addSubview:self.status];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
       
    [self.infoName fitTitle:model.title variable:0];
    self.infoName.leftTop = XY(W(15),W(18));
    [self.submitTime fitTitle:model.subTitle variable:0];
    self.submitTime.leftTop = XY(W(15),self.infoName.bottom+W(13));
    
    CGFloat top = self.submitTime.bottom;
    if (isStr(model.thirdTitle)) {
            [self.authTime fitTitle:model.thirdTitle variable:0];
        self.authTime.leftTop = XY(W(15),top+W(13));
        top = self.authTime.bottom;
    }
    if (isStr(model.fourTitle)) {
            [self.reason fitTitle: [NSString stringWithFormat:@"%@",model.fourTitle] variable:SCREEN_WIDTH - W(30)];
        self.reason.leftTop = XY(W(15),top+W(13));
        top = self.reason.bottom;
    }
    self.btn.rightCenterY = XY(SCREEN_WIDTH,self.infoName.centerY);
    //1未提交 2审核中 10通过 11未通过
    if (model.num == 1) {
        [self.btn setTitle:@"提交认证" forState:normal];
    }else  if (model.num == 2) {
        [self.btn setTitle:@"查看认证" forState:normal];
    }else  if (model.num == 10) {
        [self.btn setTitle:@"查看认证" forState:normal];
    }else if (model.num == 11) {
        [self.btn setTitle:@"重新认证" forState:normal];
    }
    self.status.text = [ModelAuthorityInfo statusTitle:model.num];
    self.status.backgroundColor =  [ModelAuthorityInfo statusColor:model.num];
    self.status.width = [UILabel fetchWidthFontNum:self.status.font.pointSize text:self.status.text]+W(8);
    self.status.leftCenterY = XY(self.infoName.right +W(6), self.infoName.centerY);
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
