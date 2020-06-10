//
//  AuthorityReVerifyingVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "AuthorityReVerifyingVC.h"
// request
#import "RequestApi+UserApi.h"
//resubmit vc
#import "PerfectAuthorityInfoVC.h"
//image detail
#import "ImageDetailBigView.h"

@interface AuthorityReVerifyingVC ()
@property (nonatomic, strong) UIImageView *ivLogan;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UIImageView *ivIdentity;
@property (nonatomic, strong) UIImageView *ivIdentityReverse;
@property (nonatomic, strong) UIImageView *ivDriver;
@property (nonatomic, strong) UIImageView *ivHand;
@property (nonatomic, strong) UILabel *labelInfo;
@property (strong, nonatomic) ModelBaseInfo *modelBaseInfo;
@property (strong, nonatomic) UILabel *labelReason;
@property (nonatomic, strong) NSMutableArray *aryImages;

@end

@implementation AuthorityReVerifyingVC
#pragma mark 懒加载
- (UIImageView *)ivLogan{
    if (_ivLogan == nil) {
        _ivLogan = [UIImageView new];
        _ivLogan.image = [UIImage imageNamed:@"authority_succeed"];
        _ivLogan.widthHeight = XY(W(100),W(100));
    }
    return _ivLogan;
}
- (UILabel *)labelReason{
    if (_labelReason == nil) {
        _labelReason = [UILabel new];
        _labelReason.textColor = COLOR_666;
        _labelReason.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelReason.numberOfLines = 0;
        _labelReason.lineSpace = 0;
        [_labelReason fitTitle:@"变更认证信息已提交" variable:0];
    }
    return _labelReason;
}

- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        ModelBaseInfo * modelUser = GlobalData.sharedInstance.GB_UserModel;
        [_labelTitle fitTitle:(modelUser.isDriver==1&&modelUser.isIdentity==1)? @"您的认证信息已通过":@"认证信息审核中" variable:0];

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
- (UIImageView *)ivIdentity{
    if (_ivIdentity == nil) {
        _ivIdentity = [UIImageView new];
        _ivIdentity.image = [UIImage imageNamed:@"perfectAuthorityIdentity"];
        _ivIdentity.widthHeight = XY(W(65),W(50));
        _ivIdentity.contentMode = UIViewContentModeScaleAspectFill;
        _ivIdentity.clipsToBounds = true;
    }
    return _ivIdentity;
}
- (UIImageView *)ivIdentityReverse{
    if (_ivIdentityReverse == nil) {
        _ivIdentityReverse = [UIImageView new];
        _ivIdentityReverse.image = [UIImage imageNamed:@"perfectAuthorityIdentity"];
        _ivIdentityReverse.widthHeight = XY(W(65),W(50));
        _ivIdentityReverse.contentMode = UIViewContentModeScaleAspectFill;
        _ivIdentityReverse.clipsToBounds = true;
    }
    return _ivIdentityReverse;
}
- (UIImageView *)ivHand{
    if (_ivHand == nil) {
        _ivHand = [UIImageView new];
        _ivHand.image = [UIImage imageNamed:@"perfectAuthorityIdentity"];
        _ivHand.widthHeight = XY(W(65),W(50));
        _ivHand.contentMode = UIViewContentModeScaleAspectFill;
        _ivHand.clipsToBounds = true;
    }
    return _ivHand;
}
- (UIImageView *)ivDriver{
    if (_ivDriver == nil) {
        _ivDriver = [UIImageView new];
        _ivDriver.image = [UIImage imageNamed:@"perfectAuthorityIdentity"];
        _ivDriver.widthHeight = XY(W(65),W(50));
        _ivDriver.contentMode = UIViewContentModeScaleAspectFill;
        _ivDriver.clipsToBounds = true;
    }
    return _ivDriver;
}
- (UILabel *)labelInfo{
    if (_labelInfo == nil) {
        _labelInfo = [UILabel new];
        _labelInfo.textColor = COLOR_666;
        _labelInfo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelInfo.textAlignment = NSTextAlignmentCenter;
        _labelInfo.backgroundColor = [UIColor whiteColor];
        [_labelInfo fitTitle:@"认证资料" fixed:W(112)];
    }
    return _labelInfo;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor clearColor];
    //添加导航栏
    [self addNav];
    [self configView];
    //config view
    [self reqeustInfo];
    [self addClickAction];

}
- (void)addClickAction{
    self.ivIdentity.tag = 0;
    self.ivIdentityReverse.tag = 1;
    self.ivDriver.tag = 2;
    self.ivHand.tag = 3;
    [self.ivIdentity addTarget:self action:@selector(imageClick:)];
    [self.ivIdentityReverse addTarget:self action:@selector(imageClick:)];
    [self.ivDriver addTarget:self action:@selector(imageClick:)];
    [self.ivHand addTarget:self action:@selector(imageClick:)];
    
}
- (void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView * view = (UIImageView *)tap.view;
    if (![view isKindOfClass:UIImageView.class]) {
        return;
    }
    if (view.tag > self.aryImages.count-1) {
        return;
    }
    ImageDetailBigView * detailView = [ImageDetailBigView new];
    [detailView resetView:self.aryImages isEdit:false index: view.tag];
    [detailView showInView:[GB_Nav.lastVC view] imageViewShow:view];
}
- (void)configView{
    //添加subView
    [self.view addSubview:self.ivLogan];
    [self.view addSubview:self.labelTitle];
    [self.view addSubview:self.labelTime];
    [self.view addSubview:self.ivIdentity];
    [self.view addSubview:self.ivIdentityReverse];
    [self.view addSubview:self.ivDriver];
    [self.view addSubview:self.ivHand];
    [self.view addSubview:self.labelInfo];
    [self.view addSubview:self.labelReason];
    
    
    //刷新view
    
    self.ivLogan.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT + W(80));
    self.labelTitle.centerXTop = XY(self.ivLogan.centerX,self.ivLogan.bottom+W(50));
    [self.labelTime fitTitle:@" " variable:0];
    self.labelTime.centerXTop = XY(self.ivLogan.centerX,self.labelTitle.bottom+W(20));
    
    self.labelReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTime.bottom+W(20));
    
    self.labelInfo.centerXTop = XY(self.ivLogan.centerX, self.labelTime.bottom + W(102));
    [self.view insertSubview:^(){
        UIView * viewLine = [UIView new];
        viewLine.frame = CGRectMake(W(44), self.labelInfo.centerY, SCREEN_WIDTH - W(88), 1);
        viewLine.backgroundColor = COLOR_LINE;
        return viewLine;
    }() belowSubview:self.labelInfo];
    
    self.ivIdentityReverse.rightTop = XY(SCREEN_WIDTH/2.0 - W(5),self.labelInfo.bottom+W(25));
    
    self.ivIdentity.rightCenterY = XY(self.ivIdentityReverse.left - W(10),self.ivIdentityReverse.centerY);
    
    self.ivDriver.leftCenterY = XY(self.ivIdentityReverse.right + W(10),self.ivIdentityReverse.centerY);
    
    self.ivHand.leftCenterY = XY(self.ivDriver.right + W(10),self.ivIdentityReverse.centerY);
    
    
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"司机认证" rightTitle:@"" rightBlock:nil];
    nav.line.hidden = true;
    [self.view addSubview:nav];
}

#pragma mark request
- (void)reqeustInfo{
    [RequestApi requestUserAuthorityInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryRespons = [response arrayValueForKey:@"qualificationList"];
        if (isAry(aryRespons)) {
            for (int i = 0; i<aryRespons.count; i++) {
                NSDictionary * dicItem = aryRespons[i];
                ModelAuthorityInfo * modelItem = [ModelAuthorityInfo modelObjectWithDictionary:dicItem];
                if (modelItem.status == 3) {
                    [self.labelTime fitTitle: [GlobalMethod exchangeTimeWithStamp:modelItem.reviewTime andFormatter:TIME_SEC_SHOW] variable:0];
                    self.labelTime.centerXTop = XY(self.ivLogan.centerX,self.labelTitle.bottom+W(20));
                    break;
                }
            }
        }
        [self requestQualificationImages];
        
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestQualificationImages{
    [RequestApi requestUserAuthoritySuccessInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.ivIdentity sd_setImageWithURL:[NSURL URLWithString:[response stringValueForKey:@"idCardFrontUrl"]] placeholderImage:self.ivIdentity.image];
        [self.ivIdentityReverse sd_setImageWithURL:[NSURL URLWithString:[response stringValueForKey:@"idCardBackUrl"]] placeholderImage:self.ivIdentityReverse.image];
        [self.ivDriver sd_setImageWithURL:[NSURL URLWithString:[response stringValueForKey:@"driverLicenseUrl"]] placeholderImage:self.ivDriver.image];
        [self.ivHand sd_setImageWithURL:[NSURL URLWithString:[response stringValueForKey:@"idCardHandelUrl"]] placeholderImage:self.ivHand.image];
        
        self.aryImages = @[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"身份证人像面";
            model.url = [response stringValueForKey:@"idCardFrontUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"身份证国徽面";
            model.url = [response stringValueForKey:@"idCardBackUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"驾驶证主页";
            model.url = [response stringValueForKey:@"driverLicenseUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"手持身份证人像面";
            model.url = [response stringValueForKey:@"idCardHandelUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            return model;
        }()].mutableCopy;
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
