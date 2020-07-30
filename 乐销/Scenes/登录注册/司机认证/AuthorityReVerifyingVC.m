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
#import "BulkCargoListCell.h"

@interface AuthorityReVerifyingVC ()
@property (nonatomic, strong) UIImageView *ivSuccess;
@property (nonatomic, strong) UIImageView *ivIdentity;
@property (nonatomic, strong) UIImageView *ivIdentityReverse;
@property (nonatomic, strong) UIImageView *ivDriver;
@property (nonatomic, strong) UIImageView *ivHand;
@property (strong, nonatomic) ModelBaseInfo *modelBaseInfo;
@property (nonatomic, strong) NSMutableArray *aryImages;
@property (strong, nonatomic) ModelAuthorityInfo *modelInfo;

@end

@implementation AuthorityReVerifyingVC
#pragma mark 懒加载
- (UIImageView *)ivSuccess{
    if (_ivSuccess == nil) {
        _ivSuccess = [UIImageView new];
        _ivSuccess.image = [UIImage imageNamed:@"authority_audit"];
        _ivSuccess.widthHeight = XY(W(100),W(100));
    }
    return _ivSuccess;
}
- (UIImageView *)ivIdentity{
    if (_ivIdentity == nil) {
        _ivIdentity = [UIImageView new];
        _ivIdentity.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _ivIdentity.widthHeight = XY(W(78),W(65));
        _ivIdentity.contentMode = UIViewContentModeScaleAspectFill;
        _ivIdentity.clipsToBounds = true;
    }
    return _ivIdentity;
}
- (UIImageView *)ivIdentityReverse{
    if (_ivIdentityReverse == nil) {
        _ivIdentityReverse = [UIImageView new];
        _ivIdentityReverse.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _ivIdentityReverse.widthHeight = XY(W(78),W(65));
        _ivIdentityReverse.contentMode = UIViewContentModeScaleAspectFill;
        _ivIdentityReverse.clipsToBounds = true;
    }
    return _ivIdentityReverse;
}
- (UIImageView *)ivHand{
    if (_ivHand == nil) {
        _ivHand = [UIImageView new];
        _ivHand.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _ivHand.widthHeight = XY(W(78),W(65));
        _ivHand.contentMode = UIViewContentModeScaleAspectFill;
        _ivHand.clipsToBounds = true;
    }
    return _ivHand;
}
- (UIImageView *)ivDriver{
    if (_ivDriver == nil) {
        _ivDriver = [UIImageView new];
        _ivDriver.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _ivDriver.widthHeight = XY(W(78),W(65));
        _ivDriver.contentMode = UIViewContentModeScaleAspectFill;
        _ivDriver.clipsToBounds = true;
    }
    return _ivDriver;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor clearColor];
    //添加导航栏
    [self addNav];
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
- (void)configView:(NSDictionary *)response{
    //添加subView
    [self.view addSubview:self.ivSuccess];
    [self.view addSubview:self.ivIdentity];
    [self.view addSubview:self.ivIdentityReverse];
    [self.view addSubview:self.ivDriver];
    [self.view addSubview:self.ivHand];
    
    
    self.ivSuccess.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT + W(46));
    
    CGFloat top = [self.view addLineFrame:CGRectMake(W(15), self.ivSuccess.bottom + W(50), SCREEN_WIDTH - W(30), 1)];
    __block int tag = 100;
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"审核状态";
        m.color = COLOR_BLUE;
        m.subTitle = @"审核通过";
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.view top:top + W(20)];

    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"提交时间";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:self.modelInfo.submitTime andFormatter:TIME_SEC_SHOW];
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.view top:top + W(20)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"真实姓名";
        m.subTitle = [response stringValueForKey:@"realName"];
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.view top:top + W(20)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"身份证号";
        m.subTitle = [response stringValueForKey:@"idNumber"];
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.view top:top + W(20)];
    
    top = [self.view addLineFrame:CGRectMake(W(15), top + W(20), SCREEN_WIDTH - W(30), 1)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"认证资料";
        m.subTitle = @"";
        m.tag = ++tag;
        m.left = W(15);
        m.right = W(15);
        return m;
    }() view:self.view top:top + W(20)];
    
    self.ivIdentityReverse.rightTop = XY(SCREEN_WIDTH/2.0 - W(5),top+W(15));

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
                    self.modelInfo = modelItem;
                    break;
                }
            }
        }
        [self requestQualificationImages];
        
        [self configView:response];

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
