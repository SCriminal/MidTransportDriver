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

@interface AuthThreeVC ()
@property (nonatomic, strong) AuthView *authTopView;
@property (nonatomic, strong) AuthTitleView *authTitleView;
@property (nonatomic, strong) AuthBtnView *authBtnView;
@property (nonatomic, strong) ModelBaseData *modelLoad;
@property (nonatomic, strong) ModelBaseData *modelBusiness;
@property (nonatomic, strong) ModelBaseData *modelImageSelected;

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
        [_authBtnView resetViewWithModel:self.isFirst];
WEAKSELF
        _authBtnView.blockDismissClick = ^{
            
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
        _modelLoad.enumType = ENUM_PERFECT_CELL_SELECT;
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
        _modelBusiness.enumType = ENUM_PERFECT_CELL_SELECT;
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
#pragma mark request
- (void)requestUP{
    if (self.isFirst) {
       
        
    }else{

    }
   
}
- (void)requestDetail{
    [RequestApi requestDriverAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            
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

//        if (self.modelImageSelected == self.modelHead) {
//            [RequestApi requestOCRIdentityWithurl:image.imageURL delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"frontResult"]];
//                if (isStr(model.name)) {
//                    self.modelName.subString = model.name;
//                }
//                if (isStr(model.iDNumber)) {
//                    self.modelId.subString = model.iDNumber;
//                }
//                [self.tableView reloadData];
//            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//            }];
//        }
        
    } fail:^{
        
    }];
    
}

@end
