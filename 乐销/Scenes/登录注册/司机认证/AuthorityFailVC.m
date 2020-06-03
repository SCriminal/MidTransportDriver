//
//  AuthorityFailVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "AuthorityFailVC.h"
#import "BaseNavView+Logical.h"
#import "RequestApi+UserApi.h"
#import "PerfectAuthorityInfoVC.h"

@interface AuthorityFailVC ()
@property (strong, nonatomic) UIImageView *ivFail;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelTime;
@property (strong, nonatomic) UIButton *btnSubmit;
@property (strong, nonatomic) UILabel *labelReason;
@property (strong, nonatomic) ModelAuthorityInfo *modelInfo;
@property (strong, nonatomic) ModelBaseInfo *modelBaseInfo;

@end

@implementation AuthorityFailVC
#pragma mark 懒加载
- (UIImageView *)ivFail{
    if (_ivFail == nil) {
        _ivFail = [UIImageView new];
        _ivFail.image = [UIImage imageNamed:@"authority_defeated"];
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
        [_labelTitle fitTitle:(modelUser.isDriver==1&&modelUser.isIdentity==1)? @"变更认证信息已驳回":@"认证信息审核失败" variable:0];
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
-(UIButton *)btnSubmit{
    if (_btnSubmit == nil) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.tag = 1;
        [_btnSubmit addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnSubmit.backgroundColor = COLOR_BLUE;
        _btnSubmit.titleLabel.fontNum = F(15);
        [_btnSubmit setTitle:@"重新提交" forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_btnSubmit color:[UIColor clearColor] numRound:5 width:0];
        _btnSubmit.widthHeight = XY(W(235),W(45));
    }
    return _btnSubmit;
}
- (UILabel *)labelReason{
    if (_labelReason == nil) {
        _labelReason = [UILabel new];
        _labelReason.textColor = [UIColor redColor];
        _labelReason.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelReason.numberOfLines = 0;
        _labelReason.lineSpace = 0;
    }
    return _labelReason;
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
    [self.view addSubview:self.btnSubmit];
    [self.view addSubview:self.labelReason];
    
    //刷新view
    self.ivFail.centerXTop = XY(SCREEN_WIDTH/2.0,W(90)+NAVIGATIONBAR_HEIGHT);

    self.labelTitle.centerXTop = XY(SCREEN_WIDTH/2.0,self.ivFail.bottom+W(30));
    [self.labelTime fitTitle:@" " variable:0];
    
    self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));

    self.btnSubmit.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTime.bottom+W(90));
    [self.labelReason fitTitle:@" " variable:0];
    self.labelReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.btnSubmit.bottom+W(50));
    
    [self reqeustInfo];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            PerfectAuthorityInfoVC * reSubmitVC = [PerfectAuthorityInfoVC new];
            reSubmitVC.userId = [GlobalData sharedInstance].GB_UserModel.iDProperty;
            [GB_Nav pushViewController:reSubmitVC animated:true];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"认证状态" rightView:nil];
    [self.view addSubview:nav];
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark request
- (void)reqeustInfo{
    [RequestApi requestUserAuthorityInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelInfo =  isAry([response arrayValueForKey:@"qualificationList"])?[ModelAuthorityInfo modelObjectWithDictionary:[response arrayValueForKey:@"qualificationList"].firstObject]:nil;
        
        [self.labelTime fitTitle: [GlobalMethod exchangeTimeWithStamp:self.modelInfo.reviewTime andFormatter:TIME_SEC_SHOW] variable:0];
        self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));
        
        
        [self.labelReason fitTitle:[NSString stringWithFormat:@"失败原因：%@",UnPackStr(self.modelInfo.explain)] variable:0];
        self.labelReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.btnSubmit.bottom+W(50));

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
