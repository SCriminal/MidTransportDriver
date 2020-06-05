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

@interface CarDetailVC ()
@property (nonatomic, strong) CarDetailView  *topView;
@property (nonatomic, strong) CarDetailImageView *bottomView;

@end

@implementation CarDetailVC

- (CarDetailView *)topView{
    if (!_topView) {
        _topView = [CarDetailView new];
    }
    return _topView;
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
    [self.view addSubview:[BaseNavView initNavBackTitle:@"车辆详情" rightView:nil]];
}

#pragma mark request
- (void)requestInfo{
    [RequestApi requestCarDetailWithId:self.carID entId:self.entID delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCar * modelDetail = [ModelCar modelObjectWithDictionary:response];
        
        [self.topView resetViewWithModel:modelDetail];
        self.tableView.tableHeaderView = self.topView;
        
        [self.bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"行驶证正面";
            model.url = modelDetail.drivingLicenseFrontUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isEssential = true;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"行驶证反面";
            model.isEssential = true;
            model.url = modelDetail.drivingLicenseNegativeUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }()]];
        self.tableView.tableFooterView = self.bottomView;
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}


@end
