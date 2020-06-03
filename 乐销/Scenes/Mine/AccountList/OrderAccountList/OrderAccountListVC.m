//
//  OrderAccountListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "OrderAccountListVC.h"
//cell
#import "OrderAccountListCell.h"
//input view
#import "InputAccountView.h"

@interface OrderAccountListVC ()
@property (nonatomic, strong) OrderAccountBottomView *bottomView;
@property (nonatomic, strong) OrderAccountBottomEditView *bottomEditView;
@property (nonatomic, strong) InputAccountView *inputView;
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIView *navRightManageView;
@property (nonatomic, strong) UIView *navRightCompleteView;

@end

@implementation OrderAccountListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无记账记录"];
    }
    return _noResultView;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"运单记账列表" rightView:self.navRightManageView];
    }
    return _nav;
}
- (UIView *)navRightManageView{
    if (!_navRightManageView) {
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"管理" rightBlock:nil];
        _navRightManageView = nav.rightView;
        [_navRightManageView addTarget:self action:@selector(manageClick)];
    }
    return _navRightManageView;
}
- (UIView *)navRightCompleteView{
    if (!_navRightCompleteView) {
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"完成" rightBlock:nil];
        _navRightCompleteView = nav.rightView;
        [_navRightCompleteView addTarget:self action:@selector(completeClick)];
    }
    return _navRightCompleteView;
}
- (InputAccountView *)inputView{
    if (!_inputView) {
        _inputView = [InputAccountView new];
        WEAKSELF
        _inputView.blockComplete = ^(NSString *des, NSString *price, BOOL isReceive) {
            [weakSelf requestAddAccount:des price:price isReceive:isReceive];
        };
    }
    return _inputView;
}
- (OrderAccountBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [OrderAccountBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockClick = ^{
            [weakSelf.inputView show];
        };
    }
    return _bottomView;
}
- (OrderAccountBottomEditView *)bottomEditView{
    if (!_bottomEditView) {
        _bottomEditView = [OrderAccountBottomEditView new];
        _bottomEditView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomEditView.blockClick = ^{
            if (![weakSelf.aryDatas fetchSelectModelsKeyPath:@"isSelected" value:@TRUE].count) {
                [weakSelf deleteSuccess];
                return ;
            }
            ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
            modelConfirm.blockClick = ^(void){
                [weakSelf requestDelete];
            };
            [BaseAlertView initWithTitle:@"确认删除？" content:@"确认删除选中账本" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
        };
        _bottomEditView.blockSelectAllClick = ^(BOOL isSelect) {
            for (ModelAccountList * modelItem in weakSelf.aryDatas) {
                modelItem.isSelected = isSelect;
                [weakSelf.tableView reloadData];
            }
        };
    }
    return _bottomEditView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[OrderAccountListCell class] forCellReuseIdentifier:@"OrderAccountListCell"];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    [self.view addSubview:self.bottomView];
    [self addRefreshHeader];
    [self addRefreshFooter];
    
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark reconfigView
- (void)reconfigView{
    if (self.isEditing) {
        [self.bottomView removeFromSuperview];
        [self.view addSubview:self.bottomEditView];
        [self.nav resetNavRightView:self.navRightCompleteView];
    }else{
        [self.bottomEditView removeFromSuperview];
        [self.view addSubview:self.bottomView];
        [self.nav resetNavRightView:self.navRightManageView];
    }
    [self.tableView reloadData];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderAccountListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAccountListCell"];
    cell.isEditing = self.isEditing;
    [cell resetCellWithModel:[self.aryDatas objectAtIndex:indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OrderAccountListCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isEditing) {
        OrderAccountListCell * cell = (OrderAccountListCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.ivSelected.highlighted = !cell.ivSelected.highlighted;
        cell.model.isSelected = cell.ivSelected.highlighted;
        [self.bottomEditView refreshStatus:self.aryDatas];
    }
}
#pragma mark click
- (void)completeClick{
    self.isEditing = false;
    [self reconfigView];
}
- (void)manageClick{
    self.isEditing = true;
    [self reconfigView];
    
}
#pragma mark request
- (void)requestList{
    [RequestApi requestAccountListWithEntid:0
                              waybillNumber:self.modelOrder.waybillNumber
                                 billNumber:nil
                                       type:nil
                                       page:self.pageNum
                                      count:50
                                  startTime:0
                                    endTime:0
                                   delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                       if (![response isKindOfClass:[NSDictionary class]]) {
                                           return ;
                                       }
                                       self.pageNum ++;
                                       NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAccountList"];
                                       [self.bottomView resetViewWithModel:[response doubleValueForKey:@"sumFee"]];
                                       if (self.isRemoveAll) {
                                           [self.aryDatas removeAllObjects];
                                       }
                                       if (!isAry(aryRequest)) {
                                           [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                       }
                                       [self.aryDatas addObjectsFromArray:aryRequest];
                                       [self.tableView reloadData];
                                   } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                       
                                   }];
    
}

- (void)requestDelete{
    NSMutableArray * aryDelete = [NSMutableArray array];
    for (ModelAccountList * modelItem in self.aryDatas) {
        if (modelItem.isSelected) {
            [aryDelete addObject:[NSString stringWithFormat:@"%.f",modelItem.iDProperty]];
        }
    }
    [RequestApi requestDeleteAccountWithId:[aryDelete componentsJoinedByString:@","] delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self deleteSuccess];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)deleteSuccess{
    self.isEditing = false;
    [self reconfigView];
    [self refreshHeaderAll];
}
- (void)requestAddAccount:(NSString *)des price:(NSString *)price isReceive:(BOOL)isReceive{
    [RequestApi requestAddAccountWithWaybillid:self.modelOrder.iDProperty type:isReceive?@"1":@"2" fee:price.doubleValue*100.0 description:des entId:self.modelOrder.shipperId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.inputView.tfDes.text = @"";
        self.inputView.tfPrice.text = @"";
        [self refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
};

@end
