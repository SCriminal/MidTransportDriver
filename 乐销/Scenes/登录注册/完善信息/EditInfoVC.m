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
#import "SelectGenderView.h"
#import "AddressListVC.h"

@interface EditInfoVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelAge;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelGender;
@property (nonatomic, strong) ModelBaseData *modelEmail;
@property (nonatomic, strong) ModelBaseData *modelAddress;

@property (nonatomic, strong) EditInfoTopView *topView;
@property (nonatomic, strong) ModelBaseInfo *modelInfo;
@property (nonatomic, strong) EditInfoBottomView *bottomView;

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
- (EditInfoBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [EditInfoBottomView new];
    }
    return _bottomView;
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
            model.string = @"您的账号";
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
            model.placeHolderString = @"填写您的昵称";
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
- (ModelBaseData *)modelEmail{
    if (!_modelEmail) {
        _modelEmail =[ModelBaseData new];
        _modelEmail.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelEmail.imageName = @"";
        _modelEmail.string = @"电子邮箱";
        _modelEmail.placeHolderString = @"填写您的电子邮箱";
    }
    return _modelEmail;
}
- (ModelBaseData *)modelGender{
    if (!_modelGender) {
        _modelGender =[ModelBaseData new];
        _modelGender.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelGender.imageName = @"";
        _modelGender.string = @"性别";
        _modelGender.placeHolderString = @"选择您的性别";
        WEAKSELF
        _modelGender.blocClick = ^(ModelBaseData *model) {
            [GlobalMethod endEditing];
             SelectGenderView * view = [SelectGenderView new];
                           view.blockSelect = ^(double current) {
                               weakSelf.modelGender.identifier = NSNumber.dou(current).stringValue;
                               weakSelf.modelGender.subString = [ModelBaseInfo switchGender:current];
                               [weakSelf configData];
                           };
                           [weakSelf.view addSubview:view];
        };
    }
    return _modelGender;
}
- (ModelBaseData *)modelAddress{
    if (!_modelAddress) {
        _modelAddress =[ModelBaseData new];
        _modelAddress.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelAddress.imageName = @"";
        _modelAddress.string = @"收货地址";
        _modelAddress.placeHolderString = @"选择您的收货地址";
                _modelAddress.hideState = true;

        WEAKSELF
        _modelAddress.blocClick = ^(ModelBaseData *model) {
            [GlobalMethod endEditing];
            AddressListVC * vc = [AddressListVC new];
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _modelAddress;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    [self registAuthorityCell];
    self.tableView.tableHeaderView = self.topView;
//    self.tableView.tableFooterView = self.bottomView;

//    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
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
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"个人信息" rightTitle:@"保存" rightBlock:^{
        [weakSelf completeClick];
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelName,self.modelGender,self.modelAge,self.modelEmail,self.modelAddress].mutableCopy;
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
    
    [RequestApi requestChangeUserInfoWithNickname:self.modelName.subString headUrl:strUrl gender:self.modelGender.identifier birthday:[NSString stringWithFormat:@"%.f",timeBirthday] contactPhone:@"" areaId:@"" address:@"" email:@"" weChat:@"" introduce:self.bottomView.textView.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        //notice
        [GlobalData sharedInstance].GB_UserModel.headUrl = strUrl;
        [GlobalData sharedInstance].GB_UserModel.nickname = self.modelName.subString;
        [GlobalData sharedInstance].GB_UserModel.introduce = self.bottomView.textView.text;
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
        self.modelGender.subString = [ModelBaseInfo switchGender:self.modelInfo.gender];

        self.bottomView.textView.text = self.modelInfo.introduce;
        [self configData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end



@implementation EditInfoTopView
#pragma mark 懒加载
- (UILabel *)labelInfo{
    if (_labelInfo == nil) {
        _labelInfo = [UILabel new];
        _labelInfo.textColor = COLOR_999;
        _labelInfo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelInfo.numberOfLines = 0;
        _labelInfo.lineSpace = 0;
    }
    return _labelInfo;
}
- (UIImageView *)ivHead{
    if (_ivHead == nil) {
        _ivHead = [UIImageView new];
        [_ivHead sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
        _ivHead.widthHeight = XY(W(55),W(55));
        [GlobalMethod setRoundView:_ivHead color:[UIColor clearColor] numRound:_ivHead.width/2.0 width:0];
    }
    return _ivHead;
}
- (UILabel *)baseInfo{
    if (_baseInfo == nil) {
        _baseInfo = [UILabel new];
        _baseInfo.textColor = COLOR_666;
        _baseInfo.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_baseInfo fitTitle:@"基本信息" variable:0];
    }
    return _baseInfo;
}
- (UIView *)BG{
    if (_BG == nil) {
        _BG = [UIView new];
        _BG.backgroundColor = COLOR_BACKGROUND;
    }
    return _BG;
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
//    [self addSubview:self.BG];
//    [self addSubview:self.baseInfo];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
//    self.baseInfo.leftTop = XY(W(15),W(15));
//    self.BG.widthHeight = XY(SCREEN_WIDTH, self.baseInfo.bottom + W(15));
    
    //刷新view
    self.ivHead.leftTop = XY(W(15),W(15));
    
    [self.labelInfo fitTitle:@"点击上传头像" variable:0];
    self.labelInfo.leftCenterY = XY(W(90),self.ivHead.centerY);
    
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"setting_RightArrow"];
        iv.widthHeight = XY(W(25),W(25));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15), self.ivHead.centerY);
        [self addSubview:iv];
    }
    //设置总高度
    self.height = self.ivHead.bottom + W(15);
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(30), 1)];
}

#pragma mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end


@implementation EditInfoBottomView

- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        //        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(16) textColor:COLOR_999 text:@"这家伙很懒，什么也没填"];
        [_textView setTextColor:COLOR_333];
        _textView.font = [UIFont systemFontOfSize:F(16)];
        _textView.text = [GlobalData sharedInstance].GB_UserModel.introduce;
    }
    return _textView;
}
- (UILabel *)labelOpinion{
    if (_labelOpinion == nil) {
        _labelOpinion = [UILabel new];
        _labelOpinion.textColor = COLOR_666;
        _labelOpinion.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_labelOpinion fitTitle:@"个性签名" variable:0];
    }
    return _labelOpinion;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelOpinion];
    [self addSubview:self.textView];
    
    //初始化页面
    [self resetViewWithModel:nil];
}
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.labelOpinion.leftTop = XY(W(15), W(15));
    UIView * viewWhite = [UIView new];
    viewWhite.widthHeight = XY(SCREEN_WIDTH, self.labelOpinion.bottom+ W(15));
    viewWhite.backgroundColor = COLOR_BACKGROUND;
    [self insertSubview:viewWhite belowSubview:self.labelOpinion];
    
    self.textView.widthHeight = XY(SCREEN_WIDTH- W(30), W(100));
    self.textView.leftTop = XY(W(15), viewWhite.bottom + W(20));
    
    self.height = self.textView.bottom;
}


@end
