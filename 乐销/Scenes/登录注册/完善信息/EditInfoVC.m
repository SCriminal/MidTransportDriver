//
//  EditInfoVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "EditInfoVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
//date select
#import "DatePicker.h"
#import "BaseVC+BaseImageSelectVC.h"
//request
#import "RequestApi+UserApi.h"
//上传图片
#import "AliClient.h"
#import "BaseTableVC+Authority.h"
//nav
#import "BaseNavView+Logical.h"

@interface EditInfoVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelAge;
@property (nonatomic, strong) ModelBaseData *modelPhone;

@property (nonatomic, strong) ModelBaseData *modelBrief;
@property (nonatomic, strong) EditInfoTopView *topView;
@property (nonatomic, strong) ModelBaseInfo *modelInfo;

@end

@implementation EditInfoVC

#pragma mark lazy init

- (EditInfoTopView *)topView{
    if (!_topView) {
        _topView = [EditInfoTopView new];
        WEAKSELF
        _topView.blockClick = ^{
            [weakSelf showImageVC:1];
        };
    }
    return _topView;
}
- (ModelBaseInfo *)modelInfo{
    if (!_modelInfo) {
        _modelInfo = [ModelBaseInfo new];
        ModelBaseInfo * modelUser = [GlobalData sharedInstance].GB_UserModel;
        _modelInfo.headUrl = modelUser.headUrl;
        _modelInfo.nickname = modelUser.nickname;
    }
    return _modelInfo;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"手机号";
            model.isChangeInvalid = true;
            model.subString = [GlobalData sharedInstance].GB_UserModel.cellPhone;
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"昵称";
            model.placeHolderString = @"请输入";
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelAge{
    if (!_modelAge) {
        _modelAge =[ModelBaseData new];
        _modelAge.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelAge.imageName = @"";
        _modelAge.string = @"出生年月";
        _modelAge.placeHolderString = @"选择您的出生年月";
        _modelAge.hideState = true;
        WEAKSELF
        _modelAge.blocClick = ^(ModelBaseData *model) {
            [GlobalMethod endEditing];
            DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                weakSelf.modelAge.subString = [GlobalMethod exchangeDate:date formatter:TIME_DAY_CN];
                [weakSelf configData];
            } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
            [datePickerView.datePicker selectDate:isStr(weakSelf.modelAge.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelAge.subString formatter:TIME_DAY_CN]:[NSDate date]];
            [weakSelf.view addSubview:datePickerView];
        };
    }
    return _modelAge;
}
- (ModelBaseData *)modelBrief{
    if (!_modelBrief) {
        _modelBrief = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_ADDRESS;
            model.subString = [GlobalData sharedInstance].GB_UserModel.introduce;
            return model;
        }();
    }
    return _modelBrief;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //    self.tableView.tableHeaderView = self.topView;
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    [self registAuthorityCell];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request
    [self requestData];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"编辑资料" rightTitle:@"完成" rightBlock:^{
        [weakSelf completeClick];
    }];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    
    self.aryDatas = @[ self.modelName,self.modelPhone,self.modelAge,self.modelBrief].mutableCopy;
    [self.tableView reloadData];
}
#pragma mark image select
- (void)imageSelect:(BaseImage *)image{
    self.topView.ivHead.image = image;
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_USER_LOGO;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        
    } upHighQualitySuccess:nil fail:^{
        
    }];
}
#pragma mark UITableViewDelegate
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
#pragma mark click
- (void)completeClick{
    NSString * strUrl = isStr([BaseImage fetchUrl:self.topView.ivHead.image])?[BaseImage fetchUrl:self.topView.ivHead.image]:[GlobalData sharedInstance].GB_UserModel.headUrl;
    NSDate * dateBirthday = [GlobalMethod exchangeStringToDate:self.modelAge.subString formatter:TIME_DAY_CN];
    double timeBirthday = [dateBirthday timeIntervalSince1970];
    
    [RequestApi requestChangeUserInfoWithNickname:self.modelName.subString headUrl:strUrl gender:@"" birthday:[NSString stringWithFormat:@"%.f",timeBirthday] contactPhone:@"" areaId:@"" address:@"" email:@"" weChat:@"" introduce:self.modelBrief.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        //notice
        [GlobalData sharedInstance].GB_UserModel.headUrl = strUrl;
        [GlobalData sharedInstance].GB_UserModel.nickname = self.modelName.subString;
        [GlobalData sharedInstance].GB_UserModel.introduce = self.modelBrief.subString;
        [GlobalData saveUserModel];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

#pragma mark request
- (void)requestData{
    [RequestApi requestUserInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelInfo = [ModelBaseInfo modelObjectWithDictionary:response];
        self.modelName.subString = self.modelInfo.nickname;
        self.modelAge.subString = [GlobalMethod exchangeTimeWithStamp:self.modelInfo.birthday andFormatter:TIME_DAY_CN];
        self.modelBrief.subString = self.modelInfo.introduce;
        [self configData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end



@implementation EditInfoTopView
#pragma mark 懒加载
- (UILabel *)labelInfo{
    if (_labelInfo == nil) {
        _labelInfo = [UILabel new];
        _labelInfo.textColor = COLOR_999;
        _labelInfo.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _labelInfo.numberOfLines = 0;
        _labelInfo.lineSpace = 0;
    }
    return _labelInfo;
}
- (UIImageView *)ivHead{
    if (_ivHead == nil) {
        _ivHead = [UIImageView new];
        [_ivHead sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
        _ivHead.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_ivHead color:[UIColor clearColor] numRound:_ivHead.width/2.0 width:0];
    }
    return _ivHead;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelInfo];
    [self addSubview:self.ivHead];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.ivHead.leftTop = XY(W(15),W(20));
    
    [self.labelInfo fitTitle:@"修改头像" variable:0];
    self.labelInfo.leftCenterY = XY(W(99),self.ivHead.centerY);
    
    //设置总高度
    self.height = self.ivHead.bottom + W(20);
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
}

#pragma mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end
