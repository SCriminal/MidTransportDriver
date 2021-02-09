//
//  OrderDetailVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/19.
//Copyright © 2018年 ping. All rights reserved.
//

#import "BulkCargoOrderDetailVC.h"
//nav
#import "BaseNavView+Logical.h"
//sub view
#import "BulkCargoOrderDetailView.h"
//request
#import "RequestApi+BulkCargo.h"
//share
#import "ShareView.h"
//up iamgeview
#import "BulkCargoOperateLoadView.h"
#import "RejectOrderReason.h"
#import "BulkCargoOrderDetailTrackView.h"
#import "LocationRecordInstance.h"

@interface BulkCargoOrderDetailVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) BulkCargoOrderDetailTopView *topView;
@property (nonatomic, strong) BulkCargoOrderDetailStatusView *statusView;
@property (nonatomic, strong) BulkCargoOrderDetailPathView *pathView;
@property (nonatomic, strong) BulkCargoOrderDetailSendView *sendView;
@property (nonatomic, strong) BulkCargoOrderDetailReceiveView *receiveView;
//@property (nonatomic, strong) BulkCargoOrderDetailDriverView *driverView;
@property (nonatomic, strong) BulkCargoOrderDetailRemarkView *remarkView;
@property (nonatomic, strong) BulkLoadImageView *loadImageView;;
@property (nonatomic, strong) BulkLoadImageView *unloadImageView;;
@property (nonatomic, strong) BulkCargoOrderDetailTrackView *trackView;

@property (nonatomic, strong) BulkCargoOperateLoadView *upLoadImageView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upUnLoadImageView;

@end

@implementation BulkCargoOrderDetailVC

#pragma mark lazy init
- (BaseNavView *)nav{
    if (!_nav) {
        WEAKSELF
        _nav = [BaseNavView initNavBackWithTitle:@"运单详情" rightImageName:@"orderTopShare" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
            [ShareView showBulkCargo:weakSelf.modelOrder];
            
        }];
        _nav.line.hidden = true;
    }
    return _nav;
}
- (BulkCargoOrderDetailTrackView *)trackView{
    if (!_trackView) {
        _trackView = [BulkCargoOrderDetailTrackView new];
        _trackView.topToUpView = W(15);
        [_trackView resetViewWithModel:self.modelOrder];
    }
    return _trackView;
}
- (BulkCargoOrderDetailRemarkView *)remarkView{
    if (!_remarkView) {
        _remarkView = [BulkCargoOrderDetailRemarkView new];
        _remarkView.topToUpView = W(15);
        [_remarkView resetViewWithModel:self.modelOrder];
        
    }
    return _remarkView;
}
- (BulkCargoOrderDetailTopView *)topView{
    if (!_topView) {
        _topView = [BulkCargoOrderDetailTopView new];
        [_topView resetViewWithModel:self.modelOrder ];
        _topView.topToUpView = W(15);
    }
    return _topView;
}
- (BulkCargoOrderDetailStatusView *)statusView{
    if (!_statusView) {
        _statusView = [BulkCargoOrderDetailStatusView new];
        _statusView.topToUpView = W(15);
        WEAKSELF
        _statusView.blockAccept  = ^(ModelBulkCargoOrder *model) {
               //判断地理位置权限
               if (![GlobalMethod fetchLocalAuthorityBlock:nil]) {
                   return;
               }
               //接单
               ModelBtn * modelDismiss = [ModelBtn   modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
               ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
               modelConfirm.blockClick = ^(void){
                   [weakSelf requestOperate:nil model:model];
               };
               [BaseAlertView initWithTitle:@"提示" content:@"确认接单?" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
           };
//           _statusView.blockLoad  = ^(ModelBulkCargoOrder *model) {
//               BulkCargoOperateLoadView *upLoadImageView = [BulkCargoOperateLoadView new];
//               upLoadImageView.blockComplete = ^(NSArray *aryImages,NSString * reason) {
//                   NSMutableArray *ary = [aryImages fetchValues:@"url"];
//                   [weakSelf requestOperate:[ary componentsJoinedByString:@","] model:model];
//               };
//               [upLoadImageView show];
//               weakSelf.upLoadImageView = upLoadImageView;
//           };
//           _statusView.blockArrive = ^(ModelBulkCargoOrder *model) {
//               BulkCargoOperateLoadView *upUnLoadImageView = [BulkCargoOperateLoadView new];
//               [upUnLoadImageView.labelInput fitTitle:@"上传完成凭证" variable:0];
//               [upUnLoadImageView.labelTitle fitTitle:@"请上传完成凭证 (回单、卸车磅单)" variable:0];
//               upUnLoadImageView.blockComplete = ^(NSArray *aryImages,NSString * reason) {
//                   NSMutableArray *ary = [aryImages fetchValues:@"url"];
//                   [weakSelf requestOperate:[ary componentsJoinedByString:@","] model:model];
//               };
//               [upUnLoadImageView show];
//               weakSelf.upUnLoadImageView = upUnLoadImageView;
//           };
           
    }
    return _statusView;
}
- (BulkLoadImageView *)loadImageView{
    if (!_loadImageView) {
        _loadImageView = [BulkLoadImageView new];
        [_loadImageView resetViewWithLoadModel:self.modelOrder];
        _loadImageView.topToUpView = W(15);
        
    }
    return _loadImageView;
}
- (BulkLoadImageView *)unloadImageView{
    if (!_unloadImageView) {
        _unloadImageView = [BulkLoadImageView new];
        [_unloadImageView resetViewWithUnloadModel:self.modelOrder];
        _unloadImageView.topToUpView = W(15);
        
    }
    return _unloadImageView;
}
- (BulkCargoOrderDetailPathView *)pathView{
    if (!_pathView) {
        _pathView = [BulkCargoOrderDetailPathView new];
        _pathView.topToUpView = W(15);
        [_pathView resetViewWithModel:self.modelOrder];
        
    }
    return _pathView;
}
- (BulkCargoOrderDetailSendView *)sendView{
    if (!_sendView) {
        _sendView = [BulkCargoOrderDetailSendView new];
        _sendView.topToUpView = W(15);
        [_sendView resetViewWithModel:self.modelOrder];
    }
    return _sendView;
}
- (BulkCargoOrderDetailReceiveView *)receiveView{
    if (!_receiveView) {
        _receiveView = [BulkCargoOrderDetailReceiveView new];
        _receiveView.topToUpView = W(15);
        [_receiveView resetViewWithModel:self.modelOrder];
    }
    return _receiveView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self reconfigTableHeaderView];
    
    self.tableView.tableFooterView = ^(){
        UIView * view = [UIView new];
        view.height = W(20);
        view.backgroundColor = [UIColor clearColor];
        return view;
    }();
    [self addRefreshHeader];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark refresh table header view
- (void)reconfigTableHeaderView{
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,isAry(self.statusView.aryDatas)?self.statusView:[NSNull null],self.pathView,self.sendView,self.receiveView,isStr(self.modelOrder.internalBaseClassDescription)?self.remarkView:[NSNull null],self.loadImageView.aryDatas.count?self.loadImageView:[NSNull null],self.unloadImageView.aryDatas.count?self.unloadImageView:[NSNull null],self.trackView]];
}

#pragma mark 选择图片
- (void)imagesSelect:(NSArray *)aryImages
{
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil upHighQualitySuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD) {
            [self.upLoadImageView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
        }
        if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD) {
            [self.upUnLoadImageView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
        }
    }
    if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD) {
        [self.upLoadImageView.collection_Image.collectionView reloadData];
    }
    if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD) {
        [self.upUnLoadImageView.collection_Image.collectionView reloadData];
    }
}
#pragma mark request

- (void)requestTimeAxle{
    NSMutableArray * aryTimes = [NSMutableArray array];
    if (self.modelOrder.createTime) {
        [aryTimes addObject:^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"派单";
            model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.createTime andFormatter:TIME_SEC_SHOW];
            return model;
        }()];
    }
     [aryTimes addObject:^(){
               ModelBaseData * model = [ModelBaseData new];
               model.string = @"接单";
               model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.acceptTime andFormatter:TIME_SEC_SHOW];
               return model;
           }()];
     [aryTimes addObject:^(){
               ModelBaseData * model = [ModelBaseData new];
               model.string = @"装车";
               model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.loadTime andFormatter:TIME_SEC_SHOW];
               return model;
           }()];
    if (self.modelOrder.unloadTime) {
        [aryTimes addObject:^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"到达";
            model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.unloadTime andFormatter:TIME_SEC_SHOW];
            return model;
        }()];
    }
    if (self.modelOrder.finishTime) {
        [aryTimes addObject:^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"完成";
            model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.finishTime andFormatter:TIME_SEC_SHOW];
            return model;
        }()];
    }
    if (!self.modelOrder.unloadTime && !self.modelOrder.finishTime) {
         [aryTimes addObject:^(){
                   ModelBaseData * model = [ModelBaseData new];
                   model.string = @"到达";
                   return model;
               }()];
    }
    
    if (self.modelOrder.rejectTime) {
        [aryTimes addObject:^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"拒单";
            model.subString = [GlobalMethod exchangeTimeWithStamp:self.modelOrder.rejectTime andFormatter:TIME_SEC_SHOW];
            return model;
        }()];
    }
    [self.statusView resetViewWithAry:aryTimes model:self.modelOrder];
    [self reconfigTableHeaderView];
    
    
}
- (void)requestRejectModel:(ModelBulkCargoOrder *)model reason:(NSString *)reason{
    
    [RequestApi requestOperateBulkCargoRejectWithReason:reason id:model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestOperate:(NSString *)url model:(ModelBulkCargoOrder *)model{
    
    [RequestApi requestOperateBulkCargoOrder:model.iDProperty operateType:model.operateType url:url delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        //交通部
#ifdef UP_TRANSPORT
        if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD) {
            [[LocationRecordInstance sharedInstance]startLocationWithShippingNoteInfos:@[self.modelOrder] listener:^(id model, NSError *error) {
                
            }];
        }else if(self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD){
            [[LocationRecordInstance sharedInstance]stopLocationWithShippingNoteInfos:@[self.modelOrder] listener:^(id model, NSError *error) {
                
            }];
        }
#endif
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestList{
    [RequestApi requestBulkCargoDetailWithId:strDotF(self.modelOrder.iDProperty) delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelOrder = [ModelBulkCargoOrder modelObjectWithDictionary:response];
        
        [self.sendView resetViewWithModel:self.modelOrder];
        [self.receiveView resetViewWithModel:self.modelOrder];
        [self.pathView resetViewWithModel:self.modelOrder];
//        [self.driverView resetViewWithModel:self.modelOrder];
        [self.remarkView resetViewWithModel:self.modelOrder];
        [self.loadImageView resetViewWithLoadModel:self.modelOrder];
        [self.unloadImageView resetViewWithUnloadModel:self.modelOrder];
        
        
        [self reconfigTableHeaderView];
        [self requestTimeAxle];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
