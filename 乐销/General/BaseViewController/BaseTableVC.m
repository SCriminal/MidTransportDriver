//
//  BaseTableVC.m
//中车运
//
//  Created by 隋林栋 on 2016/12/14.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "BaseTableVC.h"
//refresh header
#import "MJChiBaoZiHeader.h"
//refresh footer
#import "CutomFooter.h"
//keyboard

//tableVC category
#import "BaseTableVC+KeyboardObserve.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC

#pragma mark lazy init
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray array];
    }
    return _aryDatas;
}

- (NSString *)strCellName{//关联无数据加载
    return nil;
}
- (NSString *)strModelName{//关联本地数据加载
    return nil;
}
- (NSString *)strLocalKey{
    return NSStringFromClass([self class]);
}
- (double)pageNum{
    if (self.isRemoveAll) {
        _pageNum = 1;
    }
    return _pageNum;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView addSubview:self.tableBackgroundView];
        if (self.strCellName != nil) {
            [_tableView registerClass:NSClassFromString(self.strCellName) forCellReuseIdentifier:self.strCellName];
        }
    }
    return _tableView;
}
- (UIView *)tableBackgroundView{
    if (!_tableBackgroundView) {
        _tableBackgroundView = ^(){
            UIView * viewBg = [UIView new];
            viewBg.frame =CGRectMake(0, -W(400), SCREEN_WIDTH, W(400));
            viewBg.backgroundColor = COLOR_BACKGROUND;
            viewBg.tag = TAG_LINE;
            return viewBg;
        }();
    }
    return _tableBackgroundView;
}
- (SectionIndexView *)sectionIndexView{
    if (!_sectionIndexView) {
        _sectionIndexView = [SectionIndexView new];
    }
    return _sectionIndexView;
}
- (NSString *)lastRow{
    if (isAry(self.aryDatas) && !self.isRemoveAll) {
        id model = self.aryDatas.lastObject;
        if ([model isKindOfClass:[ModelAryIndex class]]) {
            ModelAryIndex * modelSection = model;
            model = modelSection.aryMu.lastObject;
        }
        if ([model respondsToSelector:NSSelectorFromString(@"row")]) {
            id row = [model valueForKeyPath:@"row"];
            return [NSString stringWithFormat:@"%@",row];
        }
    }
    return @"0";
}
- (NSString *)lastUpdateTime{
    if (isAry(self.aryDatas) && !self.isRemoveAll) {
        id model = self.aryDatas.lastObject;
        if ([model isKindOfClass:[ModelAryIndex class]]) {
            ModelAryIndex * modelSection = model;
            model = modelSection.aryMu.lastObject;
        }
        if ([model respondsToSelector:NSSelectorFromString(@"updDate")]) {
            id update = [model valueForKeyPath:@"updDate"];
            if (update != nil) {
                return [NSString stringWithFormat:@"%@",update];
            }
        }
    }
    return @"";
}
- (id)requestDelegate{
    self.isNotShowLoadingView = isAry(self.aryDatas) && self.isRemoveAll;
    return self;
}
#pragma mark 增加上拉 下拉
- (void)addRefresh{
    [self addRefreshHeader];
    [self addRefreshFooter];
}
- (void)addRefreshHeader{
    self.tableView.mj_header = [MJChiBaoZiHeader new];
    [self.tableView.mj_header setRefreshingTarget:self refreshingAction:@selector(refreshHeaderAll)];
    [self.tableView insertSubview:self.tableBackgroundView atIndex:0];
}
- (void)addRefreshFooter{
    self.tableView.mj_footer = [[CutomFooter alloc]init];
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(refreshFooterAll)];
}
#pragma mark 上拉 下拉
- (void)refreshHeaderAll{
    self.tableView.mj_footer.userInteractionEnabled = false;
    self.isRemoveAll = true;
    [self requestList];
}
- (void)refreshFooterAll{
    self.tableView.mj_header.userInteractionEnabled = false;
    self.isRemoveAll = false;
    [self requestList];
}

#pragma mark 结束上拉 下拉
- (void)endRefreshing{
    self.tableView.mj_header.userInteractionEnabled = true;
    self.tableView.mj_footer.userInteractionEnabled = true;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.isRemoveAll = true;
    }
    return self;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.aryDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.strCellName) {
        id cell = [tableView dequeueReusableCellWithIdentifier:self.strCellName forIndexPath:indexPath];
        [GlobalMethod performSelector:@"resetCellWithModel:" delegate:cell object:self.aryDatas[indexPath.row] isHasReturn:false];
        return cell;
    }
    return ^(){
        UITableViewCell * cell =     [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        return cell;
    }();
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return isStr(self.strCellName)?[NSClassFromString(self.strCellName) fetchHeight:self.aryDatas[indexPath.row]]:CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


#pragma mark request
- (void)requestList{
    
}

#pragma mark noresult after requst
- (void)showNoResult{
    [self.noResultLoadingView removeFromSuperview];
    [self.noResultView removeFromSuperview];
    
    if(!self.isShowNoResult)return;
    if (self.aryDatas.count == 0) {
        CGFloat top = 0;
        if (self.tableView.tableHeaderView != nil) {
            top = self.tableView.tableHeaderView.height;
        }
        [self.noResultView showInView:self.tableView frame:CGRectMake(0, top, self.tableView.width, self.tableView.height)];
    }
}
#pragma mark noresult before request
- (void)showNoResultLoadingView{
    [self.noResultLoadingView removeFromSuperview];
    if(!self.isShowNoResultLoadingView)return;
    if (self.aryDatas.count == 0) {
        CGFloat top = 0;
        if (self.tableView.tableHeaderView != nil) {
            top = self.tableView.tableHeaderView.height;
        }
        [self.noResultLoadingView showInView:self.tableView frame:CGRectMake(0, top, self.tableView.width, self.tableView.height)];
    }
}

@end

