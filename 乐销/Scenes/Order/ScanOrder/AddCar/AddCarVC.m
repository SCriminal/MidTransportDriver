//
//  AddCarVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "AddCarVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
#import "BaseTableVC+Authority.h"
#import "BaseNavView+Logical.h"
//select image
#import "AuthorityImageView.h"
//select date
#import "DatePicker.h"
//request
#import "RequestApi+Order.h"
//list view
#import "ListAlertView.h"
//up image
#import "AliClient.h"
//example vc
#import "AuthortiyExampleVC.h"

@interface AddCarVC ()
@property (nonatomic, strong) ModelBaseData *modelCarNum;
@property (nonatomic, strong) ModelBaseData *modelHangCode;
@property (nonatomic, strong) ModelBaseData *modelOwner;
@property (nonatomic, strong) ModelBaseData *modelCarIdentityCode;
@property (nonatomic, strong) ModelBaseData *modelMotorCode;
@property (nonatomic, strong) ModelBaseData *modelVehicleLicense;
@property (nonatomic, strong) ModelBaseData *modelVehicleLength;
@property (nonatomic, strong) ModelBaseData *modelVehicleType;
@property (nonatomic, strong) ModelBaseData *modelVehicleLoad;
@property (nonatomic, strong) ModelBaseData *modelAxle;
@property (nonatomic, strong) ModelBaseData *modelUnbindDriver;

@property (nonatomic, strong) AuthorityImageView *bottomView;
@property (nonatomic, strong) ModelCar *modelDetail;
@end

@implementation AddCarVC

#pragma mark lazy init
- (ModelBaseData *)modelCarNum{
    if (!_modelCarNum) {
        _modelCarNum = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车牌号码";
            model.placeHolderString = @"输入车牌号码(必填)";
            return model;
        }();
    }
    return _modelCarNum;
}
- (ModelBaseData *)modelVehicleLicense{
    if (!_modelVehicleLicense) {
        _modelVehicleLicense = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"行驶证号";
            model.placeHolderString = @"输入行驶证号码(必填)";
            return model;
        }();
    }
    return _modelVehicleLicense;
}
- (ModelBaseData *)modelOwner{
    if (!_modelOwner) {
        _modelOwner = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车所有人";
            model.placeHolderString = @"输入行驶证上车辆所有人 (必填)";
            return model;
        }();
    }
    return _modelOwner;
}
- (ModelBaseData *)modelCarIdentityCode{
    if (!_modelCarIdentityCode) {
        _modelCarIdentityCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"识别代码";
            model.placeHolderString = @"输入车辆识别代码";
            return model;
        }();
    }
    return _modelCarIdentityCode;
}
- (ModelBaseData *)modelMotorCode{
    if (!_modelMotorCode) {
        _modelMotorCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"发动机号";
            model.placeHolderString = @"输入车辆发动机号";
            return model;
        }();
    }
    return _modelMotorCode;
}
- (ModelBaseData *)modelHangCode{
    if (!_modelHangCode) {
        _modelHangCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"挂车号码";
            model.placeHolderString = @"输入挂车号码";
            return model;
        }();
    }
    return _modelHangCode;
}
- (ModelBaseData *)modelVehicleLength{
    if (!_modelVehicleLength) {
        WEAKSELF
        _modelVehicleLength = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"车辆长度";
            model.placeHolderString = @"选择车辆长度(必选)";
            model.blocClick = ^(ModelBaseData *modelClick) {
                ListAlertView * listNew = [ListAlertView new];
                NSArray * aryDateTypes = @[@"1.8米",@"2.7米",@"3.8米",@"4.2米",@"5米",@"6.2米",@"6.6米",@"6.8米",@"7.7米",@"7.8米",@"8.2米",@"8.7米",@"9.6米",@"11.7米",@"12.5米",@"13米",@"15米",@"16米",@"17.5米"];
                NSArray * aryDateId = @[@6,@7,@8,@9,@10,@11,@2,@1,@12,@3,@13,@14,@4,@15,@16,@5,@17,@18,@19];
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelVehicleLength.string]) {
                        [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        [listNew showWithPoint:CGPointMake(W(15), NAVIGATIONBAR_HEIGHT + cell.height)  width:SCREEN_WIDTH - W(30) ary:aryDateTypes];
                        listNew.alpha = 0;
                        [UIView animateWithDuration:0.3 animations:^{
                            listNew.alpha = 1;
                        }];
                        break;
                    }
                }
                listNew.blockSelected = ^(NSInteger index) {
                    weakSelf.modelVehicleLength.subString = aryDateTypes[index];
                    weakSelf.modelVehicleLength.identifier = [NSString stringWithFormat:@"%@", aryDateId[index]];
                    [weakSelf.tableView reloadData];
                };
            };
            return model;
        }();
    }
    return _modelVehicleLength;
}

- (ModelBaseData *)modelVehicleType{
    if (!_modelVehicleType) {
        WEAKSELF
        _modelVehicleType = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"车辆类型";
            model.placeHolderString = @"选择车辆类型(必选)";
            model.blocClick = ^(ModelBaseData *modelClick) {
                ListAlertView * listNew = [ListAlertView new];
                NSArray * aryDateTypes = @[@"普通货车",@"厢式货车",@"罐式货车",@"牵引车",@"普通挂车",@"罐式挂车",@"集装箱挂车",@"仓栅式货车",@"封闭货车",@"平板货车",@"集装箱车",@"自卸货车",@"特殊结构货车",@"专项作业车",@"厢式挂车",@"仓栅式挂车",@"平板挂车",@"自卸挂车",@"专项作业挂车",@"车辆运输车",@"车辆运输车（单排）"];
                NSArray * aryDateId = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21];
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelVehicleType.string]) {
                        [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        [listNew showWithPoint:CGPointMake(W(15), NAVIGATIONBAR_HEIGHT + cell.height)  width:SCREEN_WIDTH - W(30) ary:aryDateTypes];
                        listNew.alpha = 0;
                        [UIView animateWithDuration:0.3 animations:^{
                            listNew.alpha = 1;
                        }];
                        break;
                    }
                }
                listNew.blockSelected = ^(NSInteger index) {
                    weakSelf.modelVehicleType.subString = aryDateTypes[index];
                    weakSelf.modelVehicleType.identifier = [NSString stringWithFormat:@"%@", aryDateId[index]];
                    [weakSelf.tableView reloadData];
                };
            };
            return model;
        }();
    }
    return _modelVehicleType;
}

- (ModelBaseData *)modelVehicleLoad{
    if (!_modelVehicleLoad) {
        _modelVehicleLoad = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"标准载重";
            model.placeHolderString = @"输入标准载重:吨(必填)";
            return model;
        }();
    }
    return _modelVehicleLoad;
}
- (ModelBaseData *)modelAxle{
    if (!_modelAxle) {
        _modelAxle = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车轴数";
            model.placeHolderString = @"输入车轴数(必填)";
            return model;
        }();
    }
    return _modelAxle;
}
- (AuthorityImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthorityImageView new];
        [_bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加行驶证正面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证正"] url:nil];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加行驶证反面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证反"] url:nil];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加车辆交强险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加车辆三者险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车交强险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车三者险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车箱货险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加车辆照片";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_车辆照片"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加道路运输许可证";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_运输许可证"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }()]];
        
    }
    return _bottomView;
}

- (ModelBaseData *)modelUnbindDriver{
    if (!_modelUnbindDriver) {
        _modelUnbindDriver = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_EMPTY;
            model.imageName = @"";
            model.string = @"基本信息";
            return model;
        }();
        
    }
    return _modelUnbindDriver;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //    self.tableView.tableHeaderView = self.topView;
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.tableFooterView = self.bottomView;
    [self registAuthorityCell];
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request
    [self requestDetail];
    //configImage
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:self.carID?@"编辑车辆":@"添加车辆" rightTitle:@"提交" rightBlock:^{
        weakSelf.carID?[weakSelf requestEdit]:[weakSelf requestAdd];
    }];
    //    [nav configBlackBackStyle];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelUnbindDriver,self.modelCarNum,self.modelVehicleLicense,self.modelOwner,self.modelCarIdentityCode,self.modelMotorCode,self.modelHangCode,self.modelVehicleLength,self.modelVehicleType,self.modelVehicleLoad,self.modelAxle,^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        model.imageName = @"";
        model.string = @"认证资料";
        model.isSelected = true;
        model.blocClick = ^(ModelBaseData *item) {
            AuthortiyExampleVC * vc = [AuthortiyExampleVC new];
            vc.aryDatas =@[^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"行驶证正面示例";
                model.imageName = @"行驶证正";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"行驶证反面示例";
                model.imageName = @"行驶证反";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"车辆交强险保单示例";
                model.imageName = @"交强险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"车辆三者险保单示例";
                model.imageName = @"三者险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"挂车交强险保单示例";
                model.imageName = @"挂车交强险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"挂车三者险保单示例";
                model.imageName = @"挂车三者险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"挂车箱货险保单示例";
                model.imageName = @"挂车箱货险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"道路运输经营许可证示例";
                model.imageName = @"运输许可证";
                return model;
            }()].mutableCopy;
            [GB_Nav pushViewController:vc animated:true];
        };
        return model;
    }()].mutableCopy;
    [self.tableView reloadData];
    
}
#pragma mark image select
- (void)imageSelect:(BaseImage *)image{
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCell:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}
//#pragma mark status bar
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

#pragma mark request
- (void)requestAdd{
    ModelImage * model0 = [self.bottomView.aryDatas objectAtIndex:0];
    ModelImage * model1 = [self.bottomView.aryDatas objectAtIndex:1];
    ModelImage * model2 = [self.bottomView.aryDatas objectAtIndex:2];
    ModelImage * model3 = [self.bottomView.aryDatas objectAtIndex:3];
    ModelImage * model4 = [self.bottomView.aryDatas objectAtIndex:4];
    ModelImage * model5 = [self.bottomView.aryDatas objectAtIndex:5];
    ModelImage * model6 = [self.bottomView.aryDatas objectAtIndex:6];
    ModelImage * model7 = [self.bottomView.aryDatas objectAtIndex:7];
    ModelImage * model8 = [self.bottomView.aryDatas objectAtIndex:8];
    self.modelCarNum.subString = self.modelCarNum.subString.uppercaseString;
    [RequestApi requestAddCarWithVin:self.modelCarIdentityCode.subString
                        engineNumber:self.modelMotorCode.subString
                       vehicleNumber:self.modelCarNum.subString
                         licenceType:1
                       trailerNumber:self.modelHangCode.subString
                      vehicleLicense:self.modelVehicleLicense.subString
                       vehicleLength:self.modelVehicleLength.identifier.doubleValue
                         vehicleType:self.modelVehicleType.identifier.doubleValue
                         vehicleLoad:self.modelVehicleLoad.subString.doubleValue
                                axle:self.modelAxle.subString.doubleValue
                        vehicleOwner:self.modelOwner.subString
              drivingLicenseFrontUrl:UnPackStr(model0.image.imageURL)
           drivingLicenseNegativeUrl:UnPackStr(model1.image.imageURL)
                 vehicleInsuranceUrl:UnPackStr(model2.image.imageURL)
       vehicleTripartiteInsuranceUrl:UnPackStr(model3.image.imageURL)
                 trailerInsuranceUrl:UnPackStr(model4.image.imageURL)
       trailerTripartiteInsuranceUrl:UnPackStr(model5.image.imageURL)
            trailerGoodsInsuranceUrl:UnPackStr(model6.image.imageURL)
                     vehiclePhotoUrl:UnPackStr(model7.image.imageURL)
                managementLicenseUrl:UnPackStr(model8.image.imageURL)
                            delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        self.requestState = 1;
        [GB_Nav popViewControllerAnimated:true];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)requestEdit{
    ModelImage * model0 = [self.bottomView.aryDatas objectAtIndex:0];
    ModelImage * model1 = [self.bottomView.aryDatas objectAtIndex:1];
    ModelImage * model2 = [self.bottomView.aryDatas objectAtIndex:2];
    ModelImage * model3 = [self.bottomView.aryDatas objectAtIndex:3];
    ModelImage * model4 = [self.bottomView.aryDatas objectAtIndex:4];
    ModelImage * model5 = [self.bottomView.aryDatas objectAtIndex:5];
    ModelImage * model6 = [self.bottomView.aryDatas objectAtIndex:6];
    ModelImage * model7 = [self.bottomView.aryDatas objectAtIndex:7];
    ModelImage * model8 = [self.bottomView.aryDatas objectAtIndex:8];
    self.modelCarNum.subString = self.modelCarNum.subString.uppercaseString;
    [RequestApi requestResubmitCarWithVin:self.modelCarIdentityCode.subString
                             engineNumber:self.modelMotorCode.subString
                            vehicleNumber:self.modelCarNum.subString
                              licenceType:1
                            trailerNumber:self.modelHangCode.subString
                           vehicleLicense:self.modelVehicleLicense.subString
                            vehicleLength:self.modelVehicleLength.identifier.doubleValue
                              vehicleType:self.modelVehicleType.identifier.doubleValue
                              vehicleLoad:self.modelVehicleLoad.subString.doubleValue
                                     axle:self.modelAxle.subString.doubleValue
                                       id:self.carID
                             vehicleOwner:self.modelOwner.subString
                   drivingLicenseFrontUrl:UnPackStr(model0.image.imageURL)
                drivingLicenseNegativeUrl:UnPackStr(model1.image.imageURL)
                      vehicleInsuranceUrl:UnPackStr(model2.image.imageURL)
            vehicleTripartiteInsuranceUrl:UnPackStr(model3.image.imageURL)
                      trailerInsuranceUrl:UnPackStr(model4.image.imageURL)
            trailerTripartiteInsuranceUrl:UnPackStr(model5.image.imageURL)
                 trailerGoodsInsuranceUrl:UnPackStr(model6.image.imageURL)
                          vehiclePhotoUrl:UnPackStr(model7.image.imageURL)
                     managementLicenseUrl:UnPackStr(model8.image.imageURL)
                                 delegate:self success:^(NSDictionary * _Nonnull response, id _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        self.requestState = 1;
        [GB_Nav popViewControllerAnimated:true];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDetail{
    if (!self.carID) {
        return;
    }
    [RequestApi requestCarDetailWithId:self.carID entId:self.entID delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCar * modelDetail = [ModelCar modelObjectWithDictionary:response];
        self.modelDetail = modelDetail;
        
        
        
        [self.bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加行驶证正面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证正"] url:nil];
            model.url = modelDetail.drivingLicenseFrontUrl;
            model.isEssential = true;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加行驶证反面";
            model.isEssential = true;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证反"] url:nil];
            model.url = modelDetail.drivingLicenseNegativeUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加车辆交强险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.isEssential = true;
            model.url = modelDetail.vehicleInsuranceUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加车辆三者险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.url = modelDetail.vehicleTripartiteInsuranceUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车交强险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.url = modelDetail.trailerInsuranceUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车三者险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.url = modelDetail.trailerTripartiteInsuranceUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车箱货险保单";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:nil];
            model.url = modelDetail.trailerGoodsInsuranceUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加车辆照片";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_车辆照片"] url:nil];
            model.url = modelDetail.vehiclePhotoUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加道路运输许可证";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_运输许可证"] url:nil];
            model.url = modelDetail.managementLicenseUrl;
            model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }()]];
        //config info
        self.modelCarNum.subString = modelDetail.vehicleNumber;
        self.modelCarNum.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelHangCode.subString = modelDetail.trailerNumber;
        self.modelHangCode.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        
        
        self.modelOwner.subString = modelDetail.vehicleOwner;
        self.modelOwner.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelCarIdentityCode.subString = modelDetail.vin;
        self.modelCarIdentityCode.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelMotorCode.subString = modelDetail.engineNumber;
        self.modelMotorCode.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        
        self.modelVehicleLicense.subString = modelDetail.vehicleLicense;
        self.modelVehicleLicense.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        
        self.modelVehicleLoad.subString = modelDetail.vehicleLoad? strDotF(modelDetail.vehicleLoad):nil;
        self.modelVehicleLoad.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelAxle.subString = modelDetail.axle?strDotF(modelDetail.axle):nil;
        self.modelAxle.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        //转化车辆长度
        self.modelVehicleLength.identifier = strDotF(modelDetail.vehicleLength);
        self.modelVehicleLength.subString = [AddCarVC exchangeVehicleLength:self.modelVehicleLength.identifier];
        self.modelVehicleLength.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        //转化车辆类型
        self.modelVehicleType.identifier = strDotF(modelDetail.vehicleType);
        self.modelVehicleType.subString = [AddCarVC exchangeVehicleType:self.modelVehicleType.identifier];
        self.modelVehicleType.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        
        [self configData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

#pragma mark exchange type
+ (NSString *)exchangeVehicleLength:(NSString *)identity{
    NSArray * aryDateTypes = @[@"1.8米",@"2.7米",@"3.8米",@"4.2米",@"5米",@"6.2米",@"6.6米",@"6.8米",@"7.7米",@"7.8米",@"8.2米",@"8.7米",@"9.6米",@"11.7米",@"12.5米",@"13米",@"15米",@"16米",@"17.5米"];
    NSArray * aryDateId = @[@6,@7,@8,@9,@10,@11,@2,@1,@12,@3,@13,@14,@4,@15,@16,@5,@17,@18,@19];
    for (int i = 0; i<aryDateId.count; i++) {
        NSNumber * num = aryDateId[i];
        if (num.doubleValue == identity.doubleValue) {
            return aryDateTypes[i];
        }
    }
    return nil;
}
+ (NSString *)exchangeVehicleType:(NSString *)identity{
    NSArray * aryDateTypes = @[@"普通货车",@"厢式货车",@"罐式货车",@"牵引车",@"普通挂车",@"罐式挂车",@"集装箱挂车",@"仓栅式货车",@"封闭货车",@"平板货车",@"集装箱车",@"自卸货车",@"特殊结构货车",@"专项作业车",@"厢式挂车",@"仓栅式挂车",@"平板挂车",@"自卸挂车",@"专项作业挂车",@"车辆运输车",@"车辆运输车（单排）"];
    NSArray * aryDateId = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21];
    for (int i = 0; i<aryDateId.count; i++) {
        NSNumber * num = aryDateId[i];
        if (num.doubleValue == identity.doubleValue) {
            return aryDateTypes[i];
        }
    }
    return nil;
}
@end
