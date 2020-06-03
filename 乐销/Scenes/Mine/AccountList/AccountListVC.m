//
//  AccountListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/16.
//Copyright © 2019 ping. All rights reserved.
//

#import "AccountListVC.h"
//cell
#import "AccountListCell.h"
//filter
#import "AccountFilterView.h"
//request
#import "RequestApi+Order.h"
//request
#import "RequestApi+UserApi.h"

@interface AccountListVC ()
@property (nonatomic, strong) AccountBottomView *bottomView;
@property (nonatomic, strong) AccountBottomEditView *bottomEditView;

@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIView *navRightFilterView;
@property (nonatomic, strong) UIView *navRightCompleteView;
@property (nonatomic, strong) AccountFilterView *filterView;

@property (nonatomic, strong) NSString *strFilterBillNo;
@property (nonatomic, strong) ModelMotrocadeList *modelMotorcadeFilter;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;




@end

@implementation AccountListVC
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
- (AccountFilterView *)filterView{
    if (!_filterView) {
        _filterView = [AccountFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSString *billNo, ModelMotrocadeList *modelMotorcade, NSDate *dateStart, NSDate *dateEnd) {
            weakSelf.strFilterBillNo = isStr(billNo)?billNo:nil;
            weakSelf.modelMotorcadeFilter = modelMotorcade;
            weakSelf.dateStart = dateStart;
            weakSelf.dateEnd = dateEnd;
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterView;
}

- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"记账本" rightView:self.navRightFilterView];
    }
    return _nav;
}
- (UIView *)navRightFilterView{
    if (!_navRightFilterView) {
        BaseNavView * nav = [BaseNavView initNavBackWithTitle:@"" rightImageName:@"nav_filter" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:nil];
        _navRightFilterView = nav.rightView;
        [_navRightFilterView addTarget:self action:@selector(filterClick)];
    }
    return _navRightFilterView;
}
- (UIView *)navRightCompleteView{
    if (!_navRightCompleteView) {
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"完成" rightBlock:nil];
        _navRightCompleteView = nav.rightView;
        [_navRightCompleteView addTarget:self action:@selector(completeClick)];
    }
    return _navRightCompleteView;
}
- (AccountBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AccountBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockClick = ^{
            weakSelf.isEditing = !weakSelf.isEditing;
            [weakSelf reconfigView];
        };
    }
    return _bottomView;
}
- (AccountBottomEditView *)bottomEditView{
    if (!_bottomEditView) {
        _bottomEditView = [AccountBottomEditView new];
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
    [self.tableView registerClass:[AccountListCell class] forCellReuseIdentifier:@"AccountListCell"];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    [self.view addSubview:self.bottomView];
    [self addRefreshHeader];
    [self addRefreshFooter];
    
    //request
    [self requestList];
    [self requestCarTeamList];
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
        [self.nav resetNavRightView:self.navRightFilterView];
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
    AccountListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AccountListCell"];
    cell.isEditing = self.isEditing;
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AccountListCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isEditing) {
        AccountListCell * cell = (AccountListCell *)[tableView cellForRowAtIndexPath:indexPath];
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
- (void)filterClick{
    [self.filterView show];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestAccountListWithEntid:self.modelMotorcadeFilter.entId
                              waybillNumber:nil
                                 billNumber:self.strFilterBillNo
                                       type:nil page:self.pageNum count:50
                                  startTime:[self.dateStart timeIntervalSince1970]
                                    endTime:[self.dateEnd timeIntervalSince1970] delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
- (void)requestCarTeamList{
    [RequestApi requestMotorcadeListWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.filterView.aryDatas = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelMotrocadeList"];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
