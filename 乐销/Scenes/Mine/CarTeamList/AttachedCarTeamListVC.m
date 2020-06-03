//
//  AttachedCarTeamListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachedCarTeamListVC.h"
//cell
#import "AttachedCarTeamListCell.h"
//request
#import "RequestApi+Order.h"

@interface AttachedCarTeamListVC ()
@property (nonatomic, strong) AttachedCarTeamSearchView *searchView;
@property (nonatomic, strong) NSString *strKey;

@end

@implementation AttachedCarTeamListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
//        _noResultView.verticalModify = -HEIGHT_ORDERMANAGEMENTBOTTOMVIEW/2.0;
        [_noResultView resetWithImageName:@"empty_attach" title:@""];
    }
    return _noResultView;
}
#pragma mark lazy init

- (AttachedCarTeamSearchView *)searchView{
    if (!_searchView) {
        _searchView = [AttachedCarTeamSearchView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _searchView.blockSearch = ^(NSString *key) {
            weakSelf.strKey = key;
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.view addSubview:self.searchView];
    [self.tableView registerClass:[AttachedCarTeamListCell class] forCellReuseIdentifier:@"AttachedCarTeamListCell"];
    self.tableView.height = SCREEN_HEIGHT - self.searchView.bottom;
    self.tableView.top = self.searchView.bottom;
    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"车队挂靠" rightView:nil];
    nav.line.hidden = true;
    [self.view addSubview:nav];
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
    AttachedCarTeamListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AttachedCarTeamListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockClick = ^(ModelAttachCompany *model) {
        [weakSelf requestAttach:model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AttachedCarTeamListCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestAttachCompanyWithName:self.strKey delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if (![response isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAttachCompany"];
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
- (void)requestAttach:(ModelAttachCompany *)modelCompany{
    [RequestApi requestApplyAttachWithEntid:modelCompany.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.requestState = 1;
        [GlobalMethod showAlert:@"申请成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
