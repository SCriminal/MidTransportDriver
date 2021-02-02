//
//  SelectAddressVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectAddressVC.h"
//cell
#import "SelectAddressCell.h"
//yellow btn
//request
#import "RequestDriver2.h"
#import "CreateAddressVC.h"

@interface SelectAddressVC ()
@property (nonatomic, strong) NSString *modelSelected;
@property (nonatomic, strong) ModelShopAddress *modelAddress;

@end

@implementation SelectAddressVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_address" title:@"暂无地址"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.height = SCREEN_HEIGHT - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.tableView registerClass:[SelectAddressCell class] forCellReuseIdentifier:@"SelectAddressCell"];
    [self addRefreshHeader];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"选择收货地址" rightTitle:@"添加地址" rightBlock:^{
        CreateAddressVC * vc = [CreateAddressVC new];
        vc.blockBack = ^(UIViewController *v) {
            [weakSelf refreshHeaderAll];
        };
        [GB_Nav pushViewController:vc animated:true];
        
    }]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectAddressCell"];
    ModelShopAddress * model = self.aryDatas[indexPath.row];
    [cell resetCellWithModel:model];
    WEAKSELF
    cell.blockEdit = ^(ModelShopAddress *item) {
        CreateAddressVC * vc = [CreateAddressVC new];
        vc.blockBack = ^(UIViewController *v) {
            [weakSelf refreshHeaderAll];
        };
        vc.model = item;
        [GB_Nav pushViewController:vc animated:true];
    };
    cell.iconSelected.highlighted = model.iDProperty == self.modelAddress.iDProperty;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectAddressCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.modelAddress = self.aryDatas[indexPath.row];
    [self.tableView reloadData];
    if (self.blockSelected) {
        self.blockSelected(self.modelAddress);
    }
    [GB_Nav popViewControllerAnimated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestAddressListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelShopAddress"];
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


@end


