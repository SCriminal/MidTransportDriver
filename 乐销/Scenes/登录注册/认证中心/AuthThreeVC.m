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
@interface AuthThreeVC ()
@property (nonatomic, strong) AuthView *authTopView;
@property (nonatomic, strong) AuthTitleView *authTitleView;
@property (nonatomic, strong) AuthBtnView *authBtnView;
@property (nonatomic, strong) ModelBaseData *modelLoad;
@property (nonatomic, strong) ModelBaseData *modelBusiness;

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
        _authBtnView.blockDismissClick = ^{
            
        };
        _authBtnView.blockConfirmClick  = ^{
            
        };
    }
    return _authBtnView;
}
- (ModelBaseData *)modelLoad{
    if (!_modelLoad) {
        _modelLoad =[ModelBaseData new];
        _modelLoad.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelLoad.string = @"道路运输许可证";
//        _modelLoad.subString = self.model.bankName;
        _modelLoad.placeHolderString = @"点击上传";
        WEAKSELF
        _modelLoad.blocClick = ^(ModelBaseData *model) {
        };
    }
    return _modelLoad;
}
- (ModelBaseData *)modelBusiness{
    if (!_modelBusiness) {
        _modelBusiness =[ModelBaseData new];
        _modelBusiness.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelBusiness.string = @"从业资格证";
//        _modelBusiness.subString = self.model.bankName;
        _modelBusiness.placeHolderString = @"点击上传";
        WEAKSELF
        _modelBusiness.blocClick = ^(ModelBaseData *model) {
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
    self.aryDatas = @[self.modelLoad,self.modelBusiness,].mutableCopy;
    for (ModelBaseData *m in self.aryDatas) {
        m.subLeft = W(135);
    }
    [self.tableView reloadData];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
