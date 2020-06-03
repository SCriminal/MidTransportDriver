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
//bank card list
#import "BankCardListVC.h"
//ListAlertView
#import "ListAlertView.h"

@interface AddCardVC ()<UITextFieldDelegate>
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelIdNum;
@property (nonatomic, strong) ModelBaseData *modelBankName;
@property (nonatomic, strong) ModelBaseData *modelBankAccount;
@property (nonatomic, strong) ListAlertView *listView;

@property (nonatomic, strong) UIView *selectBankCell;
@property (nonatomic, strong) NSMutableArray *aryBanks;
@property (nonatomic, strong) NSMutableArray *aryFilterBanks;

@end

@implementation AddCardVC

#pragma mark lazy init

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
        _modelBankName.enumType = ENUM_PERFECT_CELL_TEXT;
        _modelBankName.string = @"开户行";
        _modelBankName.subString = self.model.bankName;
        _modelBankName.placeHolderString = @"开户行名称(必选)";
        WEAKSELF
        _modelBankName.blocClick = ^(ModelBaseData *model) {
            [weakSelf.listView showWithPoint:[weakSelf.tableView convertPoint:CGPointMake(W(10), weakSelf.selectBankCell.bottom) toView:[UIApplication sharedApplication].keyWindow]  width:SCREEN_WIDTH - W(20) ary:[weakSelf filterBanks:model.subString]];

        };
        _modelBankName.blockValueChange = ^(ModelBaseData *model) {
            [weakSelf.listView showWithPoint:[weakSelf.tableView convertPoint:CGPointMake(W(10), weakSelf.selectBankCell.bottom) toView:[UIApplication sharedApplication].keyWindow]  width:SCREEN_WIDTH - W(20) ary:[weakSelf filterBanks:model.subString]];

        };
        
    }
    return _modelBankName;
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
    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];

    if (!self.model.iDProperty) {
        [self requestData];
    }
    [self requestBank];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"银行账户" rightTitle:@"提交" rightBlock:^{
        [weakSelf completeClick];
    }];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[ self.modelName,self.modelIdNum,self.modelBankName,self.modelBankAccount].mutableCopy;
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
    if ([cell isKindOfClass:PerfectTextCell.class]) {
        [cell reconfigTextFieldLeft:W(110)];
        ModelBaseData * model = [self.aryDatas objectAtIndex:indexPath.row];
        cell.iconArrow.hidden = ![model.string isEqualToString:@"开户行"];
        if ([model.string isEqualToString:@"开户行"]) {
             self.selectBankCell = cell;
        }
    }
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
   
    if (self.model.iDProperty) {
        [RequestApi requestEditBankCardWithAccountnumber:self.modelBankAccount.subString bankName:self.modelBankName.subString   id:self.model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.requestState = 1;
            [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
        [RequestApi requestAddBankCardWithAccountNumber:self.modelBankAccount.subString bankName:self.modelBankName.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
    [RequestApi requestUserInfoWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelBaseInfo * modelBase = [ModelBaseInfo modelObjectWithDictionary:response];
        self.modelIdNum.subString = modelBase.idNumber;
        self.modelName.subString = modelBase.realName;
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
#pragma mark status bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


@end

