//
//  CreateAddressVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateAddressVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"

//add
#import "SelectDistrictView.h"
//request
#import "RequestDriver2.h"
#import "BaseTableVC+Authority.h"

@interface CreateAddressVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelDistrict;
@property (nonatomic, strong) ModelBaseData *modelAddressDetail;
@property (nonatomic, strong) UIButton  *btnBottom;

@end

@implementation CreateAddressVC

#pragma mark lazy init
- (UIButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBottom.widthHeight = XY(W(345), W(39));
        _btnBottom.backgroundColor = COLOR_BLUE;
        [_btnBottom addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
        [_btnBottom setTitle:@"保存" forState:UIControlStateNormal];
        _btnBottom.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [_btnBottom addTarget:self action:@selector(requestAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBottom;
}

- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"联系人";
            model.subString = self.model.contact;
            model.placeHolderString = @"填写联系人姓名";
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"联系电话";
            model.subString = self.model.phone;
            model.placeHolderString = @"填写联系人电话";
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelDistrict{
    if (!_modelDistrict) {
        _modelDistrict = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"联系地址";
            if (self.model.iDProperty) {
                model.subString = [NSString stringWithFormat:@"%@%@%@",UnPackStr(self.model.provinceName),UnPackStr(self.model.cityName),UnPackStr(self.model.countyName)];
                model.identifier = strDotF(self.model.countyId);
            }
            model.placeHolderString = @"选择联系地址";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                SelectDistrictView * selectView = [SelectDistrictView new];
                selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                    weakSelf.modelDistrict.subString = [NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name];
                    weakSelf.modelDistrict.identifier = strDotF(area.iDProperty);
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:selectView];
            };
            return model;
        }();
    }
    return _modelDistrict;
}
- (ModelBaseData *)modelAddressDetail{
    if (!_modelAddressDetail) {
        _modelAddressDetail = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_ADDRESS;
//            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.imageName = @"";
            model.string = @"详细地址";
            model.subString = self.model.detail;
            model.placeHolderString = @"填写详细地址";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelAddressDetail;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableFooterView = ^(){
        UIView * footer = [UIView new];
        [footer addSubview:self.btnBottom];
        self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        footer.backgroundColor = [UIColor clearColor];
        footer.widthHeight = XY(SCREEN_WIDTH, self.btnBottom.bottom);
        return footer;
    }();
    [self registAuthorityCell];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:self.model.lat?@"编辑收货地址": @"添加收货地址" rightTitle:@"" rightBlock:^{
//        if (weakSelf.model.iDProperty) {
//            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除地址?" dismiss:^{
//
//            } confirm:^{
//                [weakSelf requestDelete];
//            } view:weakSelf.view];
//        }
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[ self.modelName,self.modelPhone,self.modelDistrict,self.modelAddressDetail].mutableCopy;
    [self.tableView reloadData];
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

- (void)requestAdd{
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    
    if (!isPhoneNum(self.modelPhone.subString)) {
        [GlobalMethod showAlert:@"请输入有效手机号"];
        return;
    }
    ModelAddress * modelAddressItem = [ModelAddress lastLocation];
    double lng = modelAddressItem.lng;
    double lat = modelAddressItem.lat;

    if (self.model.iDProperty) {
        [RequestApi requestEditAddressWithLng:NSNumber.dou(lng).stringValue lat:NSNumber.dou(lat).stringValue areaId:self.modelDistrict.identifier.doubleValue addr:self.modelAddressDetail.subString contactPhone:self.modelPhone.subString contacter:self.modelName.subString isDefault:@"0" id:NSNumber.dou(self.model.iDProperty).stringValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"编辑成功"];
            [GB_Nav popViewControllerAnimated:true];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
        return;
    }
    

    [RequestApi requestAddAddressWithLng:NSNumber.dou(lng).stringValue lat:NSNumber.dou(lat).stringValue areaId:self.modelDistrict.identifier.doubleValue addr:self.modelAddressDetail.subString contactPhone:self.modelPhone.subString contacter:self.modelName.subString isDefault:@"0" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        [GB_Nav popViewControllerAnimated:true];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    
}


@end
