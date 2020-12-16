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
@interface AuthTwoVC ()
@property (nonatomic, strong) AuthView *authTopView;
@property (nonatomic, strong) AuthTitleView *authTitleView;
@property (nonatomic, strong) AuthBtnView *authBtnView;
@property (nonatomic, strong) ModelBaseData *modelMain;
@property (nonatomic, strong) ModelBaseData *modelSub;
@property (nonatomic, strong) ModelBaseData *modelCarNo;
@property (nonatomic, strong) ModelBaseData *modelCarType;
@property (nonatomic, strong) ModelBaseData *modelCarOwner;
@property (nonatomic, strong) ModelBaseData *modelCarWeight;
@property (nonatomic, strong) ModelBaseData *modelCarLong;
@property (nonatomic, strong) ModelBaseData *modelCarWidth;
@property (nonatomic, strong) ModelBaseData *modelCarHeight;


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
        _authBtnView.blockDismissClick = ^{
            
        };
        _authBtnView.blockConfirmClick  = ^{
            
        };
    }
    return _authBtnView;
}
- (ModelBaseData *)modelMain{
    if (!_modelMain) {
        _modelMain =[ModelBaseData new];
        _modelMain.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelMain.string = @"行驶证主页";
//        _modelMain.subString = self.model.bankName;
        _modelMain.placeHolderString = @"点击上传";
        WEAKSELF
        _modelMain.blocClick = ^(ModelBaseData *model) {
        };
    }
    return _modelMain;
}
- (ModelBaseData *)modelSub{
    if (!_modelSub) {
        _modelSub =[ModelBaseData new];
        _modelSub.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelSub.string = @"行驶证副页";
//        _modelSub.subString = self.model.bankName;
        _modelSub.placeHolderString = @"点击上传";
        WEAKSELF
        _modelSub.blocClick = ^(ModelBaseData *model) {
        };
    }
    return _modelSub;
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

- (ModelBaseData *)modelCarWeight{
    if (!_modelCarWeight) {
        _modelCarWeight =[ModelBaseData new];
        _modelCarWeight.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelCarWeight.string = @"最大载重量";
        _modelCarWeight.isChangeInvalid = false;
//        _modelCarWeight.subString = self.model.idNumber;
        _modelCarWeight.placeHolderString = @"填写最大载重量（kg）";
      
    }
    return _modelCarWeight;
}
- (ModelBaseData *)modelCarLong{
    if (!_modelCarLong) {
        _modelCarLong =[ModelBaseData new];
        _modelCarLong.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelCarLong.string = @"车辆长度";
        _modelCarLong.isChangeInvalid = false;
//        _modelCarLong.subString = self.model.idNumber;
        _modelCarLong.placeHolderString = @"填写车辆长度（mm）";
      
    }
    return _modelCarLong;
}
- (ModelBaseData *)modelCarWidth{
    if (!_modelCarWidth) {
        _modelCarWidth =[ModelBaseData new];
        _modelCarWidth.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelCarWidth.string = @"车辆宽度";
        _modelCarWidth.isChangeInvalid = false;
//        _modelCarWidth.subString = self.model.idNumber;
        _modelCarWidth.placeHolderString = @"填写车辆宽度（mm）";
      
    }
    return _modelCarWidth;
}
- (ModelBaseData *)modelCarHeight{
    if (!_modelCarHeight) {
        _modelCarHeight =[ModelBaseData new];
        _modelCarHeight.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelCarHeight.string = @"车辆高度";
        _modelCarHeight.isChangeInvalid = false;
//        _modelCarHeight.subString = self.model.idNumber;
        _modelCarHeight.placeHolderString = @"填写车辆高度（mm）";
      
    }
    return _modelCarHeight;
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
    self.aryDatas = @[self.modelMain,self.modelSub,self.modelCarNo,self.modelCarType,self.modelCarOwner,self.modelCarWeight,self.modelCarLong,self.modelCarWidth,self.modelCarHeight].mutableCopy;
    for (ModelBaseData *m in self.aryDatas) {
        m.subLeft = W(120);
    }
    [self.tableView reloadData];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
