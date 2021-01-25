//
//  OrderDetailVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/19.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderDetailVC.h"
//nav
#import "BaseNavView+Logical.h"
//sub view
#import "OrderDetailTopView.h"
#import "OrderDetailAccessoryView.h"
//request
//request
#import "RequestDriver2.h"
//share
#import "ShareView.h"
#import "OrderListCellBtnView.h"
#import "RejectOrderView.h"
#import "BulkCargoOperateLoadView.h"
#import "ThirdMap.h"
#import "BaseVC+Location.h"

@interface OrderDetailVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) OrderDetailView *topView;
@property (nonatomic, strong) OrderListCellBtnView *btnView;
@property (nonatomic, strong) OrderDetailTrailView *trailView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upLoadImageView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upUnLoadImageView;


@end

@implementation OrderDetailVC

#pragma mark lazy init
- (BulkCargoOperateLoadView *)upLoadImageView{
    if (!_upLoadImageView) {
        WEAKSELF
        BulkCargoOperateLoadView *upLoadImageView = [BulkCargoOperateLoadView new];
        upLoadImageView.blockComplete = ^(NSArray *aryImages) {
            NSMutableArray *ary = [aryImages fetchValues:@"url"];
            [RequestApi requestLoadWithUrls:[ary componentsJoinedByString:@","] number:weakSelf.orderList.orderNumber delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [weakSelf refreshHeaderAll];
                
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        };
        _upLoadImageView = upLoadImageView;
    }
    return _upLoadImageView;
}
- (BulkCargoOperateLoadView *)upUnLoadImageView{
    if (!_upUnLoadImageView) {
        BulkCargoOperateLoadView *upUnLoadImageView = [BulkCargoOperateLoadView new];
        [upUnLoadImageView.labelInput fitTitle:@"上传完成凭证" variable:0];
        [upUnLoadImageView.labelTitle fitTitle:@"请上传完成凭证 (回单、卸车磅单)" variable:0];
        WEAKSELF
        upUnLoadImageView.blockComplete = ^(NSArray *aryImages) {
            NSMutableArray *ary = [aryImages fetchValues:@"url"];
            [RequestApi requestUnloadWithUrls:[ary componentsJoinedByString:@","] number:weakSelf.orderList.orderNumber delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [weakSelf refreshHeaderAll];
                
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
            
        };
        _upUnLoadImageView = upUnLoadImageView;
        
    }
    return _upUnLoadImageView;
}
- (BaseNavView *)nav{
    if (!_nav) {
        WEAKSELF
        _nav = [BaseNavView initNavBackTitle:@"运单详情" rightView:nil];
        [_nav configBackBlueStyle];
        _nav.line.hidden = true;
    }
    return _nav;
}
- (OrderListCellBtnView *)btnView{
    if (!_btnView) {
        _btnView = [OrderListCellBtnView new];
        [_btnView resetViewWithModel:self.orderList];
        WEAKSELF
        _btnView.blockClick = ^(ENUM_ORDER_LIST_BTN tag,ModelTransportOrder * model) {
            [weakSelf requestOperate:tag model:model];
        };
    }
    return _btnView;
}

- (OrderDetailView *)topView{
    if (!_topView) {
        _topView = [OrderDetailView new];
        [_topView resetViewWithModel:self.orderList];
    }
    return _topView;
}
- (OrderDetailTrailView *)trailView{
    if (!_trailView) {
        _trailView = [OrderDetailTrailView new];
    }
    return _trailView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.btnView];
        self.btnView.centerXTop = XY(SCREEN_WIDTH/2.0, W(10));
        _bottomView.width = SCREEN_WIDTH;
        _bottomView.height = self.btnView.height + W(20) + iphoneXBottomInterval;
        _bottomView.bottom = SCREEN_HEIGHT;
    }
    return _bottomView;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.trailView]];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    [self.view addSubview:self.bottomView];
    [self addRefreshHeader];
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark refresh table header view
- (void)reconfigTableHeaderView{
        self.tableView.tableHeaderView = self.topView;
}
#pragma mark request
- (void)requestList{
    [RequestApi requestOrderDetailWithNumber:self.orderList.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.orderList = [ModelTransportOrder modelObjectWithDictionary:response];
        
        [self.topView resetViewWithModel:self.orderList];
        [self.btnView resetViewWithModel:self.orderList];
        self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
        [self reconfigTableHeaderView];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
   
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)requestOperate:(ENUM_ORDER_LIST_BTN)type model:(ModelTransportOrder *)model{
    WEAKSELF
    switch (type) {
        case ENUM_ORDER_LIST_BTN_REJECT:
        {
            RejectOrderView * view = [RejectOrderView new];
            [view resetViewWithModel:weakSelf.orderList];
            view.blockConfirm = ^(NSString * reason) {
                [RequestApi requestRejectOrderumber:weakSelf.orderList.orderNumber reason:reason delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    [weakSelf refreshHeaderAll];
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
            };
            [weakSelf.view addSubview:view];
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
           
            [self.upLoadImageView show];
        }
            break;
        case ENUM_ORDER_LIST_BTN_ARRIVE:
        {
            [self.upUnLoadImageView show];
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
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_ORDER;

    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil upHighQualitySuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        if (self.orderList.orderStatus == 2) {
            [self.upLoadImageView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
        }
        if (self.orderList.orderStatus == 3) {
            [self.upUnLoadImageView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
        }
    }
    if (self.orderList.orderStatus == 2) {
        [self.upLoadImageView.collection_Image.collectionView reloadData];
    }
    if (self.orderList.orderStatus == 3) {
        [self.upUnLoadImageView.collection_Image.collectionView reloadData];
    }
}

@end
