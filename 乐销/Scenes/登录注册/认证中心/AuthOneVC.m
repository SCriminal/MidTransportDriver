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
@interface AuthOneVC ()
@property (nonatomic, strong) AuthView *authTopView;
@property (nonatomic, strong) AuthTitleView *authTitleView;
@property (nonatomic, strong) AuthBtnView *authBtnView;
@property (nonatomic, strong) ModelBaseData *modelHead;
@property (nonatomic, strong) ModelBaseData *modelCountry;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelId;
@property (nonatomic, strong) ModelBaseData *modelDriver;
@property (nonatomic, strong) ModelBaseData *modelCar;

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
        _authBtnView.blockDismissClick = ^{
            
        };
        _authBtnView.blockConfirmClick  = ^{
            
        };
    }
    return _authBtnView;
}
- (ModelBaseData *)modelHead{
    if (!_modelHead) {
        _modelHead =[ModelBaseData new];
        _modelHead.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelHead.string = @"身份证人像面";
//        _modelHead.subString = self.model.bankName;
        _modelHead.placeHolderString = @"点击上传";
        WEAKSELF
        _modelHead.blocClick = ^(ModelBaseData *model) {
        };
    }
    return _modelHead;
}
- (ModelBaseData *)modelCountry{
    if (!_modelCountry) {
        _modelCountry =[ModelBaseData new];
        _modelCountry.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelCountry.string = @"身份证国徽面";
//        _modelCountry.subString = self.model.bankName;
        _modelCountry.placeHolderString = @"点击上传";
        WEAKSELF
        _modelCountry.blocClick = ^(ModelBaseData *model) {
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
        _modelDriver.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelDriver.string = @"驾驶证照片";
//        _modelDriver.subString = self.model.bankName;
        _modelDriver.placeHolderString = @"点击上传";
        WEAKSELF
        _modelDriver.blocClick = ^(ModelBaseData *model) {
        };
    }
    return _modelDriver;
}
- (ModelBaseData *)modelCar{
    if (!_modelCar) {
        _modelCar =[ModelBaseData new];
        _modelCar.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelCar.string = @"人车合照";
//        _modelCar.subString = self.model.bankName;
        _modelCar.placeHolderString = @"点击上传";
        _modelCar.hideState = true;
        WEAKSELF
        _modelCar.blocClick = ^(ModelBaseData *model) {
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
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.authTopView,self.authTitleView]];
    self.tableView.tableFooterView = [UIView initWithViews:@[self.authBtnView]];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    [self registAuthorityCell];
    [self addObserveOfKeyboard];

    //request
    [self requestList];
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
    self.aryDatas = @[self.modelCountry,self.modelHead,self.modelName,self.modelId,self.modelDriver,self.modelCar].mutableCopy;
    for (ModelBaseData *m in self.aryDatas) {
        m.subLeft = W(120);
    }
    [self.tableView reloadData];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
