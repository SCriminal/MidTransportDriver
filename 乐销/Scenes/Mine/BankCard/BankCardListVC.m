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
//request
#import "RequestDriver2.h"

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
    self.tableView.backgroundColor = [UIColor clearColor];
    //table
    [self.tableView registerClass:[CardListCell class] forCellReuseIdentifier:@"CardListCell"];
//    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    //request
    if (self.modelBank.iDProperty) {
        self.aryDatas = @[self.modelBank].mutableCopy;
    }else{
        [self requestList];
    }
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
   BaseNavView * nav = [BaseNavView initNavBackTitle:@"我的银行卡" rightTitle:@"添加" rightBlock:^{
        if (weakSelf.modelBank) {
            [GlobalMethod showAlert:@"只能添加一张银行卡"];
            return ;
        }
       [weakSelf requestAuth];
        
    }];
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
    CardListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CardListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockEditClick = ^(ModelBank *mb) {
       
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
    [RequestApi requestCardListWithPage:1 count:20 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelBank"];
        if (ary.count) {
            self.modelBank = ary.firstObject;
            self.aryDatas = @[self.modelBank].mutableCopy;
        }else{
            self.modelBank = nil;
            [self.aryDatas removeAllObjects];
        }
        [self.tableView reloadData];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
 
    
}

- (void)requestDelete{
    [RequestApi requestDeleteCardWithAccountnumber:self.modelBank.accountNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelBank = nil;
        [self.aryDatas removeAllObjects];
        [self.tableView reloadData];
        [self showNoResult];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
   
   
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)requestAuth{
    [RequestApi requestDriverAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthDriver * model = [ModelAuthDriver modelObjectWithDictionary:response];
        if (model.reviewStatus == 10) {
            WEAKSELF
            AddCardVC * addVC = [AddCardVC new];
            addVC.blockBack = ^(UIViewController *vc) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:addVC animated:true];
        }else{
            [GlobalMethod showAlert:@"认证通过才能添加银行卡"];
        }
     
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
@end
