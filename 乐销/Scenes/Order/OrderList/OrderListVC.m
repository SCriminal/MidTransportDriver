//
//  OrderListVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderListVC.h"
//cell
#import "OrderListCell.h"

//request
//request
#import "RequestDriver2.h"
//detail
#import "OrderDetailVC.h"
//operate
#import "DriverOperateVC.h"
//bottom view
#import "OrderManagementBottomView.h"
#import "OrderFilterView.h"
#import "BulkCargoOperateLoadView.h"
#import "BaseVC+Location.h"
#import <MapKit/MapKit.h>
#import "ThirdMap.h"
@interface OrderListVC ()
@property (nonatomic, strong) OrderFilterView *filterView;
@property (nonatomic, strong) ModelTransportOrder *modelOrder;
@property (nonatomic, strong) BulkCargoOperateLoadView *upLoadImageView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upUnLoadImageView;
@property (nonatomic, assign) NSInteger indexSelected;
@property (nonatomic, strong) NSString *billNo;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;

@end

@implementation OrderListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        _noResultView.verticalModify = -HEIGHT_ORDERMANAGEMENTBOTTOMVIEW/2.0;
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无运单信息"];
    }
    return _noResultView;
}
- (OrderFilterView *)filterView{
    if (!_filterView) {
        _filterView = [OrderFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSInteger index, NSString *billNo, NSDate *dateStart, NSDate *dateEnd) {
            weakSelf.indexSelected = index;
            weakSelf.billNo = billNo;
            weakSelf.dateStart = dateStart;
            weakSelf.dateEnd = dateEnd;
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavTitle:@"运单中心" leftImageName:@"nav_auto" leftImageSize:CGSizeMake(W(23), W(23)) leftBlock:^{
        
    } rightImageName:@"nav_filter_white" rightImageSize:CGSizeMake(W(23), W(23)) righBlock:^{
        [weakSelf.filterView show];
        
    }];
    [nav configBlueStyle];
    [self.view addSubview:nav];
    [self.tableView registerClass:[OrderListCell class] forCellReuseIdentifier:@"OrderListCell"];
    self.tableView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT);
    
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(12), 0);
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDetail = ^(ModelTransportOrder *model) {
        [weakSelf jumpToDetail:model];
    };
    cell.btnView.blockClick = ^(ENUM_ORDER_LIST_BTN type,ModelTransportOrder * model) {
        [weakSelf requestOperate:type model:model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelTransportOrder * model = self.aryDatas[indexPath.row];
    [self jumpToDetail:model];
    
}
- (void)jumpToDetail:(ModelTransportOrder *)model{
    OrderDetailVC * operateVC = [OrderDetailVC new];
    operateVC.orderList = model;
    WEAKSELF
    operateVC.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:operateVC animated:true];
}
#pragma mark request
- (void)requestList{
    NSString * strOrderStatus = nil;
    switch (self.indexSelected) {
        case 0:
            strOrderStatus = nil;
            break;
        case 1:
            strOrderStatus = @"1";
            break;
        case 2:
            strOrderStatus = @"2";
            break;
        case 3:
            strOrderStatus = @"3";
            break;
        case 4:
            strOrderStatus = @"4";
            break;
        case 5:
            strOrderStatus = @"9";
            break;
        default:
            break;
    }
    [RequestApi requestOrderListWithPage:self.pageNum count:20 orderNumber:isStr(self.billNo)?self.billNo:nil shipperName:nil plateNumber:nil driverName:nil                       startTime:self.dateStart?self.dateStart.timeIntervalSince1970:0
                                 endTime:self.dateEnd?self.dateEnd.timeIntervalSince1970:0
                            orderStatues:strOrderStatus
                                delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelTransportOrder"];
        
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
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)requestOperate:(ENUM_ORDER_LIST_BTN)type model:(ModelTransportOrder *)model{
    self.modelOrder = model;
    WEAKSELF
    switch (type) {
        case ENUM_ORDER_LIST_BTN_REJECT:
        {
            
        }
            break;
        case ENUM_ORDER_LIST_BTN_RECEIVE:
        {
            [RequestApi requestAcceptWithNumber:model.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [self refreshHeaderAll];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
            break;
        case ENUM_ORDER_LIST_BTN_LOAD_CAR:
        {
            BulkCargoOperateLoadView *upLoadImageView = [BulkCargoOperateLoadView new];
            upLoadImageView.blockComplete = ^(NSArray *aryImages) {
                NSMutableArray *ary = [aryImages fetchValues:@"url"];
                [RequestApi requestLoadWithUrls:[ary componentsJoinedByString:@","] number:model.orderNumber delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    [weakSelf refreshHeaderAll];
                    
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
            };
            [upLoadImageView show];
            self.upLoadImageView = upLoadImageView;
            
        }
            break;
        case ENUM_ORDER_LIST_BTN_ARRIVE:
        {
            BulkCargoOperateLoadView *upUnLoadImageView = [BulkCargoOperateLoadView new];
            [upUnLoadImageView.labelInput fitTitle:@"上传完成凭证" variable:0];
            [upUnLoadImageView.labelTitle fitTitle:@"请上传完成凭证 (回单、卸车磅单)" variable:0];
            WEAKSELF
            upUnLoadImageView.blockComplete = ^(NSArray *aryImages) {
                NSMutableArray *ary = [aryImages fetchValues:@"url"];
                [RequestApi requestUnloadWithUrls:[ary componentsJoinedByString:@","] number:model.orderNumber delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    [weakSelf refreshHeaderAll];
                    
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
                
            };
            [upUnLoadImageView show];
            self.upUnLoadImageView = upUnLoadImageView;
        }
            break;
        case ENUM_ORDER_LIST_BTN_NAVIGATION:
        {
            ModelAddress * moddelLocal = [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
            if (moddelLocal.lat == 0 || moddelLocal.lng == 0) {
                [self initLocation];
                [GlobalMethod showAlert:@"定位失败，请稍后重试"];
                return;
            }
            UIAlertController * vc =[ThirdMap getInstalledMapAppWithEndLocation:CLLocationCoordinate2DMake(moddelLocal.lat, moddelLocal.lng) currentLocation:CLLocationCoordinate2DMake(moddelLocal.lat+1, moddelLocal.lng+1)];
            [self presentViewController:vc animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

- (void)imagesSelect:(NSArray *)aryImages
{
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil upHighQualitySuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        if (self.modelOrder.orderStatus == 2) {
            [self.upLoadImageView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
        }
        if (self.modelOrder.orderStatus == 3) {
            [self.upUnLoadImageView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
        }
    }
    if (self.modelOrder.orderStatus == 2) {
        [self.upLoadImageView.collection_Image.collectionView reloadData];
    }
    if (self.modelOrder.orderStatus == 3) {
        [self.upUnLoadImageView.collection_Image.collectionView reloadData];
    }
}

@end
