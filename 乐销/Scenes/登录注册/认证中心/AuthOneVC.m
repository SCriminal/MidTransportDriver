//
//  AuthOneVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthOneVC.h"
#import "AuthView.h"
#import "BaseTableVC+Authority.h"
#import "AliClient.h"
#import "OrcHelper.h"
#import "AuthTwoVC.h"
//request
#import "RequestDriver2.h"
#import "BaseVC+BaseImageSelectVC.h"

@interface AuthOneVC ()<NSURLSessionDelegate>
@property (nonatomic, strong) AuthView *authTopView;
@property (nonatomic, strong) AuthTitleView *authTitleView;
@property (nonatomic, strong) AuthBtnView *authBtnView;
@property (nonatomic, strong) ModelBaseData *modelHead;
@property (nonatomic, strong) ModelBaseData *modelCountry;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelId;
@property (nonatomic, strong) ModelBaseData *modelDriver;
@property (nonatomic, strong) ModelBaseData *modelCar;
@property (nonatomic, strong) ModelBaseData *modelImageSelected;
@property (nonatomic, strong) ModelOCR *modelOCRDriverFace;
@property (nonatomic, strong) ModelOCR *modelOCRDriverBack;

@end

@implementation AuthOneVC
- (AuthView *)authTopView{
    if (!_authTopView) {
        _authTopView = [AuthView new];
        [_authTopView resetViewWithModel:0];
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
            NSLog(@"save %@",weakSelf.modelHead.identifier);
            [weakSelf saveAllProperty];
        };
        _authBtnView.blockConfirmClick  = ^{
            [weakSelf requestUP];
        };
    }
    return _authBtnView;
}
- (ModelBaseData *)modelHead{
    if (!_modelHead) {
        _modelHead =[ModelBaseData new];
        _modelHead.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelHead.string = @"身份证人像面";
        _modelHead.placeHolderString = @"点击上传";
        WEAKSELF
        _modelHead.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];
        };
    }
    return _modelHead;
}
- (ModelBaseData *)modelCountry{
    if (!_modelCountry) {
        _modelCountry =[ModelBaseData new];
        _modelCountry.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelCountry.string = @"身份证国徽面";
        //        _modelCountry.subString = self.model.bankName;
        _modelCountry.placeHolderString = @"点击上传";
        WEAKSELF
        _modelCountry.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];
        };
    }
    return _modelCountry;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName =[ModelBaseData new];
        _modelName.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelName.string = @"姓名";
        _modelName.isChangeInvalid = false;
        //        _modelName.subString = self.model.idNumber;
        _modelName.placeHolderString = @"填写真实姓名";
        
    }
    return _modelName;
}

- (ModelBaseData *)modelId{
    if (!_modelId) {
        _modelId =[ModelBaseData new];
        _modelId.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelId.string = @"身份证号";
        _modelId.isChangeInvalid = false;
        //        _modelId.subString = self.model.idNumber;
        _modelId.placeHolderString = @"填写身份证号";
        
    }
    return _modelId;
}
- (ModelBaseData *)modelDriver{
    if (!_modelDriver) {
        _modelDriver =[ModelBaseData new];
        _modelDriver.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelDriver.string = @"驾驶证照片";
        //        _modelDriver.subString = self.model.bankName;
        _modelDriver.placeHolderString = @"点击上传";
        WEAKSELF
        _modelDriver.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];
        };
    }
    return _modelDriver;
}
- (ModelBaseData *)modelCar{
    if (!_modelCar) {
        _modelCar =[ModelBaseData new];
        _modelCar.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelCar.string = @"人车合照";
        //        _modelCar.subString = self.model.bankName;
        _modelCar.placeHolderString = @"点击上传";
        _modelCar.hideState = true;
        WEAKSELF
        _modelCar.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];
        };
    }
    return _modelCar;
}
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
    self.aryDatas = @[self.modelCountry,self.modelHead,self.modelName,self.modelId,self.modelDriver,self.modelCar].mutableCopy;
    [self fetchAllProperty];
    self.aryDatas = @[self.modelCountry,self.modelHead,self.modelName,self.modelId,self.modelDriver,self.modelCar].mutableCopy;
    for (ModelBaseData *m in self.aryDatas) {
        m.subLeft = W(120);
    }
    [self.tableView reloadData];
    [self requestDetail];
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
- (void)requestUP{
    if (self.isFirst) {
        AuthTwoVC * vc = [AuthTwoVC new];
        vc.isFirst = self.isFirst;
        [GB_Nav pushViewController:vc animated:true];
    }else{
        [RequestApi requestAuthDriverWithIdcardnationalemblemurl:self.modelCountry.identifier idFaceUrl:self.modelHead.identifier driverUrl:self.modelDriver.identifier vehicleUrl:self.modelCar.identifier name:self.modelName.subString idNumber:self.modelId.subString idBirthday:nil idGender:nil idNation:nil idOrg:nil idAddr:nil driverNationality:nil driverGender:nil driverBirthday:nil driverClass:nil driverArchivesNumber:nil driverFirstIssueDate:nil delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"上传成功"];
            [GB_Nav popViewControllerAnimated:true];
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
    }
   
}
- (void)requestDetail{
    [RequestApi requestDriverAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)imageSelect:(BaseImage *)image{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        self.modelImageSelected.identifier = image.imageURL;
        [self.tableView reloadData];
    } upSuccess:nil upHighQualitySuccess:^{
        if (self.modelImageSelected == self.modelHead) {
            [RequestApi requestOCRIdentityWithurl:image.imageURL delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"frontResult"]];
                if (isStr(model.name)) {
                    self.modelName.subString = model.name;
                }
                if (isStr(model.iDNumber)) {
                    self.modelId.subString = model.iDNumber;
                }
                [self.tableView reloadData];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
        if (self.modelImageSelected == self.modelDriver) {
            [RequestApi requestOCRDriverWithurl:image.imageURL side:@"face" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"faceResult"]];
                
                self.modelOCRDriverFace = model;
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
    } fail:^{
        
    }];
    
}
@end
