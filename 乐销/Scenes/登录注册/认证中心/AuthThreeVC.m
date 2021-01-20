//
//  AuthThreeVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthThreeVC.h"
#import "AuthView.h"
#import "BaseTableVC+Authority.h"
//request
#import "RequestDriver2.h"
#import "BaseVC+BaseImageSelectVC.h"
#import "AuthOneVC.h"
#import "AuthTwoVC.h"

@interface AuthThreeVC ()
@property (nonatomic, strong) AuthView *authTopView;
@property (nonatomic, strong) AuthTitleView *authTitleView;
@property (nonatomic, strong) AuthBtnView *authBtnView;
@property (nonatomic, strong) ModelBaseData *modelLoad;
@property (nonatomic, strong) ModelBaseData *modelBusiness;
@property (nonatomic, strong) ModelBaseData *modelImageSelected;
@property (nonatomic, strong) ModelAuthCar *modelAuthCar;

//@property (nonatomic, strong) ModelOCR *modelOCRLoad;
//@property (nonatomic, strong) ModelOCR *modelOCRBusiness;

@end

@implementation AuthThreeVC
- (AuthView *)authTopView{
    if (!_authTopView) {
        _authTopView = [AuthView new];
        [_authTopView resetViewWithModel:2];
    }
    return _authTopView;
}
- (AuthTitleView *)authTitleView{
    if (!_authTitleView) {
        _authTitleView = [AuthTitleView new];
        [_authTitleView resetViewWithModel:nil];
    }
    return _authTitleView;
}
- (AuthBtnView *)authBtnView{
    if (!_authBtnView) {
        _authBtnView = [AuthBtnView new];
        [_authBtnView resetViewWithModel:false];
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
- (ModelBaseData *)modelLoad{
    if (!_modelLoad) {
        _modelLoad =[ModelBaseData new];
        _modelLoad.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelLoad.string = @"道路运输许可证";
//        _modelLoad.subString = self.model.bankName;
        _modelLoad.placeHolderString = @"点击上传";
        WEAKSELF
        _modelLoad.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];

        };
    }
    return _modelLoad;
}
- (ModelBaseData *)modelBusiness{
    if (!_modelBusiness) {
        _modelBusiness =[ModelBaseData new];
        _modelBusiness.enumType = ENUM_PERFECT_CELL_SELECT_LOGO;
        _modelBusiness.string = @"从业资格证";
//        _modelBusiness.subString = self.model.bankName;
        _modelBusiness.placeHolderString = @"点击上传";
        WEAKSELF
        _modelBusiness.blocClick = ^(ModelBaseData *model) {
            weakSelf.modelImageSelected = model;
            [weakSelf showImageVC:1];

        };
    }
    return _modelBusiness;
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
    self.aryDatas = @[self.modelLoad,self.modelBusiness,].mutableCopy;
    [self fetchAllProperty];
    self.aryDatas = @[self.modelLoad,self.modelBusiness,].mutableCopy;
    for (ModelBaseData *m in self.aryDatas) {
        m.subLeft = W(135);
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

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark request
- (void)requestUP{
    [GlobalMethod endEditing];
    BOOL needAuth = true;
    if (self.isFirst) {
        if (self.grossMass > 4500) {
            needAuth = false;
        }
    }else{
        if (self.modelAuthCar.grossMass>4500) {
            needAuth = false;
        }
    }
    if (needAuth) {
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
    }
    [self saveAllProperty];
    if (self.isFirst) {
        NSString * jsonOne = nil;
        NSString * jsonTwo = nil;
        NSString * jsonThree = nil;
        for (UIViewController * vc in GB_Nav.viewControllers) {
            if ([vc isKindOfClass:NSClassFromString(@"AuthOneVC")]) {
                jsonOne = [(AuthOneVC *)vc fetchRequestJson];
            }
            if ([vc isKindOfClass:NSClassFromString(@"AuthTwoVC")]) {
                jsonTwo = [(AuthTwoVC *)vc fetchRequestJson];
            }
            if ([vc isKindOfClass:NSClassFromString(@"AuthThreeVC")]) {
                jsonThree = [(AuthThreeVC *)vc fetchRequestJson];
            }
        }
        [RequestApi requestAuthUpAllWithDriverjson:jsonOne serviceJson:jsonThree vehicleJson:jsonTwo delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"提交成功"];
            [GB_Nav popToRootViewControllerAnimated:true];
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
        
    }else{
        [RequestApi requestAuthBusinessWithQualificationurl:self.modelBusiness.identifier roadUrl:self.modelLoad.identifier qualificationNumber:nil roadNumber:nil qcAddr:nil qcIssueDate:nil qcAgency:nil qcNationality:nil qcCategory:nil qcName:nil qcDriverClass:nil qcGender:nil qcBirthday:nil rtpWord:nil rtbpNumber:nil qcEndDate:0 rtpEndDate:0 isRequest:true delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"上传成功"];
            [GB_Nav popViewControllerAnimated:true];

                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
    }
   
}
- (NSString *)fetchRequestJson{
   NSDictionary * dic =     [RequestApi requestAuthBusinessWithQualificationurl:self.modelBusiness.identifier roadUrl:self.modelLoad.identifier qualificationNumber:nil roadNumber:nil qcAddr:nil qcIssueDate:nil qcAgency:nil qcNationality:nil qcCategory:nil qcName:nil qcDriverClass:nil qcGender:nil qcBirthday:nil rtpWord:nil rtbpNumber:nil qcEndDate:0 rtpEndDate:0 isRequest:false delegate:nil success:nil failure:nil];
    return [GlobalMethod exchangeDicToJson:dic];
}
- (void)requestDetail{
    [RequestApi requestCarAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelAuthCar = [ModelAuthCar modelObjectWithDictionary:response];
        [RequestApi requestBusinessAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelAuthBusiness * model = [ModelAuthBusiness modelObjectWithDictionary:response];
            self.modelLoad.identifier = model.roadUrl;
            self.modelBusiness.identifier = model.qualificationUrl;
            if (model.reviewStatus == 2 || model.reviewStatus == 10) {
                for (ModelBaseData * m in self.aryDatas) {
                    m.isChangeInvalid = true;
                }
                self.authBtnView.hidden = true;
            }
            [self.tableView reloadData];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
  
}
- (void)imageSelect:(BaseImage *)image{
    [self showLoadingView];

    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
       
    } upSuccess:nil upHighQualitySuccess:^{
        [self.loadingView hideLoading];
        self.modelImageSelected.identifier = image.imageURL;
        [self.tableView reloadData];
        if (self.modelImageSelected == self.modelBusiness) {
//            [RequestApi requestOCRBusinessWithurl:image.imageURL side:@"face" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"backResult"]];
//
//                self.modelOCRBusiness = model;
//
//            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//            }];
         
        }
        
    } fail:^{
        
    }];
    
}

@end
