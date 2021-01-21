//
//  AddPathVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/31.
//Copyright © 2020 ping. All rights reserved.
//

#import "AddPathVC.h"
#import "BaseTableVC+Authority.h"
#import "SelectDistrictView.h"
//request
#import "RequestDriver2.h"

@interface AddPathVC ()
@property (nonatomic, strong) ModelBaseData *modelAddressStart;
@property (nonatomic, strong) ModelBaseData *modelAddressEnd;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation AddPathVC
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UIButton * btn = [UIButton createBottomBtn:@"添加途径地"];
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        [btn addTarget:self action:@selector(addClick)];
        _bottomView.widthHeight = XY(SCREEN_WIDTH, btn.bottom);
        [_bottomView addSubview:btn];
    }
    return _bottomView;
}
- (ModelBaseData *)modelAddressStart{
    if (!_modelAddressStart) {
        _modelAddressStart = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"始发地";
            model.placeHolderString = @"选择始发地";
            if (self.modelList) {
                model.subString = self.modelList.startShow;
                model.identifier = NSNumber.dou(self.modelList.startCountyId).stringValue;
            }
            WEAKSELF
            model.blocClick = ^(ModelBaseData *modelClick) {
                SelectDistrictView * selectView = [SelectDistrictView new];
                selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                    modelClick.subString = [NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name];
                    modelClick.identifier = strDotF(area.iDProperty);
                    [weakSelf.tableView reloadData];
                };
                [weakSelf.view addSubview:selectView];
            };
            return model;
        }();
    }
    return _modelAddressStart;
}

- (ModelBaseData *)modelAddressEnd{
    if (!_modelAddressEnd) {
        WEAKSELF
        _modelAddressEnd = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"目的地";
            model.placeHolderString = @"选择目的地";
            if (self.modelList) {
                model.subString = self.modelList.endShow;
                model.identifier = NSNumber.dou(self.modelList.endCountyId).stringValue;
            }
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                SelectDistrictView * selectView = [SelectDistrictView new];
                selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                    modelClick.subString = [NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name];
                    modelClick.identifier = strDotF(area.iDProperty);
                    [weakSelf.tableView reloadData];
                };
                [weakSelf.view addSubview:selectView];
            };
            return model;
        }();
    }
    return _modelAddressEnd;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self registAuthorityCell];
    self.tableView.tableFooterView = self.bottomView;
    //request
    self.aryDatas = @[self.modelAddressStart,self.modelAddressEnd].mutableCopy;
    [self.tableView reloadData];
    if (self.modelList) {
        [self requestDetail];
    }
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavBackTitle:self.modelList?@"修改路线":@"添加路线" rightTitle:@"保存" rightBlock:^{
        [weakSelf requestSave];
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
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


- (void)addClick{
    [self addPathName:nil identity:0];
}
- (void)addPathName:(NSString *)name identity:(double)identity{
    if (self.aryDatas.count>=5) {
        [GlobalMethod showAlert:@"最多添加3个途径地"];
        return;
    }
    
    ModelBaseData * model = [ModelBaseData new];
    model.enumType = ENUM_PERFECT_CELL_SELECT_DELETE;
    model.imageName = @"";
    model.string = [NSString stringWithFormat:@"途径%ld",self.aryDatas.count - 1];
    model.placeHolderString = @"选择途径地";
    model.subString = name;
    model.identifier = identity?NSNumber.dou(identity).stringValue:nil;
    WEAKSELF
    model.blockDeleteClick = ^(ModelBaseData *modelClick) {
        [GlobalMethod endEditing];
        [weakSelf.aryDatas removeObject:modelClick];
        for (int i = 1; i<(weakSelf.aryDatas.count -1); i++) {
            ModelBaseData * m = weakSelf.aryDatas[i];
            m.string = [NSString stringWithFormat:@"途径%ld",i];
        }
        [weakSelf.tableView reloadData];
    };
    model.blocClick = ^(ModelBaseData *modelClick) {
        SelectDistrictView * selectView = [SelectDistrictView new];
        selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
            modelClick.subString = [NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name];
            modelClick.identifier = strDotF(area.iDProperty);
            [weakSelf.tableView reloadData];
        };
        [weakSelf.view addSubview:selectView];
    };
   
    [self.aryDatas insertObject:model atIndex:self.aryDatas.count - 1];
    [self.tableView reloadData];
}
- (void)requestSave{
    NSString * startID = nil;
    NSString * endID = nil;
    NSString * path0 = nil;
    NSString * path1 = nil;
    NSString * path2 = @"";
    {
        ModelBaseData * m = self.aryDatas[0];
        startID = m.identifier;
    }
    {
        ModelBaseData * m = self.aryDatas.lastObject;
        endID = m.identifier;
    }
    if (self.aryDatas.count>=3) {
        ModelBaseData * m = self.aryDatas[1];
        path0 = m.identifier;
        if (!isStr(path0)) {
            [GlobalMethod showAlert:@"请选择途径地1"];
            return;
        }
    }
    if (self.aryDatas.count>=4) {
        ModelBaseData * m = self.aryDatas[2];
        path1 = m.identifier;
        if (!isStr(path1)) {
            [GlobalMethod showAlert:@"请选择途径地2"];
            return;
        }
    }
    if (self.aryDatas.count>=5) {
        ModelBaseData * m = self.aryDatas[3];
        path2 = m.identifier;
        if (!isStr(path2)) {
            [GlobalMethod showAlert:@"请选择途径地3"];
            return;
        }
    }
    if (!isStr(startID)) {
        [GlobalMethod showAlert:@"请选择始发地"];
        return;
    }
    if (!isStr(endID)) {
        [GlobalMethod showAlert:@"请选择目的地"];
        return;
    }
    if (self.modelList.iDProperty) {
        [RequestApi requestEditPathWithStartareaid:startID endAreaId:endID routePass1Id:path0 routePass2Id:path1 routePass3Id:path2 id:NSNumber.dou(self.modelList.iDProperty).stringValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"编辑成功"];
            [GB_Nav popViewControllerAnimated:true];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
        [RequestApi requestAddPathWithStartareaid:startID endAreaId:endID routePass1Id:path0 routePass2Id:path1 routePass3Id:path2 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"添加成功"];
            [GB_Nav popViewControllerAnimated:true];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
    }
  
    
}
- (void)requestDetail{
    [RequestApi requestPathDetailWithId:self.modelList.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelList = [ModelPathListItem modelObjectWithDictionary:response];
        if (self.modelList.routePass1Id) {
            [self addPathName:self.modelList.routePass1 identity:self.modelList.routePass1Id];
        }
        if (self.modelList.routePass2Id) {
            [self addPathName:self.modelList.routePass2 identity:self.modelList.routePass2Id];
        }
        if (self.modelList.routePass3Id) {
            [self addPathName:self.modelList.routePass3 identity:self.modelList.routePass3Id];
        }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
@end
