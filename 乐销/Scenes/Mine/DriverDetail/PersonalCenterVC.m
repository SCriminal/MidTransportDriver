//
//  PersonalCenterVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/30.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PersonalCenterVC.h"
//image select
#import "BaseVC+BaseImageSelectVC.h"
//up image
#import "AliClient.h"
//top view
#import "DriverDetailTopView.h"
//hot line view
#import "HotLineView.h"
//request
#import "RequestApi+UserApi.h"
#import "RequestApi+Dictionary.h"

//car team vc
#import "CarTeamListManagementVC.h"
//car list
#import "AddCardVC.h"
#import "BankCardListVC.h"
//cell
#import "SettingCell.h"

@interface PersonalCenterVC ()
@property (nonatomic, strong) DriverDetailTopView *topView;
@property (nonatomic, assign) int numMotorCade;

@end

@implementation PersonalCenterVC

#pragma mark lazy init
- (DriverDetailTopView *)topView{
    if (!_topView) {
        _topView = [DriverDetailTopView new];
        _topView.blockClick = ^{
            [GB_Nav pushVCName:@"EditInfoVC" animated:true];
        };
    }
    return _topView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    //bg
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableBackgroundView removeFromSuperview];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoChange) name:NOTICE_SELFMODEL_CHANGE  object:nil];

    //table
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"SettingCell"];
    [self.tableView registerClass:[SettingEmptyCell class] forCellReuseIdentifier:@"SettingEmptyCell"];
    //request
    [self reconfigData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self request];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    if (!isStr(model.title)) {
        SettingEmptyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettingEmptyCell"];
        [cell resetCellWithModel:nil];
        return cell;
    }
    SettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    [cell resetCellWithModel:model];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    if (!isStr(model.title)) {
        return [SettingEmptyCell fetchHeight:model];
    }
    return [SettingCell fetchHeight:model];
}

#pragma mark user detail change
- (void)userInfoChange{
    [self reconfigData];
}
#pragma mark request
- (void)reconfigData{
    WEAKSELF
    ModelBaseInfo * modelUser = [GlobalData sharedInstance].GB_UserModel;
    self.aryDatas = @[
                     /* ^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"当前积分";
        model.subTitle = @"0分";
        model.imageName = @"driverDetail_integral";
        model.blockClick = ^{
            [GB_Nav pushVCName:@"IntegralRecordVC" animated:true];
        };
        return model;
    }(),*/
        ^(){
               ModelBtn * model = [ModelBtn new];
               return model;
           }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"司机认证";
        model.subTitle = modelUser.authStatusShow;
        model.imageName = @"personalCenter_driver";
        model.blockClick = ^{
            [ModelBaseInfo jumpToAuthorityStateVCSuccessBlock:nil];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车辆认证";
        model.imageName = @"personalCenter_car";
        model.blockClick = ^{
            [GB_Nav pushVCName:@"CarListVC" animated:true];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"我的车队";
        model.subTitle = [NSString stringWithFormat:@"绑定%d家",weakSelf.numMotorCade];
        model.imageName = @"personalCenter_motorcade";
        model.blockClick = ^{
            CarTeamListManagementVC * vc = [CarTeamListManagementVC new];
            [GB_Nav pushViewController:vc animated:true];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"我的银行卡";
        model.imageName = @"personalCenter_card";
        model.blockClick = ^{
            [weakSelf requestBank];
        };
        return model;
    }(), ^(){
                  ModelBtn * model = [ModelBtn new];
                  return model;
              }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"设置";
        model.imageName = @"personalCenter_set";
        model.blockClick = ^{
            [GB_Nav pushVCName:@"SettingVC" animated:true];
        };
        return model;
    }()].mutableCopy;
    [self.tableView reloadData];
}

#pragma mark request
- (void)request{
    [RequestApi requestUserInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelBaseInfo *modelUser = GlobalData.sharedInstance.GB_UserModel;
        ModelBaseInfo * modelUserNew = [ModelBaseInfo modelObjectWithDictionary:response];
        if (![modelUser.description isEqualToString:modelUserNew.description]) {
            GlobalData.sharedInstance.GB_UserModel = modelUserNew;
        }
        [self reconfigData];
        [self requestMotorcadeList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestMotorcadeList{
    [RequestApi requestMotorcadeListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryMotorCade = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelMotrocadeList"];
        self.numMotorCade = (int)aryMotorCade.count;
        [self reconfigData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestBank{
    [RequestApi requestBankCardWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelBank * model = [ModelBank modelObjectWithDictionary:response];
        
        if (!model.iDProperty) {
            AddCardVC * addVC = [AddCardVC new];
            [GB_Nav pushViewController:addVC animated:true];
        }else{
            BankCardListVC * vc = [BankCardListVC new];
            vc.modelBank = model;
            [GB_Nav pushViewController:vc animated:true];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
  
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
