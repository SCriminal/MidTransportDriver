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
#import "BulkCargoOrderDetailTrackView.h"
#import "LocationRecordInstance.h"

@interface OrderDetailVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) OrderDetailView *topView;
@property (nonatomic, strong) OrderListCellBtnView *btnView;
@property (nonatomic, strong) BulkCargoOrderDetailTrackView *trackView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upLoadImageView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upUnLoadImageView;
@property (nonatomic, strong) OrderDetailCommentView *commentView;


@end

@implementation OrderDetailVC

#pragma mark lazy init
- (OrderDetailCommentView *)commentView{
    if (!_commentView) {
        _commentView = [OrderDetailCommentView new];
    }
    return _commentView;
}
- (BulkCargoOperateLoadView *)upLoadImageView{
    if (!_upLoadImageView) {
        WEAKSELF
        BulkCargoOperateLoadView *upLoadImageView = [BulkCargoOperateLoadView new];
        upLoadImageView.blockComplete = ^(NSArray *aryImages,NSString * reason,NSString * dealyReason) {
            NSMutableArray *ary = [aryImages fetchValues:@"url"];
            [RequestApi requestLoadWithUrls:[ary componentsJoinedByString:@","] number:weakSelf.orderList.orderNumber                description:reason delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [weakSelf refreshHeaderAll];
                [[LocationRecordInstance sharedInstance]startLocationWithShippingNoteInfos:@[weakSelf.orderList] listener:^(id model, NSError *error) {
                              
                          }];
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
        [GlobalMethod setLabel:upUnLoadImageView.textView.placeHolder widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_999 text:@"其他完成信息 (非必填)"];
        WEAKSELF
        upUnLoadImageView.blockComplete = ^(NSArray *aryImages,NSString * reason,NSString *reason1) {
            NSMutableArray *ary = [aryImages fetchValues:@"url"];
            [RequestApi requestUnloadWithUrls:[ary componentsJoinedByString:@","] number:weakSelf.orderList.orderNumber description:reason delayReasoon:reason1 delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [weakSelf refreshHeaderAll];
                [[LocationRecordInstance sharedInstance]stopLocationWithShippingNoteInfos:@[weakSelf.orderList] listener:^(id model, NSError *error) {
                              
                          }];
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

- (BulkCargoOrderDetailTrackView *)trackView{
    if (!_trackView) {
        _trackView = [BulkCargoOrderDetailTrackView new];
        _trackView.topToUpView = W(10);
        WEAKSELF
        _trackView.blockReqeustTrack = ^(NSMutableArray *ary) {
            weakSelf.aryDatas = ary;
            for (ModelLocationItem * item in weakSelf.aryDatas) {
                item.isFirst = false;
                item.isLast = false;
            }
            if (weakSelf.aryDatas.count) {
                ModelLocationItem * item = weakSelf.aryDatas.firstObject;
                item.isFirst = true;
                item = weakSelf.aryDatas.lastObject;
                item.isLast = true;
            }
            [weakSelf.tableView reloadData];
        };
        [_trackView resetViewWithModel:self.orderList];

    }
    return _trackView;
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
    [self.tableView registerClass:OrderDetailTrackCell.class forCellReuseIdentifier:@"OrderDetailTrackCell"];
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.trackView]];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    [self.view addSubview:self.bottomView];
    [self addRefreshHeader];
    [self requestList];
    [self addObserveOfKeyboard];
    self.tableView.tableFooterView = self.commentView;

}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailTrackCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailTrackCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OrderDetailTrackCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark refresh table header view
- (void)reconfigTableHeaderView{
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.trackView]];
    
}
#pragma mark request
- (void)requestList{
    [RequestApi requestOrderDetailWithNumber:self.orderList.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.orderList = [ModelTransportOrder modelObjectWithDictionary:response];
        
        [self.topView resetViewWithModel:self.orderList];
        [self.btnView resetViewWithModel:self.orderList];
        
        self.bottomView.height = self.btnView.height + W(20) + iphoneXBottomInterval;
//        self.bottomView.height = self.btnView.height?(self.btnView.height + W(20) + iphoneXBottomInterval):0;
        self.bottomView.bottom = SCREEN_HEIGHT;

        self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
        [self reconfigTableHeaderView];
        self.tableView.tableFooterView = self.commentView;
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
            ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
            modelConfirm.blockClick = ^(void){
                [RequestApi requestAcceptWithNumber:model.orderNumber delegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    [weakSelf refreshHeaderAll];
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
            };
            [BaseAlertView initWithTitle:@"提示" content:@"确认要接单？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:self.view];
        }
            break;
        case ENUM_ORDER_LIST_BTN_LOAD_CAR:
        {
           
            [self.upLoadImageView show];
        }
            break;
        case ENUM_ORDER_LIST_BTN_ARRIVE:
        {
            
            self.upUnLoadImageView.isOutTime = self.orderList.isOutOfTime;
            [self.upLoadImageView resetViewWithModel:nil];
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
