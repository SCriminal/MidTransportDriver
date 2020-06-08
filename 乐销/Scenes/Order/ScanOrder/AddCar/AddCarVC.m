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
@property (nonatomic, strong) ModelBaseData *modelOwner;
@property (nonatomic, strong) ModelBaseData *modelVehicleType;
@property (nonatomic, strong) ModelBaseData *modelVehicleLoad;
@property (nonatomic, strong) ModelBaseData *modelUnbindDriver;
@property (nonatomic, strong) UIView *viewHeaderFailure;
@property (nonatomic, strong) AuthorityImageView *bottomView;
@property (nonatomic, strong) ModelCar *modelDetail;
@property (nonatomic, strong) NSMutableArray *aryCarType;
@property (nonatomic, strong) NSMutableArray *aryCarID;

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
            model.placeHolderString = @"输入车牌号码";
            model.isRequired = true;
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
            model.placeHolderString = @"输入车辆拥有人";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelOwner;
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
                ListAlertView * listNew = [ListAlertView new];
               
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelVehicleType.string]) {
                        [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        [listNew showWithPoint:CGPointMake(W(15), NAVIGATIONBAR_HEIGHT + cell.height)  width:SCREEN_WIDTH - W(30) ary:weakSelf.aryCarType];
                        listNew.alpha = 0;
                        [UIView animateWithDuration:0.3 animations:^{
                            listNew.alpha = 1;
                        }];
                        break;
                    }
                }
                listNew.blockSelected = ^(NSInteger index) {
                    weakSelf.modelVehicleType.subString = weakSelf.aryCarType[index];
                    weakSelf.modelVehicleType.identifier = [NSString stringWithFormat:@"%@", weakSelf.aryCarID[index]];
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
        WEAKSELF
        _modelVehicleLoad = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"核定载质量";
            model.placeHolderString = @"选择核定载质量";
            model.isRequired = true;
            model.blocClick = ^(ModelBaseData *modelClick) {
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
        }()]];
        
    }
    return _bottomView;
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
            model.string = @"基本信息";
            return model;
        }();
        
    }
    return _modelUnbindDriver;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //转化车辆数据
    [self exchangeValue];
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
- (void)exchangeValue{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"CarType" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:strPath];
    // 对数据进行JSON格式化并返回字典形式
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray * aryLabel = [NSMutableArray new];
    NSMutableArray * aryID = [NSMutableArray new];
    for (NSDictionary * dic in ary) {
        int status = [dic doubleValueForKey:@"status"];
        if (status != 0) {
            [aryLabel addObject:[dic stringValueForKey:@"label"]];
            [aryID addObject:[dic numberValueForKey:@"value"]];
        }
    }
    self.aryCarType = aryLabel;
    self.aryCarID = aryID;
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
    self.aryDatas = @[self.modelUnbindDriver,self.modelCarNum,self.modelVehicleLoad,self.modelOwner,self.modelVehicleType,^(){
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
            }()].mutableCopy;
            [GB_Nav pushViewController:vc animated:true];
        };
        return model;
    }()].mutableCopy;
    [self.tableView reloadData];
    
}
- (void)configHeaderView:(NSString *)reason{
    [self.viewHeaderFailure removeAllSubViews];
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    l.textColor = [UIColor whiteColor];
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(3);
    [l fitTitle:[NSString stringWithFormat:@"%@",UnPackStr(reason)] variable:SCREEN_WIDTH - W(30)];
    l.leftTop = XY(W(15), W(10));
    [self.viewHeaderFailure addSubview:l];
    self.viewHeaderFailure.height = l.bottom + l.top;
    self.tableView.tableHeaderView = self.modelDetail.qualificationState == 10?self.viewHeaderFailure:nil;
    
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
    [GlobalMethod endEditing];
    ModelImage * model0 = [self.bottomView.aryDatas objectAtIndex:0];
    ModelImage * model1 = [self.bottomView.aryDatas objectAtIndex:1];
    if (!isStr(model0.image.imageURL)) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model0.desc]];
        return;
    }
    if (!isStr(model1.image.imageURL)) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model1.desc]];
        return;
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
    [RequestApi requestAddCarWithVin:nil
                        engineNumber:nil
                       vehicleNumber:self.modelCarNum.subString
                         licenceType:0
                       trailerNumber:nil
                      vehicleLicense:nil
                       vehicleLength:0
                         vehicleType:self.modelVehicleType.identifier.doubleValue
                         vehicleLoad:self.modelVehicleLoad.subString.doubleValue
                                axle:0
                        vehicleOwner:self.modelOwner.subString
              drivingLicenseFrontUrl:UnPackStr(model0.image.imageURL)
           drivingLicenseNegativeUrl:UnPackStr(model1.image.imageURL)
                 vehicleInsuranceUrl:nil       vehicleTripartiteInsuranceUrl:nil
                 trailerInsuranceUrl:nil
       trailerTripartiteInsuranceUrl:nil
            trailerGoodsInsuranceUrl:nil
                     vehiclePhotoUrl:nil
                managementLicenseUrl:nil
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
       if (!isStr(model0.image.imageURL)) {
           [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model0.desc]];
           return;
       }
       if (!isStr(model1.image.imageURL)) {
           [GlobalMethod showAlert:[NSString stringWithFormat:@"请添加%@",model1.desc]];
           return;
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
    [RequestApi requestResubmitCarWithVin:nil
                             engineNumber:nil
                            vehicleNumber:self.modelCarNum.subString
                              licenceType:1
                            trailerNumber:nil
                           vehicleLicense:nil
                            vehicleLength:0
                              vehicleType:self.modelVehicleType.identifier.doubleValue
                              vehicleLoad:self.modelVehicleLoad.subString.doubleValue
                                     axle:0
                                       id:self.carID
                             vehicleOwner:self.modelOwner.subString
                   drivingLicenseFrontUrl:UnPackStr(model0.image.imageURL)
                drivingLicenseNegativeUrl:UnPackStr(model1.image.imageURL)
                      vehicleInsuranceUrl:nil            vehicleTripartiteInsuranceUrl:nil
                      trailerInsuranceUrl:nil            trailerTripartiteInsuranceUrl:nil                 trailerGoodsInsuranceUrl:nil                          vehiclePhotoUrl:nil                     managementLicenseUrl:nil                                 delegate:self success:^(NSDictionary * _Nonnull response, id _Nonnull mark) {
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
        if (self.modelDetail.qualificationState == 10) {
            [self requestAuditRecord];
        }
        
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
        }()]];
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
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"CarType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
       NSMutableArray * aryDateTypes = [NSMutableArray new];
       NSMutableArray * aryDateId = [NSMutableArray new];
       for (NSDictionary * dic in ary) {
           [aryDateTypes addObject:[dic stringValueForKey:@"label"]];
           [aryDateId addObject:[dic numberValueForKey:@"value"]];
       }
  
    for (int i = 0; i<aryDateId.count; i++) {
        NSNumber * num = aryDateId[i];
        if (num.doubleValue == identity.doubleValue) {
            return aryDateTypes[i];
        }
    }
    return nil;
}
@end
