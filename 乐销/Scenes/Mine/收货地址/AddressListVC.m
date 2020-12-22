//
//  AddressListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "AddressListVC.h"
//cell
#import "AddressListCell.h"
//request
//create
#import "CreateAddressVC.h"

@interface AddressListVC ()

@end

@implementation AddressListVC
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
    [self.tableView registerClass:[AddressListCell class] forCellReuseIdentifier:@"AddressListCell"];
    
    //request
    [self requestList];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"收货地址" rightTitle:@"" rightBlock:^{
        CreateAddressVC * vc = [CreateAddressVC new];
        vc.blockBack = ^(UIViewController *vc) {
            [weakSelf refreshHeaderAll];
        };
        [GB_Nav pushViewController:vc animated:true];
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
    
    AddressListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDeleteClick = ^(ModelShopAddress *item) {
        [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确认删除地址?" dismiss:^{
            
        } confirm:^{
            [weakSelf requestDelete:item];
        } view:weakSelf.view];
    };
    cell.blockEditClick  = ^(ModelShopAddress *item) {
        [weakSelf requestEdit:item];
        
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AddressListCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    self.aryDatas = @[^(){
        ModelShopAddress * m = [ModelShopAddress new];
        m.contact = @"李林";
        m.phone = @"15634834990";
        m.provinceName = @"山东省潍坊市奎文区梨园街道世博国";
        return m;
    }(),^(){
        ModelShopAddress * m = [ModelShopAddress new];
              m.contact = @"李林";
              m.phone = @"15634834990";
              m.provinceName = @"山东省潍坊市奎文区梨园街道世博国";
              return m;
    }(),^(){
         ModelShopAddress * m = [ModelShopAddress new];
              m.contact = @"李林";
              m.phone = @"15634834990";
              m.provinceName = @"山东省潍坊市奎文区梨园街道世博国";
              return m;
    }()].mutableCopy;
    [self.tableView reloadData];
//    [RequestApi requestAddressListWithPage:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        self.pageNum ++;
//        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelShopAddress"];
//        if (self.isRemoveAll) {
//            [self.aryDatas removeAllObjects];
//        }
//        if (!isAry(aryRequest)) {
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        }
//        [self.aryDatas addObjectsFromArray:aryRequest];
//        [self.tableView reloadData];
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//    }];
}
- (void)requestDelete:(ModelShopAddress *)model{
    WEAKSELF
//    [RequestApi requestDeleteAddressWithId:model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        [GlobalMethod showAlert:@"删除成功"];
//        [weakSelf refreshHeaderAll];
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//    }];
}
- (void)requestEdit:(ModelShopAddress *)model{
    WEAKSELF
    CreateAddressVC * vc = [CreateAddressVC new];
    vc.model = model;
    vc.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:vc animated:true];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
