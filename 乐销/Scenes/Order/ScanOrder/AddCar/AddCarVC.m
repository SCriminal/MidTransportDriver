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
//车牌汉字选择
#import "SelectCarNumberView.h"
#import "SelectCarTypeVC.h"
#import "RequestApi+Dictionary.h"

@interface AddCarVC ()
@property (nonatomic, strong) ModelBaseData *modelCarNum;
@property (nonatomic, strong) ModelBaseData *modelOwner;
@property (nonatomic, strong) ModelBaseData *modelVehicleType;
@property (nonatomic, strong) ModelBaseData *modelVehicleLoad;
@property (nonatomic, strong) ModelBaseData *modelUnbindDriver;
@property (nonatomic, strong) ModelBaseData *modelTrailNumber;
@property (nonatomic, strong) UIView *viewHeaderFailure;
@property (nonatomic, strong) AuthorityImageView *bottomView;
@property (nonatomic, strong) AuthorityImageView *trailImageView;

@property (nonatomic, strong) ModelCar *modelDetail;
@property (nonatomic, strong) ModelOCR *modelOCRFace;
@property (nonatomic, strong) ModelOCR *modelOCRBack;

@end

@implementation AddCarVC

#pragma mark lazy init
- (ModelBaseData *)modelCarNum{
    if (!_modelCarNum) {
        _modelCarNum = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"车牌号码";
            model.placeHolderString = @"输入车牌号码";
            model.isRequired = true;
            model.isArrowHide = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelCarNum.string]) {
                        CGRect rectOrigin = [cell convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];
                        if (CGRectGetMinY(rectOrigin)>SCREEN_HEIGHT/2.0) {
                            [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:true];
                        }
                        break;
                    }
                }
                
                SelectCarNumberView * selectNumView = [SelectCarNumberView new];
                [selectNumView resetViewWithContent:weakSelf.modelCarNum.subString];
                [weakSelf.view addSubview:selectNumView];
                selectNumView.blockSelected = ^(NSString *str) {
                    weakSelf.modelCarNum.subString = str;
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                };
            };
            return model;
        }();
    }
    return _modelCarNum;
}
- (ModelBaseData *)modelOwner{
    if (!_modelOwner) {
        _modelOwner = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车拥有人";
            model.placeHolderString = @"输入车拥有人";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelOwner;
}
- (ModelBaseData *)modelTrailNumber{
    if (!_modelTrailNumber) {
        _modelTrailNumber = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"挂车车牌";
            model.placeHolderString = @"输入挂车车牌";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelTrailNumber;
}
- (ModelBaseData *)modelVehicleType{
    if (!_modelVehicleType) {
        WEAKSELF
        _modelVehicleType = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"车辆类型";
            model.placeHolderString = @"选择车辆类型";
            model.isRequired = true;
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                SelectCarTypeVC * selectVC = [SelectCarTypeVC new];
                selectVC.blockSelected = ^(NSString *type, NSNumber *idNumber) {
                    weakSelf.modelVehicleType.subString = type;
                    weakSelf.modelVehicleType.identifier = idNumber.stringValue;
                    [weakSelf configData];
                };
                [GB_Nav pushViewController:selectVC animated:true];
            };
            return model;
        }();
    }
    return _modelVehicleType;
}
- (ModelBaseData *)modelVehicleLoad{
    if (!_modelVehicleLoad) {
        WEAKSELF
        _modelVehicleLoad = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"核定载质量";
            model.placeHolderString = @"选择核定载质量";
            model.isRequired = true;
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                ListAlertView * listNew = [ListAlertView new];
                NSMutableArray * aryWeight = [NSMutableArray array];
                for (int i = 0; i<55; i++) {
                    [aryWeight addObject:[NSString stringWithFormat:@"%d吨",i+1]];
                }
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelVehicleLoad.string]) {
                        [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        [listNew showWithPoint:CGPointMake(W(15), NAVIGATIONBAR_HEIGHT + cell.height)  width:SCREEN_WIDTH - W(30) ary:aryWeight];
                        listNew.alpha = 0;
                        [UIView animateWithDuration:0.3 animations:^{
                            listNew.alpha = 1;
                        }];
                        break;
                    }
                }
                listNew.blockSelected = ^(NSInteger index) {
                    weakSelf.modelVehicleLoad.subString = aryWeight[index];
                    
                    [weakSelf.tableView reloadData];
                };
            };
            
            
            return model;
        }();
    }
    return _modelVehicleLoad;
}
- (AuthorityImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthorityImageView new];
        [self refreshBottomView:nil];
    }
    return _bottomView;
}
- (AuthorityImageView *)trailImageView{
    if (!_trailImageView) {
        _trailImageView = [AuthorityImageView new];
    }
    return _trailImageView;
}

- (UIView *)viewHeaderFailure{
    if (!_viewHeaderFailure) {
        _viewHeaderFailure = [UIView new];
        _viewHeaderFailure.width = SCREEN_WIDTH;
        _viewHeaderFailure.backgroundColor = [UIColor redColor];
    }
    return _viewHeaderFailure;
}
- (ModelBaseData *)modelUnbindDriver{
    if (!_modelUnbindDriver) {
        _modelUnbindDriver = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_EMPTY;
            model.imageName = @"";
            model.string = @"如无法识别，请重传清晰的证件照或手动添加以下信息";
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
    [self configHeaderView:nil];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
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
        [weakSelf requestAdd];
    }];
    //    [nav configBlackBackStyle];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelUnbindDriver,self.modelCarNum,self.modelVehicleLoad,self.modelOwner,self.modelVehicleType].mutableCopy;
    if ([self.modelVehicleType.subString containsString:@"牵引车"]) {
        [self.aryDatas addObject:self.modelTrailNumber];
        self.viewHeaderFailure.height = self.trailImageView.bottom;
        self.trailImageView.hidden = false;
        self.tableView.tableHeaderView = self.viewHeaderFailure;
    }else{
        [self.aryDatas removeObject:self.modelTrailNumber];
        self.viewHeaderFailure.height = self.bottomView.bottom;
        self.trailImageView.hidden = true;
        self.tableView.tableHeaderView = self.viewHeaderFailure;
    }
    [self.tableView reloadData];
    
}
- (void)configHeaderView:(NSString *)reason{
    [self.viewHeaderFailure removeAllSubViews];
    [self.viewHeaderFailure addSubview:self.bottomView];
    
    [self.viewHeaderFailure addSubview:self.trailImageView];
    self.trailImageView.top = self.bottomView.bottom-W(5);
    
    if (self.modelDetail.qualificationState == 10) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        l.textColor = [UIColor whiteColor];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:[NSString stringWithFormat:@"%@",UnPackStr(reason)] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(10));
        [self.viewHeaderFailure addSubview:l];
        self.bottomView.top = l.bottom + l.top;
    }else{
        self.bottomView.top = 0;
    }
    if ([self.modelVehicleType.subString containsString:@"牵引车"]) {
        self.viewHeaderFailure.height = self.trailImageView.bottom;
        self.trailImageView.hidden = false;
        self.tableView.tableHeaderView = self.viewHeaderFailure;
    }else{
        self.viewHeaderFailure.height = self.bottomView.bottom;
        self.trailImageView.hidden = true;
        self.tableView.tableHeaderView = self.viewHeaderFailure;
    }
    
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

#pragma mark request
- (void)requestAdd{
    [GlobalMethod endEditing];
    ModelImage * model0 = [self.bottomView.aryDatas objectAtIndex:0];
    ModelImage * model1 = [self.bottomView.aryDatas objectAtIndex:1];
    ModelImage * model2 = [self.bottomView.aryDatas objectAtIndex:2];
    ModelImage * model3 = [self.bottomView.aryDatas objectAtIndex:3];
    ModelImage * modelTrail0 = [self.trailImageView.aryDatas objectAtIndex:0];
    ModelImage * modelTrail1 = [self.trailImageView.aryDatas objectAtIndex:1];

    if (!isStr(model0.image.imageURL)) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model0.desc]];
        return;
    }
    if (!isStr(model1.image.imageURL)) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model1.desc]];
        return;
    }
    if (!isStr(model2.image.imageURL)) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model2.desc]];
        return;
    }
    if (!isStr(model3.image.imageURL)) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model3.desc]];
        return;
    }
    if ([self.modelVehicleType.subString containsString:@"牵引车"]) {
        if (!isStr(modelTrail0.image.imageURL)) {
            [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",modelTrail0.desc]];
            return;
        }
        if (!isStr(modelTrail1.image.imageURL)) {
            [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",modelTrail0.desc]];
            return;
        }
    }
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.isRequired) {
            if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
                if (!isStr(model.subString)) {
                    [GlobalMethod showAlert:model.placeHolderString];
                    return;
                }
            }
        }
    }
    self.modelCarNum.subString = self.modelCarNum.subString.uppercaseString;
    [RequestApi requestAddCarWithVin:self.modelOCRFace.vin
                        engineNumber:self.modelOCRFace.engineNumber
                       vehicleNumber:self.modelCarNum.subString
                         licenceType:0
                       trailerNumber:self.modelTrailNumber.subString
                      vehicleLicense:nil
                       vehicleLength:0
                         vehicleType:self.modelVehicleType.identifier.doubleValue
                         vehicleLoad:self.modelVehicleLoad.subString.doubleValue
                                axle:0
                        vehicleOwner:self.modelOwner.subString
              drivingLicenseFrontUrl:UnPackStr(model0.image.imageURL)
           drivingLicenseNegativeUrl:UnPackStr(model1.image.imageURL)
                 vehicleInsuranceUrl:nil
       vehicleTripartiteInsuranceUrl:nil
                 trailerInsuranceUrl:nil
       trailerTripartiteInsuranceUrl:nil
            trailerGoodsInsuranceUrl:nil
                     vehiclePhotoUrl:UnPackStr(model2.image.imageURL)
                managementLicenseUrl:nil
                              length:self.modelOCRBack.length
                              weight:self.modelOCRBack.width
                              height:self.modelOCRBack.height
                           grossMass:self.modelOCRBack.grossMass.doubleValue
                       drivingNumber:self.modelOCRBack.fileNumber
                               model:self.modelOCRFace.model
                        useCharacter:self.modelOCRFace.useCharacter
                          energyType:isStr(self.modelOCRBack.energyType)?[AddCarVC exchangeEnergeyTypeWithName:self.modelOCRBack.energyType].doubleValue:0
                 roadTransportNumber:nil
                       drivingAgency:nil
                 drivingRegisterDate:self.modelOCRFace.registerDateStamp
                    drivingIssueDate:self.modelOCRFace.issueDateStamp
                      drivingEndDate:0
                 driving2NegativeUrl:UnPackStr(model3.image.imageURL)
                            identity:self.carID
                  trailerDriving2Url:UnPackStr(modelTrail0.image.imageURL)
                  trailerDriving3Url:UnPackStr(modelTrail1.image.imageURL)
                            delegate:self
                             success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"您的车辆信息已经提交成功"];
        self.requestState = 1;
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestDetail{
    if (!self.carID) {
        return;
    }
    [RequestApi requestCarDetailWithId:self.carID delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCar * modelDetail = [ModelCar modelObjectWithDictionary:response];
        self.modelDetail = modelDetail;
        if (self.modelDetail.qualificationState == 10) {
            [self requestAuditRecord];
        }
        //config info
        self.modelCarNum.subString = modelDetail.vehicleNumber;
        self.modelCarNum.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelOwner.subString = modelDetail.vehicleOwner;
        self.modelOwner.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelVehicleLoad.subString = modelDetail.vehicleLoad? [NSString stringWithFormat:@"%@吨",NSNumber.dou(modelDetail.vehicleLoad)]:nil;
        self.modelVehicleLoad.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        
        //转化车辆类型
        self.modelVehicleType.identifier = strDotF(modelDetail.vehicleType);
        self.modelVehicleType.subString = [AddCarVC exchangeVehicleType:self.modelVehicleType.identifier];
        self.modelVehicleType.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelTrailNumber.subString = modelDetail.trailerNumber;
        
        [self refreshBottomView:modelDetail];

        [self configData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestAuditRecord{
    [RequestApi requestCarAuditListWithId:self.modelDetail.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAuditRecord"];
        if (ary.count) {
            ModelAuditRecord * model = ary.firstObject;
            [self configHeaderView:model.iDPropertyDescription];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)refreshBottomView:(ModelCar *)modelDetail{
    WEAKSELF
        [self.trailImageView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车驾驶证主页";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证正"] url:nil];
            model.isEssential = true;
            model.url = modelDetail.trailerDriving2Url;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            model.blockUpSuccess = ^(ModelImage *upImage) {
                [RequestApi requestOCRDriverWithurl:upImage.url side:@"face" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"faceResult"]];
                    weakSelf.modelOCRFace = model;
                    if (isStr(model.plateNumber)) {
                        weakSelf.modelTrailNumber.subString = model.plateNumber;
                        [weakSelf.tableView reloadData];
                    }
                  
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
            };
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加挂车驾驶证副页";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证正"] url:nil];
            model.isEssential = true;
            model.url = modelDetail.trailerDriving3Url;
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
            return model;
        }()]];
    [self.bottomView resetViewWithAryModels:@[^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加行驶证主页";
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证正"] url:nil];
        model.url = modelDetail.drivingLicenseFrontUrl;
        model.isEssential = true;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        model.cameraType = ENUM_CAMERA_ROAD;
        model.blockUpSuccess = ^(ModelImage *upImage) {
            [RequestApi requestOCRDriverWithurl:upImage.url side:@"face" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"faceResult"]];
                
                weakSelf.modelOCRFace = model;
                if (isStr(model.plateNumber)) {
                    weakSelf.modelCarNum.subString = model.plateNumber;
                }
                if (isStr(model.owner)) {
                    weakSelf.modelOwner.subString = model.owner;
                }
                if (isStr(model.vehicleType)) {
                    NSNumber * typeID = [AddCarVC exchangeVehicleTypeWithName:model.vehicleType];
                    if (typeID) {
                        weakSelf.modelVehicleType.subString = model.vehicleType;
                        weakSelf.modelVehicleType.identifier = typeID.stringValue;
                        [weakSelf configData];
                    }
                }
                [weakSelf.tableView reloadData];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        };
        
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加行驶证副页";
        model.isEssential = true;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证反"] url:nil];
        model.url = modelDetail.drivingLicenseNegativeUrl;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        model.blockUpSuccess = ^(ModelImage *upImage) {
            [RequestApi requestOCRDriverWithurl:upImage.url side:@"back" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"backResult"]];
                
                weakSelf.modelOCRBack = model;
                if (isStr(model.vehicleLoad)) {
                    weakSelf.modelVehicleLoad.subString = model.vehicleLoad;
                }
                [weakSelf.tableView reloadData];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        };
        
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"行驶证机动车相片页";
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_车辆照片"] url:nil];
        model.isEssential = true;
        model.url = modelDetail.vehiclePhotoUrl;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"行驶证检验页";
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_检验页"] url:nil];
        model.isEssential = true;
        model.url = modelDetail.driving2NegativeUrl;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }()]];
}


+ (NSString *)exchangeVehicleType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"CarType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}

+ (NSNumber *)exchangeVehicleTypeWithName:(NSString *)name{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"CarType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if ([name isEqualToString:[dic stringValueForKey:@"label"]]) {
            return [dic numberValueForKey:@"value"];
        }
    }
    return nil;
}
+ (NSString *)exchangeLicenseType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"LicenseType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}
+ (NSString *)exchangeEnergeyType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"EnergyType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}
+ (NSNumber *)exchangeEnergeyTypeWithName:(NSString *)name{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"EnergyType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if ([name isEqualToString:[dic stringValueForKey:@"label"]]) {
            return [dic numberValueForKey:@"value"];
        }
    }
    return nil;
}

@end
