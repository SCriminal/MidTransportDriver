//
//  BankCardListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/9/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "BankCardListVC.h"
// cell
#import "CardListCell.h"
//add card
#import "AddCardVC.h"
//request
#import "RequestApi+Dictionary.h"

@interface BankCardListVC ()

@end

@implementation BankCardListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_card" title:@"暂无银行卡"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[CardListCell class] forCellReuseIdentifier:@"CardListCell"];
    //request
    if (self.modelBank.iDProperty) {
        self.aryDatas = @[self.modelBank].mutableCopy;
    }else{
        [self requestList];
    }
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackWithTitle:@"我的银行卡" rightImageName:@"nav_add" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
        if (weakSelf.modelBank) {
            [GlobalMethod showAlert:@"只能添加一张银行卡"];
            return ;
        }
        AddCardVC * addVC = [AddCardVC new];
        addVC.blockBack = ^(UIViewController *vc) {
            if (vc.requestState) {
                [weakSelf requestList];
            }
        };
        [GB_Nav pushViewController:addVC animated:true];
    }]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CardListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockEditClick = ^(ModelBank *mb) {
        AddCardVC * addVC = [AddCardVC new];
        addVC.model = mb;
        addVC.blockBack = ^(UIViewController *vc) {
            [weakSelf requestList];
        };
        [GB_Nav pushViewController:addVC animated:true];
    };
    cell.blockDeleteClick = ^(ModelBank *mb) {
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestDelete];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认删除当前银行卡？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CardListCell fetchHeight:nil];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestBankCardWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelBank * mb = [ModelBank modelObjectWithDictionary:response];
        if (mb.iDProperty) {
            self.modelBank = mb;
            self.aryDatas = @[self.modelBank].mutableCopy;
        }else{
            self.modelBank = nil;
            [self.aryDatas removeAllObjects];
        }
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
    
}

- (void)requestDelete{
    [RequestApi requestDeleteBankCardWithId:self.modelBank.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelBank = nil;
        [self.aryDatas removeAllObjects];
        [self.tableView reloadData];
        [self showNoResult];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
