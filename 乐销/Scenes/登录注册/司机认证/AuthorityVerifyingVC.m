//
//  AuthorityVerifyingVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "AuthorityVerifyingVC.h"
#import "BaseNavView+Logical.h"
#import "RequestApi+UserApi.h"
@interface AuthorityVerifyingVC ()
@property (strong, nonatomic) UIImageView *ivFail;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelTime;
@property (strong, nonatomic) UILabel *labelReason;
@property (strong, nonatomic) UILabel *labelSubReason;

@end

@implementation AuthorityVerifyingVC
#pragma mark 懒加载
- (UIImageView *)ivFail{
    if (_ivFail == nil) {
        _ivFail = [UIImageView new];
        _ivFail.image = [UIImage imageNamed:@"authority_audit"];
        _ivFail.widthHeight = XY(W(100),W(100));
    }
    return _ivFail;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(20)];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
        ModelBaseInfo * modelUser = GlobalData.sharedInstance.GB_UserModel;
        [_labelTitle fitTitle:(modelUser.isDriver==1&&modelUser.isIdentity==1)? @"变更认证信息审核中":@"认证信息审核中" variable:0];
    }
    return _labelTitle;
}
- (UILabel *)labelTime{
    if (_labelTime == nil) {
        _labelTime = [UILabel new];
        _labelTime.textColor = COLOR_666;
        _labelTime.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelTime.numberOfLines = 0;
        _labelTime.lineSpace = 0;
    }
    return _labelTime;
}

- (UILabel *)labelReason{
    if (_labelReason == nil) {
        _labelReason = [UILabel new];
        _labelReason.textColor = COLOR_999;
        _labelReason.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelReason.numberOfLines = 0;
        _labelReason.lineSpace = 0;
    }
    return _labelReason;
}
- (UILabel *)labelSubReason{
    if (!_labelSubReason) {
        _labelSubReason = [UILabel new];
        _labelSubReason.textColor = COLOR_999;
        _labelSubReason.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelSubReason.numberOfLines = 0;
        _labelSubReason.lineSpace = 0;
    }
    return _labelSubReason;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNav];
    self.viewBG.backgroundColor = [UIColor whiteColor];

    //添加subView
    [self.view addSubview:self.ivFail];
    [self.view addSubview:self.labelTitle];
    [self.view addSubview:self.labelTime];
    [self.view addSubview:self.labelSubReason];
    [self.view addSubview:self.labelReason];
    
    //刷新view
    self.ivFail.centerXTop = XY(SCREEN_WIDTH/2.0,W(90)+NAVIGATIONBAR_HEIGHT);
    
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH/2.0,self.ivFail.bottom+W(30));
    
    [self.labelTime fitTitle:@" " variable:0];
    self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));
    
    [self.labelReason fitTitle:@"请确保您提交的认证信息真实有效" variable:0];
    self.labelReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTime.bottom+W(90));
    [self.labelSubReason fitTitle:@"系统将在24小时内完成审核，请耐心等待" variable:0];
    self.labelSubReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelReason.bottom+W(15));
    
    [self reqeustInfo];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"认证状态" rightTitle:@"" rightBlock:^{
    }];
    [self.view addSubview:nav];
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark request
- (void)reqeustInfo{
    [RequestApi requestUserAuthorityInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthorityInfo *modelInfo = isAry([response arrayValueForKey:@"qualificationList"])?[ModelAuthorityInfo modelObjectWithDictionary:[response arrayValueForKey:@"qualificationList"].firstObject]:nil;
            [self.labelTime fitTitle: [GlobalMethod exchangeTimeWithStamp:modelInfo.submitTime andFormatter:TIME_SEC_SHOW] variable:0];
            self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end

