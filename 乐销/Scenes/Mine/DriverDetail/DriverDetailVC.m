//
//  DriverDetailVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/30.
//Copyright © 2018年 ping. All rights reserved.
//

#import "DriverDetailVC.h"
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

@interface DriverDetailVC ()
@property (nonatomic, strong) DriverDetailTopView *topView;
@property (nonatomic, strong) HotLineView *hotLineView;
@property (nonatomic, strong) UIVisualEffectView *masksView;//蒙板
@property (nonatomic, strong) UIImageView *ivBG;
@property (nonatomic, assign) int numMotorCade;

@end

@implementation DriverDetailVC

#pragma mark lazy init
- (DriverDetailTopView *)topView{
    if (!_topView) {
        _topView = [DriverDetailTopView new];
    }
    return _topView;
}
- (HotLineView *)hotLineView{
    if (!_hotLineView) {
        _hotLineView = [HotLineView new];
    }
    return _hotLineView;
}
- (UIVisualEffectView *)masksView
{
    if (_masksView == nil) {
        _masksView = [UIVisualEffectView  new];
        UIBlurEffect * beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _masksView = [[UIVisualEffectView alloc]initWithEffect:beffect];
        _masksView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return  _masksView;
}
- (UIImageView *)ivBG{
    if (!_ivBG) {
        _ivBG = [UIImageView new];
        _ivBG.backgroundColor = [UIColor whiteColor];
        _ivBG.contentMode = UIViewContentModeScaleAspectFill;
        WEAKSELF
        [_ivBG sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [weakSelf.ivBG addSubview:self.masksView];
        }];
        _ivBG.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        _ivBG.clipsToBounds = true;
        [_ivBG addSubview:^(){
            UIView * viewWhite = [UIView new];
            viewWhite.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
            viewWhite.widthHeight = XY( SCREEN_WIDTH, SCREEN_HEIGHT);
            return viewWhite;
        }()];
    }
    return _ivBG;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:self.ivBG belowSubview:self.tableView];
    //添加导航栏
    [self addNav];
    //bg
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableBackgroundView removeFromSuperview];
    self.tableView.tableHeaderView = self.topView;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoChange) name:NOTICE_SELFMODEL_CHANGE  object:nil];
    self.tableView.tableFooterView = self.hotLineView;
    //table
    [self.tableView registerClass:[DriverDetailCell class] forCellReuseIdentifier:@"DriverDetailCell"];
    //request
    [self reconfigData];
    [self request];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:^(){
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"编辑资料" rightBlock:^{
            [GB_Nav pushVCName:@"EditInfoVC" animated:true];
        }];
        nav.backgroundColor = [UIColor clearColor];
        nav.line.hidden = true;
        return nav;
    }()];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    DriverDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DriverDetailCell"];
    [cell resetCellWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    return [DriverDetailCell fetchHeight:model];
}

#pragma mark user detail change
- (void)userInfoChange{
    WEAKSELF
    [self.ivBG sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf.ivBG addSubview:self.masksView];
    }];
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
        model.title = @"司机认证";
        model.subTitle = modelUser.authStatusShow;
        model.imageName = @"driverDetail_driver";
        model.blockClick = ^{
            [ModelBaseInfo jumpToAuthorityStateVCSuccessBlock:nil];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"我的车队";
        model.subTitle = [NSString stringWithFormat:@"绑定%d家",weakSelf.numMotorCade];
        model.imageName = @"driverDetail_motorcade";
        model.blockClick = ^{
            CarTeamListManagementVC * vc = [CarTeamListManagementVC new];
            [GB_Nav pushViewController:vc animated:true];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"我的车辆";
        model.imageName = @"driverDetail_car";
        model.blockClick = ^{
            [GB_Nav pushVCName:@"CarListVC" animated:true];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"我的银行卡";
        model.imageName = @"driverDetail_card";
        model.blockClick = ^{
            [weakSelf requestBank];
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

@end
