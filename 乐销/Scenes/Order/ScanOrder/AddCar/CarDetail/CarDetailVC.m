//
//  CarDetailVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarDetailVC.h"
//detail view
#import "CarDetailView.h"

//request
#import "RequestApi+Order.h"
#import "AddCarVC.h"

@interface CarDetailVC ()
@property (nonatomic, strong) CarDetailStatusView  *statusView;
@property (nonatomic, strong) CarDetailImageView *bottomView;
@property (nonatomic, strong) ModelAuditRecord *modelRecord;
@property (nonatomic, strong) ModelCar *modelDetail;
@property (nonatomic, strong) BaseNavView *nav;

@end

@implementation CarDetailVC
- (CarDetailStatusView *)statusView{
    if (!_statusView) {
        _statusView = [CarDetailStatusView new];
    }
    return _statusView;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"车辆认证" rightView:nil];
    }
    return _nav;
}
- (CarDetailImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [CarDetailImageView new];
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //request
    [self requestInfo];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}

#pragma mark request
- (void)requestInfo{
    [RequestApi requestPersonalCarWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
         ModelCar * modelDetail = [ModelCar modelObjectWithDictionary:response];
           self.modelDetail = modelDetail;
           [self requestAuditRecord];
           
           if (modelDetail.qualificationState == 10) {
               WEAKSELF
               [self.nav resetNavBackTitle:@"车辆详情" rightTitle:@"重新提交" rightBlock:^{
                   AddCarVC * carVC = [AddCarVC new];
                   carVC.entID = weakSelf.modelDetail.entId;
                   carVC.carID = weakSelf.modelDetail.iDProperty;
                   [GB_Nav popLastAndPushVC:carVC];
               }];
           }

       } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
           
       }];
   
}
- (void)requestAuditRecord{
    [RequestApi requestCarAuditListWithId:self.modelDetail.iDProperty  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAuditRecord"];
        if (!ary.count) {
            return;
        }
        [self.statusView resetViewWithModel:self.modelDetail auditRecord:ary.firstObject];
        self.tableView.tableHeaderView = self.statusView;
        
        [self.bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"行驶证主页";
            model.url = self.modelDetail.drivingLicenseFrontUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isEssential = true;
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"行驶证副页";
            model.isEssential = true;
            model.url = self.modelDetail.drivingLicenseNegativeUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"车辆交强险保单";
            model.url = self.modelDetail.vehicleInsuranceUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isEssential = true;
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"车辆三者险保单";
            model.url = self.modelDetail.vehicleTripartiteInsuranceUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"挂车交强险保单";
            model.url = self.modelDetail.trailerInsuranceUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"挂车三者险保单";
            model.url = self.modelDetail.trailerTripartiteInsuranceUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"挂车箱货险保单";
            model.url = self.modelDetail.trailerGoodsInsuranceUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"车辆照片";
            model.url = self.modelDetail.vehiclePhotoUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"道路运输许可证";
            model.url = self.modelDetail.managementLicenseUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = self.modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }()]];
        self.tableView.tableFooterView = self.bottomView;
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}


@end
