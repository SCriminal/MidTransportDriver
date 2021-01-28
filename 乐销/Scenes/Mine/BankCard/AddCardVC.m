//
//  AddCardVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/9/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "AddCardVC.h"
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
//request
#import "RequestApi+Dictionary.h"
//request
#import "RequestDriver2.h"
//bank card list
#import "BankCardListVC.h"
//ListAlertView
#import "ListAlertView.h"
#import "SelectBankNameVC.h"

@interface AddCardVC ()<UITextFieldDelegate>
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelIdNum;
@property (nonatomic, strong) ModelBaseData *modelBankName;
@property (nonatomic, strong) ModelBaseData *modelBankAccount;
@property (nonatomic, strong) ModelBaseData *modelBankCity;
@property (nonatomic, strong) ModelBaseData *modelBankNum;

@property (nonatomic, strong) ListAlertView *listView;

@property (nonatomic, strong) UIView *selectBankCell;
@property (nonatomic, strong) NSMutableArray *aryBanks;
@property (nonatomic, strong) NSMutableArray *aryFilterBanks;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation AddCardVC

#pragma mark lazy init
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.width = SCREEN_WIDTH;
        _bottomView.height = W(39)+W(15);
        _bottomView.backgroundColor = [UIColor clearColor];
        [_bottomView addSubview:^(){
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY(W(345), W(39));
            btn.backgroundColor = COLOR_BLUE;
            [btn setTitle:@"提交" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnSubmitClick) forControlEvents:UIControlEventTouchUpInside];
            [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
            btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));

            return btn;
        }()];
    }
    return _bottomView;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"开户人";
            model.isChangeInvalid = true;
            model.subString = self.model.accountName;
            model.placeHolderString = @"真实姓名(必填)";
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelIdNum{
    if (!_modelIdNum) {
        _modelIdNum =[ModelBaseData new];
        _modelIdNum.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelIdNum.string = @"身份证号";
        _modelIdNum.isChangeInvalid = true;
        _modelIdNum.subString = self.model.idNumber;
        _modelIdNum.placeHolderString = @"身份证号码(必填)";
      
    }
    return _modelIdNum;
}
- (ModelBaseData *)modelBankName{
    if (!_modelBankName) {
        _modelBankName =[ModelBaseData new];
        _modelBankName.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelBankName.string = @"开户行";
        _modelBankName.subString = self.model.bankName;
        _modelBankName.identifier = NSNumber.dou(self.model.bankId).stringValue ;

        _modelBankName.placeHolderString = @"开户行名称(必选)";
        WEAKSELF
        _modelBankName.blocClick = ^(ModelBaseData *model) {
            SelectBankNameVC * vc = [SelectBankNameVC new ];
            vc.blockSearch = ^(NSString *name,double identity) {
                weakSelf.modelBankName.subString  = name;
                weakSelf.modelBankName.identifier = NSNumber.dou(identity).stringValue;
                [weakSelf.tableView reloadData];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
        
        
    }
    return _modelBankName;
}
- (ModelBaseData *)modelBankCity{
    if (!_modelBankCity) {
        _modelBankCity =[ModelBaseData new];
        _modelBankCity.enumType = ENUM_PERFECT_CELL_SELECT;
        _modelBankCity.string = @"开户行城市";
        _modelBankCity.subString = self.model.bankName;
        _modelBankCity.placeHolderString = @"选择开户行所在城市（非必填）";
        WEAKSELF
        _modelBankCity.blocClick = ^(ModelBaseData *model) {
           
        };
        
        
    }
    return _modelBankCity;
}
- (ModelBaseData *)modelBankNum{
    if (!_modelBankNum) {
        _modelBankNum =[ModelBaseData new];
        _modelBankNum.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelBankNum.string = @"银行行号";
        _modelBankNum.subString = self.model.idNumber;
        _modelBankNum.placeHolderString = @"填写银行行号（非必填）";
      
    }
    return _modelBankNum;
}
- (NSArray *)filterBanks:(NSString *)key{
    [self.aryFilterBanks removeAllObjects];
    if (!isStr(key)) {
        [self.aryFilterBanks addObjectsFromArray:self.aryBanks];
        return self.aryFilterBanks;
    }
    for (NSString * str in self.aryBanks) {
        if ([str containsString:key]) {
            [self.aryFilterBanks addObject:str];
        }
    }
    return self.aryFilterBanks;

}
- (ListAlertView *)listView{
    if (!_listView) {
        _listView = [ListAlertView new];
        WEAKSELF
        _listView.blockSelected = ^(NSInteger index) {
            [GlobalMethod hideKeyboard];
            if (weakSelf.aryFilterBanks.count >index) {
                weakSelf.modelBankName.subString  = weakSelf.aryFilterBanks[index];
                [weakSelf.tableView reloadData];
            }
        };

    }
    return _listView;
}
- (ModelBaseData *)modelBankAccount{
    if (!_modelBankAccount) {
        _modelBankAccount =[ModelBaseData new];
        _modelBankAccount.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelBankAccount.string = @"银行账户";
        _modelBankAccount.subString = self.model.accountNumber;
        _modelBankAccount.placeHolderString = @"银行账号(必填)";
        
    }
    return _modelBankAccount;
}
- (NSMutableArray *)aryFilterBanks{
    if (!_aryFilterBanks) {
        _aryFilterBanks = [NSMutableArray new];
    }
    return _aryFilterBanks;
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
//    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    self.tableView.tableFooterView = self.bottomView;
    if (!self.model.iDProperty) {
        [self requestData];
    }
    [self requestBank];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"添加银行卡" rightTitle:nil rightBlock:^{
    }];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[ self.modelName,self.modelIdNum,self.modelBankName,self.modelBankAccount].mutableCopy;
    for (ModelBaseData *m in self.aryDatas) {
        m.subLeft = W(105);
    }
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PerfectTextCell * cell = (PerfectTextCell *)[self dequeueAuthorityCell:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}
#pragma mark click
- (void)completeClick{
    if (!isStr(self.modelBankName.subString)) {
        [GlobalMethod showAlert:@"请选择开户银行"];
        return;
    }
    if (!isStr(self.modelBankAccount.subString)) {
        [GlobalMethod showAlert:@"请填写银行账户"];
        return;
    }
   
    if (isStr(self.model.accountNumber)) {
        [RequestApi requestEditCardWithAccountnumber:self.modelBankAccount.subString bankId:self.modelBankName.identifier.doubleValue accountName:self.modelBankName.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.requestState = 1;
            [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
      
    }else{
        [RequestApi requestAddCardWithAccountnumber:self.modelBankAccount.subString bankId:self.modelBankName.identifier.doubleValue accountName:self.modelBankName.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.requestState = 1;
            if ([GB_Nav hasClass:@"BankCardListVC"]) {
                [GB_Nav popToClass:@"BankCardListVC"];
            }else{
                BankCardListVC * vc = [BankCardListVC new];
                [GB_Nav popLastAndPushVC:vc];
            }
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
       
    }
}

#pragma mark request
- (void)requestData{
    [RequestApi requestDriverAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthDriver * model = [ModelAuthDriver modelObjectWithDictionary:response];
        self.modelIdNum.subString = model.idNumber;
        self.modelName.subString = model.name;
        [self.tableView reloadData];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
   
}

- (void)requestBank{
    [RequestApi requestBankListWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryBanks = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageType"];
        self.aryBanks = [aryBanks fetchValues:@"name"];;
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)btnSubmitClick{
            [self completeClick];
}
#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end

