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
@property (nonatomic, strong) DriverDetailModelView *modelView;

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
- (DriverDetailModelView *)modelView{
    if (!_modelView) {
        _modelView = [DriverDetailModelView new];
        [_modelView resetWithAry:@[^(){
            ModelBaseData * m = [ModelBaseData new];
            m.string = @"我的服务";
            m.aryDatas = @[^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"我的钱包";
                mB.imageName = @"personal_钱包";
                mB.blockClick = ^{
                    
                };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"认证中心";
                               mB.imageName = @"personal_车辆";
                               mB.blockClick = ^{
                                   [GB_Nav pushVCName:@"AuthListVC" animated:true];
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"扫一扫";
                               mB.imageName = @"personal_扫一扫";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"我的消息";
                               mB.imageName = @"personal_消息";
                               mB.blockClick = ^{
                                   [GB_Nav pushVCName:@"MyMsgVC" animated:true];                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"信用中心";
                               mB.imageName = @"personal_信用";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"积分商城";
                               mB.imageName = @"personal_积分";
                               mB.blockClick = ^{
                                   [GB_Nav pushVCName:@"IntegralCenterVC" animated:true];
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"我的路线";
                               mB.imageName = @"personal_法律";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"系统设置";
                               mB.imageName = @"personal_设置";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }()].mutableCopy;
            return m;
        }(),^(){
            ModelBaseData * m = [ModelBaseData new];
            m.string = @"其他服务";
            m.aryDatas = @[^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"查违章";
                mB.imageName = @"personal_违章";
                mB.blockClick = ^{
                    
                };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"货车导航";
                               mB.imageName = @"personal_导航";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"附近服务";
                               mB.imageName = @"personal_附近";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"我要加油";
                               mB.imageName = @"personal_加油";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"行业资讯";
                               mB.imageName = @"personal_资讯";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"司机专栏";
                               mB.imageName = @"personal_司机";
                               mB.blockClick = ^{
                                   
                               };
                return mB;
            }()].mutableCopy;
            return m;
        }()]];
    }
    return _modelView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    //bg
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableBackgroundView removeFromSuperview];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.tableFooterView = self.modelView;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoChange) name:NOTICE_SELFMODEL_CHANGE  object:nil];

    //table
    //request
    [self reconfigData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self request];
}

#pragma mark user detail change
- (void)userInfoChange{
    [self reconfigData];
}
#pragma mark request
- (void)reconfigData{
   
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
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
