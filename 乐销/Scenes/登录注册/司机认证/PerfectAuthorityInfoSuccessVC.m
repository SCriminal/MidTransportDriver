//
//  PerfectAuthorityInfoSuccessVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "PerfectAuthorityInfoSuccessVC.h"
// request
#import "RequestApi+UserApi.h"
//resubmit vc
#import "PerfectAuthorityInfoVC.h"
//image detail
#import "ImageDetailBigView.h"

@interface PerfectAuthorityInfoSuccessVC ()
@property (nonatomic, strong) UIImageView *ivSuccess;
@property (nonatomic, strong) UILabel *labelSuccess;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UIImageView *ivIdentity;
@property (nonatomic, strong) UIImageView *ivIdentityReverse;
@property (nonatomic, strong) UIImageView *ivDriver;
@property (nonatomic, strong) UIImageView *ivHand;
@property (nonatomic, strong) UILabel *labelInfo;
@property (strong, nonatomic) ModelAuthorityInfo *modelInfo;
@property (strong, nonatomic) ModelBaseInfo *modelBaseInfo;
@property (nonatomic, strong) NSMutableArray *aryImages;

@end

@implementation PerfectAuthorityInfoSuccessVC
#pragma mark 懒加载
- (UIImageView *)ivSuccess{
    if (_ivSuccess == nil) {
        _ivSuccess = [UIImageView new];
        _ivSuccess.image = [UIImage imageNamed:@"authority_succeed"];
        _ivSuccess.widthHeight = XY(W(100),W(100));
    }
    return _ivSuccess;
}
- (UILabel *)labelSuccess{
    if (_labelSuccess == nil) {
        _labelSuccess = [UILabel new];
        _labelSuccess.textColor = COLOR_333;
        _labelSuccess.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _labelSuccess;
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
    [self.view addSubview:self.ivSuccess];
    [self.view addSubview:self.labelSuccess];
    [self.view addSubview:self.labelTime];
    [self.view addSubview:self.ivIdentity];
    [self.view addSubview:self.ivIdentityReverse];
    [self.view addSubview:self.ivDriver];
    [self.view addSubview:self.ivHand];
    [self.view addSubview:self.labelInfo];
    //刷新view
    
    self.ivSuccess.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT + W(80));
    [self.labelSuccess fitTitle:@"您的认证信息已通过" variable:0];
    self.labelSuccess.centerXTop = XY(self.ivSuccess.centerX,self.ivSuccess.bottom+W(50));
    [self.labelTime fitTitle:@" " variable:0];
    self.labelTime.centerXTop = XY(self.ivSuccess.centerX,self.labelSuccess.bottom+W(20));
    
    self.labelInfo.centerXTop = XY(self.ivSuccess.centerX, self.labelTime.bottom + W(102));
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
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"司机认证" rightTitle:@"修改认证" rightBlock:^{
        PerfectAuthorityInfoVC * reSubmitVC = [PerfectAuthorityInfoVC new];
        reSubmitVC.userId = [GlobalData sharedInstance].GB_UserModel.iDProperty;
        [GB_Nav pushViewController:reSubmitVC animated:true];
    }];
    nav.line.hidden = true;
    [self.view addSubview:nav];
}

#pragma mark request
- (void)reqeustInfo{
    [RequestApi requestUserAuthorityInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelInfo = isAry([response arrayValueForKey:@"qualificationList"])?[ModelAuthorityInfo modelObjectWithDictionary:[response arrayValueForKey:@"qualificationList"].firstObject]:nil;
        [self.labelTime fitTitle: [GlobalMethod exchangeTimeWithStamp:self.modelInfo.reviewTime andFormatter:TIME_SEC_SHOW] variable:0];
        self.labelTime.centerXTop = XY(self.ivSuccess.centerX,self.labelSuccess.bottom+W(20));
        
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
            model.desc = @"驾驶证";
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
