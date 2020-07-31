//
//  PerfectAuthorityInfoVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "PerfectAuthorityInfoVC.h"
//image select
#import "BaseVC+BaseImageSelectVC.h"
//up image
#import "AliClient.h"
//vc
#import "AuthortiyExampleVC.h"
//request
#import "RequestApi+UserApi.h"
#import "BaseTableVC+Authority.h"
#import "AuthorityImageView.h"
#import "RequestApi+Dictionary.h"

@interface PerfectAuthorityInfoVC ()
@property (nonatomic, strong) UIView *viewReason;
@property (nonatomic, strong) ModelBaseData *modelRealName;
@property (nonatomic, strong) ModelBaseData *modelIdentityNumber;
@property (nonatomic, strong) ModelBaseData *modelUnbindDriver;
@property (nonatomic, strong) AuthorityImageView *bottomView;
@property (strong, nonatomic) ModelAuthorityInfo *modelAuditInfo;

@end

@implementation PerfectAuthorityInfoVC
#pragma mark 懒加载
- (ModelBaseData *)modelRealName{
    if (!_modelRealName) {
        _modelRealName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"真实姓名";
            model.placeHolderString = @"输入真实姓名";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelRealName;
}
- (ModelBaseData *)modelIdentityNumber{
    if (!_modelIdentityNumber) {
        _modelIdentityNumber = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"身份证号";
            model.placeHolderString = @"输入身份证号";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelIdentityNumber;
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
- (UIView *)viewReason{
    if (!_viewReason) {
        _viewReason = [UIView new];
        _viewReason.backgroundColor = [UIColor redColor];
        _viewReason.width = SCREEN_WIDTH;
    }
    return _viewReason;
}
- (AuthorityImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthorityImageView new];
        [self refreshBottomView:nil];
    }
    return _bottomView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.aryDatas = @[self.modelUnbindDriver,self.modelRealName,self.modelIdentityNumber].mutableCopy;
    self.tableView.tableHeaderView = self.bottomView;
    [self registAuthorityCell];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    //request
    [self requestInfo];
    //add keyboard observe
    [self addObserveOfKeyboard];
    
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"司机认证" rightTitle:@"提交" rightBlock:^{
        [weakSelf requestSubmit];
    }]];
}

- (void)authorityExampleClick{
    AuthortiyExampleVC * vc = [AuthortiyExampleVC new];
    vc.aryDatas =@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"身份证人像面示例";
        model.imageName = @"authority_example_idcard";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"身份证国徽面示例";
        model.imageName = @"authority_example_idcardBack";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"驾驶证主页示例";
        model.imageName = @"authority_example_driverlicense";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"手持身份证示例";
        model.imageName = @"authority_example_idcardHand";
        return model;
    }()].mutableCopy;
    [GB_Nav pushViewController:vc animated:true];
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
- (void)requestSubmit{
    ModelImage * model0 = [self.bottomView.aryDatas objectAtIndex:0];
    ModelImage * model1 = [self.bottomView.aryDatas objectAtIndex:1];
    ModelImage * model2 = [self.bottomView.aryDatas objectAtIndex:2];
    ModelImage * model3 = [self.bottomView.aryDatas objectAtIndex:3];

    if (!isStr(model0.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加身份证人像面"];
        return;
    }
    if (!isStr(model1.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加身份证国徽面"];
        return;
    }
    if (!isStr(model2.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加驾驶证主页"];
        return;
    }
    
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    if (!isIdentityNum(self.modelIdentityNumber.subString)) {
        [GlobalMethod showAlert:@"请输入有效身份证号"];
        return;
    }
    [RequestApi requestSubmitAuthorityInfoWithDriverlicenseurl:model2.image.imageURL  idCardFrontUrl:model0.image.imageURL  idCardBackUrl:model1.image.imageURL idCardHandelUrl:model3.image.imageURL                                              realName:self.modelRealName.subString
                                                      idNumber:self.modelIdentityNumber.subString
                                                      delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [RequestApi requestUserInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalData sharedInstance].GB_UserModel = [ModelBaseInfo modelObjectWithDictionary:response];
            [GlobalMethod showAlert:@"提交成功"];
            [GB_Nav popToRootViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestInfo{
    if ([GlobalData sharedInstance].GB_UserModel.reviewStatus == 1) {
        return;
    }
    
    [RequestApi requestUserAuthorityInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark){
        self.modelRealName.subString = [response stringValueForKey:@"realName"];
        self.modelIdentityNumber.subString = [response stringValueForKey:@"idNumber"];
        [self refreshBottomView:response];

        NSArray * aryRespons = [response arrayValueForKey:@"qualificationList"];
        if (isAry(aryRespons)) {
            self.modelAuditInfo = [GlobalMethod exchangeDic:aryRespons toAryWithModelName:@"ModelAuthorityInfo"].firstObject;
            if (isStr(self.modelAuditInfo.explain)) {
                 UILabel * l = [UILabel new];
                           l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                           l.textColor = [UIColor whiteColor];
                           l.backgroundColor = [UIColor clearColor];
                           l.numberOfLines = 0;
                           l.lineSpace = W(3);
                           [l fitTitle:[NSString stringWithFormat:@"%@,请重新提交！",self.modelAuditInfo.explain] variable:SCREEN_WIDTH - W(30)];
                           l.leftTop = XY(W(15), W(15));
                           [self.viewReason addSubview:l];
                           self.viewReason.height = l.bottom + W(15);
                
                self.tableView.tableHeaderView = nil;
                
                UIView * viewHeader = [UIView initWithViews:@[self.viewReason,self.bottomView]];
                self.tableView.tableHeaderView = viewHeader;
            }
           
        }
        
        [self.tableView reloadData];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}


- (void)refreshBottomView:(NSDictionary *)response{
    WEAKSELF
    [self.bottomView resetViewWithAryModels:@[^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"身份证人像面";
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
        model.isEssential = true;
        model.url = [response stringValueForKey:@"idCardFrontUrl"];
        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
        model.cameraType = ENUM_CAMERA_IDENTITY_HEADER;
        model.blockUpSuccess = ^(ModelImage *upImage) {
            [RequestApi requestOCRIdentityWithurl:upImage.url delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelOCR * model = [ModelOCR modelObjectWithDictionary:[[response dictionaryValueForKey:@"data"] dictionaryValueForKey:@"frontResult"]];
                if (isStr(model.name)) {
                    weakSelf.modelRealName.subString = model.name;
                }
                if (isStr(model.iDNumber)) {
                    weakSelf.modelIdentityNumber.subString = model.iDNumber;
                }
                [weakSelf.tableView reloadData];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        };
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"身份证国徽面";
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
        model.isEssential = true;
        model.url = [response stringValueForKey:@"idCardBackUrl"];
        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
        model.cameraType = ENUM_CAMERA_IDENTITY_EMBLEM;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"驾驶证主页";
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_驾驶证"] url:nil];
        model.isEssential = true;
        model.url = [response stringValueForKey:@"driverLicenseUrl"];
        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
        model.cameraType = ENUM_CAMERA_DRIVING;

        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"手持身份证";
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_手持身份证"] url:nil];
        model.url = [response stringValueForKey:@"idCardHandelUrl"];
        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
        model.cameraType = ENUM_CAMERA_DRIVING;

        return model;
    }()]];
}
@end
