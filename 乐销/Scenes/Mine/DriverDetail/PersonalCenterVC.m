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
//request

//request
#import "RequestDriver2.h"
//car list
#import "AddCardVC.h"
#import "BankCardListVC.h"
//cell
#import "SettingCell.h"
#import "AuthOneVC.h"
#import "QRCoderVC.h"
@interface PersonalCenterVC ()
@property (nonatomic, strong) DriverDetailTopView *topView;
@property (nonatomic, strong) DriverDetailModelView *modelView;
@property (nonatomic, strong) ModelAuthorityInfo *modelAuthInfo;
@property (nonatomic, strong) NSMutableArray *aryModule;

@end

@implementation PersonalCenterVC

#pragma mark lazy init
- (DriverDetailTopView *)topView{
    if (!_topView) {
        _topView = [DriverDetailTopView new];
        _topView.blockClick = ^{
            [GB_Nav pushVCName:@"EditInfoVC" animated:true];
        };
        WEAKSELF
        _topView.blockAuthClick = ^{
            [weakSelf jumpAuth];
        };
        _topView.blockSignClick = ^{
            [weakSelf requestSign];
        };
    }
    return _topView;
}
- (NSMutableArray *)aryModule{
    if (!_aryModule) {
        WEAKSELF
        _aryModule = @[^(){
            ModelBaseData * m = [ModelBaseData new];
            m.string = @"我的服务";
            m.aryDatas = @[^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"我的钱包";
                mB.imageName = @"personal_钱包";
                mB.blockClick = ^{
                    [GB_Nav pushVCName:@"MyPocketVC" animated:true];
                };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"认证中心";
                               mB.imageName = @"personal_车辆";
                               mB.blockClick = ^{
                                   [weakSelf jumpAuth];
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"扫一扫";
                               mB.imageName = @"personal_扫一扫";
                               mB.blockClick = ^{
                                   QRCoderVC * vc = [QRCoderVC new];
                                   [GB_Nav pushViewController:vc animated:true];

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
                                   [GB_Nav pushVCName:@"CreditCenterVC" animated:true];
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
                                   [GB_Nav pushVCName:@"MyPathListVC" animated:true];
                               };
                return mB;
            }(),^(){
                ModelBtn * mB = [ModelBtn new];
                mB.title = @"系统设置";
                               mB.imageName = @"personal_设置";
                               mB.blockClick = ^{
                                   [GB_Nav pushVCName:@"SettingVC" animated:true];

                               };
                return mB;
            }()].mutableCopy;
            return m;
        }()].mutableCopy;
    }
    return _aryModule;
}
- (DriverDetailModelView *)modelView{
    if (!_modelView) {
        _modelView = [DriverDetailModelView new];
        [_modelView resetWithAry:self.aryModule];
    }
    return _modelView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request) name:LOCAL_USERMODEL object:nil];
    //bg
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableBackgroundView removeFromSuperview];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT);
    //request
    [self reconfigData];
    [self requestModel];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self request];
}

#pragma mark request
- (void)reconfigData{
    [self.topView userInfoChange];
    [self.tableView reloadData];
}

#pragma mark request
- (void)jumpAuth{
    if (self.modelAuthInfo.isAuthed) {
        [GB_Nav pushVCName:@"AuthListVC" animated:true];
    }else{
        AuthOneVC * vc = [AuthOneVC new];
        vc.isFirst = true;
        [GB_Nav popToRootAry:@[vc] animate:true];
    }
   
}
- (void)request{
    [RequestApi requestUserInfo2WithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelBaseInfo *modelUser = GlobalData.sharedInstance.GB_UserModel;
        ModelBaseInfo * modelUserNew = [ModelBaseInfo modelObjectWithDictionary:response];
        if (![modelUser.description isEqualToString:modelUserNew.description]) {
            GlobalData.sharedInstance.GB_UserModel = modelUserNew;
        }
        [self reconfigData];
        [RequestApi requestUserAuthAllInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.modelAuthInfo = [ModelAuthorityInfo modelObjectWithDictionary:response];
            [self.topView resetAuth:self.modelAuthInfo.isAuthed];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestSign{
    [GB_Nav pushVCName:@"IntegralCenterVC" animated:true];
  
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)requestModel{
    [RequestApi requestModelsWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelModule"];
        
            ModelBaseData * m = [ModelBaseData new];
            m.string = @"其他服务";
        NSMutableArray * ary = [NSMutableArray array];
        for (ModelModule *item in aryRequest) {
            if (item.isOpen) {
                ModelBtn * mB = [ModelBtn new];
                mB.title = item.name;
                mB.imageName = item.iconUrl;
                mB.vcName =item.to;
                [ary addObject:mB];
            }
        }
        m.aryDatas = ary;
        
        if (self.aryModule.count > 1) {
            [self.aryModule removeLastObject];
        }
        if (ary.count > 0) {
            [self.aryModule addObject:m];
        }
        
        [self.modelView resetWithAry:self.aryModule];
        self.tableView.tableFooterView = nil;
        self.tableView.tableFooterView = self.modelView;

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
@end
