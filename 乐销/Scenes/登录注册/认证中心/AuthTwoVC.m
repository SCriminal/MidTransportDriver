//
//  AuthTwoVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthTwoVC.h"
#import "AuthView.h"
#import "BaseTableVC+Authority.h"
//request
#import "RequestDriver2.h"
#import "BaseVC+BaseImageSelectVC.h"
#import "AuthThreeVC.h"
#import "SelectCarTypeVC.h"
#import "CarHelper.h"

@interface AuthTwoVC ()
@property (nonatomic, strong) AuthView *authTopView;
@property (nonatomic, strong) AuthTitleView *authTitleView;
@property (nonatomic, strong) AuthBtnView *authBtnView;
@property (nonatomic, strong) ModelBaseData *modelMain;
@property (nonatomic, strong) ModelBaseData *modelSub;
@property (nonatomic, strong) ModelBaseData *modelThree;
@property (nonatomic, strong) ModelBaseData *modelCarNo;
@property (nonatomic, strong) ModelBaseData *modelCarType;
@property (nonatomic, strong) ModelBaseData *modelCarOwner;
@property (nonatomic, strong) ModelBaseData *modelVin;
//@property (nonatomic, strong) ModelBaseData *modelCarLong;
//@property (nonatomic, strong) ModelBaseData *modelCarWidth;
//@property (nonatomic, strong) ModelBaseData *modelCarHeight;
@property (nonatomic, strong) ModelBaseData *modelImageSelected;
@property (nonatomic, strong) ModelOCR *modelOCRDribingFace;
@property (nonatomic, strong) ModelOCR *modelOCRDrivingBack;
@property (nonatomic, strong) NSArray *aryCarType;


@end

@implementation AuthTwoVC
- (AuthView *)authTopView{
    if (!_authTopView) {
        _authTopView = [AuthView new];
        [_authTopView resetViewWithModel:1];
    }
    return _authTopView;
}
- (AuthTitleView *)authTitleView{
    if (!_authTitleView) {
        _authTitleView = [AuthTitleView new];
        [_authTitleView resetViewWithModel:@"请按要求上传拍摄清晰的证件照，系统将自动识别"];
    }
    return _authTitleView;
}
- (AuthBtnView *)authBtnView{
    if (!_authBtnView) {
        _authBtnView = [AuthBtnView new];
        [_authBtnView resetViewWithModel:self.isFirst];
        WEAKSELF
        _authBtnView.blockDismissClick = ^{
            [weakSelf saveAllProperty];
            [GB_Nav popToRootViewControllerAnimated:true];

        };
        _authBtnView.blockConfirmClick  = ^{
            [weakSelf requestUP];
        };
    }
    return _authBtnView;
}
- (ModelBaseData *)modelMain{
    if (!_modelMain) {
        _modelMain =[ModelBaseData new];
        _modelMain.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelMain.string = @"行驶证主页";
//        _modelMain.subString = self.model.bankName;
        _modelMain.placeHolderString = @"点击上传";
        WEAKSELF
        _modelMain.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1 cameraType:ENUM_CAMERA_ROAD];

        };
    }
    return _modelMain;
}
- (ModelBaseData *)modelSub{
    if (!_modelSub) {
        _modelSub =[ModelBaseData new];
        _modelSub.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelSub.string = @"行驶证副页";
//        _modelSub.subString = self.model.bankName;
        _modelSub.placeHolderString = @"点击上传";
        WEAKSELF
        _modelSub.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];

        };
    }
    return _modelSub;
}
- (ModelBaseData *)modelThree{
    if (!_modelThree) {
        _modelThree =[ModelBaseData new];
        _modelThree.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelThree.string = @"行驶证检验页";
//        _modelThree.subString = self.model.bankName;
        _modelThree.placeHolderString = @"点击上传";
        WEAKSELF
        _modelThree.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];

        };
    }
    return _modelThree;
}
- (ModelBaseData *)modelCarNo{
    if (!_modelCarNo) {
        _modelCarNo =[ModelBaseData new];
        _modelCarNo.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelCarNo.string = @"车牌号码";
        _modelCarNo.isChangeInvalid = false;
//        _modelCarNo.subString = self.model.idNumber;
        _modelCarNo.placeHolderString = @"填写车牌号码";
      
    }
    return _modelCarNo;
}
- (ModelBaseData *)modelCarType{
    if (!_modelCarType) {
        _modelCarType =[ModelBaseData new];
        _modelCarType.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelCarType.string = @"车辆类型";
//        _modelCarType.subString = self.model.bankName;
        _modelCarType.placeHolderString = @"选择车辆类型";
        WEAKSELF
        _modelCarType.blocClick = ^(ModelBaseData *model) {
            [GlobalMethod endEditing];
            SelectCarTypeVC * selectVC = [SelectCarTypeVC new];
            selectVC.blockSelected = ^(NSString *type, NSNumber *idNumber) {
                weakSelf.modelCarType.subString = type;
                weakSelf.modelCarType.identifier = idNumber.stringValue;
                [weakSelf.tableView reloadData];
            };
            [GB_Nav pushViewController:selectVC animated:true];
        };
    }
    return _modelCarType;
}
- (ModelBaseData *)modelCarOwner{
    if (!_modelCarOwner) {
        _modelCarOwner =[ModelBaseData new];
        _modelCarOwner.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelCarOwner.string = @"车辆所有人";
        _modelCarOwner.isChangeInvalid = false;
//        _modelCarOwner.subString = self.model.idNumber;
        _modelCarOwner.placeHolderString = @"填写车辆所有人";
      
    }
    return _modelCarOwner;
}

- (ModelBaseData *)modelVin{
    if (!_modelVin) {
        _modelVin =[ModelBaseData new];
        _modelVin.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelVin.string = @"车架号";
        _modelVin.isChangeInvalid = false;
//        _modelVin.subString = self.model.idNumber;
        _modelVin.placeHolderString = @"填写车架号(VIN)";
      
    }
    return _modelVin;
}
//- (ModelBaseData *)modelCarLong{
//    if (!_modelCarLong) {
//        _modelCarLong =[ModelBaseData new];
//        _modelCarLong.enumType = ENUM_PERFECT_CELL_TEXT;
//        _modelCarLong.string = @"车辆长度";
//        _modelCarLong.isChangeInvalid = false;
////        _modelCarLong.subString = self.model.idNumber;
//        _modelCarLong.placeHolderString = @"填写车辆长度（mm）";
//
//    }
//    return _modelCarLong;
//}
//- (ModelBaseData *)modelCarWidth{
//    if (!_modelCarWidth) {
//        _modelCarWidth =[ModelBaseData new];
//        _modelCarWidth.enumType = ENUM_PERFECT_CELL_TEXT;
//        _modelCarWidth.string = @"车辆宽度";
//        _modelCarWidth.isChangeInvalid = false;
////        _modelCarWidth.subString = self.model.idNumber;
//        _modelCarWidth.placeHolderString = @"填写车辆宽度（mm）";
//
//    }
//    return _modelCarWidth;
//}
//- (ModelBaseData *)modelCarHeight{
//    if (!_modelCarHeight) {
//        _modelCarHeight =[ModelBaseData new];
//        _modelCarHeight.enumType = ENUM_PERFECT_CELL_TEXT;
//        _modelCarHeight.string = @"车辆高度";
//        _modelCarHeight.isChangeInvalid = false;
////        _modelCarHeight.subString = self.model.idNumber;
//        _modelCarHeight.placeHolderString = @"填写车辆高度（mm）";
//
//    }
//    return _modelCarHeight;
//}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.isFirst?self.authTopView:[NSNull null],self.authTitleView]];
    self.tableView.tableFooterView = [UIView initWithViews:@[self.authBtnView]];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    [self registAuthorityCell];
    [self addObserveOfKeyboard];
    //request
    self.aryDatas = @[self.modelMain,self.modelSub,self.modelThree,self.modelCarNo,self.modelCarType,self.modelCarOwner,self.modelVin].mutableCopy;
    [self fetchAllProperty];
    self.aryDatas = @[self.modelMain,self.modelSub,self.modelThree,self.modelCarNo,self.modelCarType,self.modelCarOwner,self.modelVin].mutableCopy;

    for (ModelBaseData *m in self.aryDatas) {
        m.subLeft = W(120);
    }
    [self.tableView reloadData];
    [self requestCarType];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"认证中心" rightView:nil];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCell:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self fetchAuthorityCellHeight:indexPath];
}
#pragma mark request
- (void)requestList{
   
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)imageSelect:(BaseImage *)image{
    [self showLoadingView];

    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
       
    } upSuccess:nil upHighQualitySuccess:^{
        [self.loadingView hideLoading];
        self.modelImageSelected.identifier = image.imageURL;
        [self.tableView reloadData];

        if (self.modelImageSelected == self.modelMain) {
            [RequestApi requestOCRDrivingWithurl:image.imageURL side:@"face" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"faceResult"]];
                self.modelOCRDribingFace = model;
                if (isStr(model.plateNumber)) {
                    self.modelCarNo.subString = model.plateNumber;
                }
                if (isStr(model.vehicleType)) {
                    NSNumber * typeID = [CarHelper exchangeVehicleTypeWithName:model.vehicleType];
                    if (typeID) {
                        self.modelCarType.subString = model.vehicleType;
                        self.modelCarType.identifier = typeID.stringValue;
                    }
                }
                if (isStr(model.owner)) {
                    self.modelCarOwner.subString = model.owner;
                }
                if (isStr(model.vin)) {
                    self.modelVin.subString = model.vin;
                }
                [self.tableView reloadData];
                        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                            
                        }];
        }
        if (self.modelImageSelected == self.modelSub) {
            [RequestApi requestOCRDrivingWithurl:image.imageURL side:@"back" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"backResult"]];
                
                self.modelOCRDrivingBack = model;
              
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
         
        }
        
    } fail:^{
        [self.loadingView hideLoading];

    }];
    
}
#pragma mark request
- (void)requestUP{
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
        if (model.enumType == ENUM_PERFECT_CELL_SELECT_LOGO) {
            if (!isStr(model.identifier)) {
                [GlobalMethod showAlert:[NSString stringWithFormat:@"请上传%@",model.string]];
                return;
            }
        }
    }
    [self saveAllProperty];
    [RequestApi requestCarAuthCheckWithPlateNumber:self.modelCarNo.subString vin:self.modelVin.subString owner:self.modelCarOwner.subString vehicleType:self.modelCarType.identifier.doubleValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
        if (self.isFirst) {
            AuthThreeVC * vc = [AuthThreeVC new];
            vc.isFirst = self.isFirst;
            vc.grossMass = self.modelOCRDrivingBack.grossMass.doubleValue;
            [GB_Nav pushViewController:vc animated:true];
        }else{
            [RequestApi requestAuthCarWithPlatenumber:self.modelCarNo.subString
                                          vehicleType:self.modelCarType.identifier.doubleValue
                                                owner:self.modelCarOwner.subString
                                            grossMass:self.modelOCRDrivingBack.grossMass.doubleValue
                                         approvedLoad:self.modelOCRDrivingBack.approvedLoad.doubleValue
                                        vehicleLength:self.modelOCRDrivingBack.length
                                         vehicleWidth:self.modelOCRDrivingBack.width
                                        vehicleHeight:self.modelOCRDrivingBack.height
                                          driving1Url:self.modelMain.identifier
                                          driving2Url:self.modelSub.identifier
                                          driving3Url:self.modelThree.identifier
                                           plateColor:0
                                           energyType:isStr(self.modelOCRDrivingBack.energyType)?[CarHelper exchangeEnergeyTypeWithName:self.modelOCRDrivingBack.energyType].doubleValue:0
                                         tractionMass:self.modelOCRDrivingBack.tractionMass.doubleValue
                                       drivingEndTime:0
                                         useCharacter:nil
                                          unladenMass:0
                                                  vin:self.modelVin.subString
                                  drivingRegisterDate:self.modelOCRDribingFace.registerDateStamp
                                         engineNumber:nil
                                     drivingIssueDate:self.modelOCRDribingFace.issueDateStamp
                                                model:nil
                                           rtbpNumber:nil
                                            isRequest:true delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [GlobalMethod showAlert:@"上传成功"];
                [GB_Nav popViewControllerAnimated:true];

            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

            }];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (NSString *)fetchRequestJson{
   NSDictionary * dic = [RequestApi requestAuthCarWithPlatenumber:self.modelCarNo.subString
                                                           vehicleType:self.modelCarType.identifier.doubleValue
                                                                 owner:self.modelCarOwner.subString
                                                             grossMass:self.modelOCRDrivingBack.grossMass.doubleValue
                                                          approvedLoad:self.modelOCRDrivingBack.approvedLoad.doubleValue
                                                         vehicleLength:self.modelOCRDrivingBack.length
                                                          vehicleWidth:self.modelOCRDrivingBack.width
                                                         vehicleHeight:self.modelOCRDrivingBack.height
                                                           driving1Url:self.modelMain.identifier
                                                           driving2Url:self.modelSub.identifier
                                                           driving3Url:self.modelThree.identifier
                                                            plateColor:0
                                                            energyType:isStr(self.modelOCRDrivingBack.energyType)?[CarHelper exchangeEnergeyTypeWithName:self.modelOCRDrivingBack.energyType].doubleValue:0
                                                          tractionMass:self.modelOCRDrivingBack.tractionMass.doubleValue
                                                        drivingEndTime:0
                                                          useCharacter:nil
                                                           unladenMass:0
                                                                   vin:self.modelVin.subString
                                                   drivingRegisterDate:self.modelOCRDribingFace.registerDateStamp
                                                          engineNumber:nil
                                                      drivingIssueDate:self.modelOCRDribingFace.issueDateStamp
                                                                 model:nil
                                                            rtbpNumber:nil
                                                             isRequest:false delegate:self success:nil failure:nil];
    return [GlobalMethod exchangeDicToJson:dic];
}

- (void)requestDetail{
    [RequestApi requestCarAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthCar * model = [ModelAuthCar modelObjectWithDictionary:response];

        if (model.reviewStatus <= 1) {
            return;
        }
        self.modelOCRDrivingBack = [ModelOCR new];
        self.modelOCRDrivingBack.approvedLoad = NSNumber.dou(model.approvedLoad).stringValue;
        self.modelOCRDrivingBack.energyType = NSNumber.dou(model.energyType).stringValue;
        self.modelOCRDrivingBack.grossMass = NSNumber.dou(model.grossMass).stringValue;
        self.modelCarOwner.subString = model.owner;
        self.modelCarNo.subString = model.plateNumber;
        self.modelOCRDrivingBack.tractionMass = NSNumber.dou(model.tractionMass).stringValue;
        self.modelOCRDrivingBack.height = model.vehicleHeight;
        self.modelOCRDrivingBack.length = model.vehicleLength;
        self.modelCarType.identifier = NSNumber.dou(model.vehicleType).stringValue;
        
        self.modelCarType.subString = model.vehicleType?[CarHelper exchangeVehicleType:self.modelCarType.identifier]:nil;
        self.modelOCRDrivingBack.width = model.vehicleWidth;
        self.modelMain.identifier = model.driving1Url;
        self.modelSub.identifier = model.driving2Url;
        self.modelThree.identifier = model.driving3Url;
        self.modelVin.subString = model.vin;
        
        if (model.reviewStatus == 2 || model.reviewStatus == 10) {
            for (ModelBaseData * m in self.aryDatas) {
                m.isChangeInvalid = true;
            }
            self.authBtnView.hidden = true;
            self.tableView.tableHeaderView = [UIView initWithViews:@[self.isFirst?self.authTopView:[NSNull null]]];

        }
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestCarType{
    NSArray * ary = [GlobalMethod readAry:LOCAL_CAR_TYPE modelName:@"ModelIntegralProduct"];
    if (ary.count) {
        [self requestDetail];
        return;
    }
    [RequestApi requestCarTypeDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelIntegralProduct"];
        [GlobalMethod writeAry:ary key:LOCAL_CAR_TYPE];
        [self requestDetail];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            [self requestDetail];
        }];
}
@end
