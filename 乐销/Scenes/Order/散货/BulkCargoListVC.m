//
//  BulkCargoListVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "BulkCargoListVC.h"
//cell
#import "BulkCargoListCell.h"

//request
#import "RequestApi+BulkCargo.h"
//operate
#import "BulkCargoOrderDetailVC.h"
//bottom view
#import "OrderManagementBottomView.h"
//up iamgeview
#import "BulkCargoOperateLoadView.h"
#import "RejectOrderReason.h"
#import "LocationRecordInstance.h"

@interface BulkCargoListVC ()
@property (nonatomic, strong) ModelBulkCargoOrder *modelOrder;
@property (nonatomic, strong) BulkCargoOperateLoadView *upLoadImageView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upUnLoadImageView;

@end

@implementation BulkCargoListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        _noResultView.verticalModify = -HEIGHT_ORDERMANAGEMENTBOTTOMVIEW/2.0;
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无散货运单信息"];

    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    
    [self.tableView registerClass:[BulkCargoListCell class] forCellReuseIdentifier:@"BulkCargoListCell"];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
 
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
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
    WEAKSELF
    BulkCargoListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BulkCargoListCell"];
    cell.blockReject = ^(ModelBulkCargoOrder *model) {
        WEAKSELF
        RejectOrderReason * cancelView = [RejectOrderReason new];
        cancelView.blockComplete = ^(NSString *reason) {
            [weakSelf requestRejectModel:model reason:reason];
        };
        [cancelView show];
    };
    cell.blockAccept  = ^(ModelBulkCargoOrder *model) {
        //判断地理位置权限
        if (![GlobalMethod fetchLocalAuthorityBlock:nil]) {
            return;
        }
        //接单
        ModelBtn * modelDismiss = [ModelBtn   modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        WEAKSELF
        modelConfirm.blockClick = ^(void){
            [weakSelf requestOperate:nil model:model];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认接单?" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
    };
//    cell.blockLoad  = ^(ModelBulkCargoOrder *model) {
//        BulkCargoOperateLoadView *upLoadImageView = [BulkCargoOperateLoadView new];
//        upLoadImageView.blockComplete = ^(NSArray *aryImages,NSString * reason) {
//            NSMutableArray *ary = [aryImages fetchValues:@"url"];
//            [weakSelf requestOperate:[ary componentsJoinedByString:@","] model:model];
//        };
//        [upLoadImageView show];
//        weakSelf.upLoadImageView = upLoadImageView;
//        weakSelf.modelOrder = model;
//    };
//    cell.blockArrive = ^(ModelBulkCargoOrder *model) {
//        BulkCargoOperateLoadView *upUnLoadImageView = [BulkCargoOperateLoadView new];
//        [upUnLoadImageView.labelInput fitTitle:@"上传完成凭证" variable:0];
//        [upUnLoadImageView.labelTitle fitTitle:@"请上传完成凭证 (回单、卸车磅单)" variable:0];
//        WEAKSELF
//        upUnLoadImageView.blockComplete = ^(NSArray *aryImages,NSString * reason) {
//            NSMutableArray *ary = [aryImages fetchValues:@"url"];
//            [weakSelf requestOperate:[ary componentsJoinedByString:@","] model:model];
//        };
//        [upUnLoadImageView show];
//        weakSelf.upUnLoadImageView = upUnLoadImageView;
//        weakSelf.modelOrder = model;
//    };
    cell.blockDetail = ^(ModelBulkCargoOrder *model) {
        [weakSelf jumpToDetail:model];
    };
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [BulkCargoListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBulkCargoOrder * model = self.aryDatas[indexPath.row];
    [self jumpToDetail:model];
}
- (void)jumpToDetail:(ModelBulkCargoOrder *)model{
    BulkCargoOrderDetailVC * operateVC = [BulkCargoOrderDetailVC new];
       operateVC.modelOrder = model;
       WEAKSELF
       operateVC.blockBack = ^(UIViewController *vc) {
           [weakSelf refreshHeaderAll];
       };
       [GB_Nav pushViewController:operateVC animated:true];
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
    NSString * strOrderType = nil;
    int sortCreateTime = 1;
    int sortAcceptTime = 1;
    int sortFinishTime = 1;
    switch (self.sortType) {
        case ENUM_ORDER_LIST_SORT_GOING:
            strOrderType = @"1,2,3";
            sortAcceptTime = 3;
            break;
        case ENUM_ORDER_LIST_SORT_COMPLETE:
            strOrderType = @"10,11";
            sortFinishTime = 3;
            break;
        default:
            break;
    }
    [RequestApi requestBulkCargoOrderListWithwaybillStates:strOrderType
                                                      page:self.pageNum count:50
                                            sortAcceptTime:sortAcceptTime
                                            sortFinishTime:sortFinishTime
                                            sortCreateTime:sortCreateTime
                                                  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelBulkCargoOrder"];
        if (self.blockTotal) {
            self.blockTotal(self.sortType , [response intValueForKey:@"total"]);
        }
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
