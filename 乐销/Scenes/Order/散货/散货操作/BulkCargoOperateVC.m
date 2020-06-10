//
//  BulkCargoOperateVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "BulkCargoOperateVC.h"
//高德地图
#import <MAMapKit/MAMapView.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAPinAnnotationView.h>
#import <MAMapKit/MAPolyline.h>
#import <MAMapKit/MAPolylineRenderer.h>

//init location
#import "BaseVC+Location.h"
//image select
#import "BaseVC+BaseImageSelectVC.h"
//top view
#import "BulkCargoOperateView.h"

//request
#import "RequestApi+BulkCargo.h"
#import "RequestApi+Location.h"
//alicent
#import "AliClient.h"
//detail
#import "BulkCargoOrderDetailVC.h"
//alert view
#import "TopAlertView.h"
//share
#import "ShareView.h"
//up iamgeview
#import "BulkCargoOperateLoadView.h"
//location
#import "LocationRecordInstance.h"



@interface BulkCargoOperateVC ()<MAMapViewDelegate,NSURLSessionDelegate>
//地图
@property (nonatomic,strong) MAMapView *mapView;
//top view
@property (nonatomic, strong) BulkCargoOperateTopView *topView;
//mid view
@property (nonatomic, strong) BulkCargoOperateMidView *midView;
//bottom view
@property (nonatomic, strong) BulkCargoOperateBottomView *bottomView;

@property (strong, nonatomic) UIImageView *ivBottomBg;
//up image view
@property (nonatomic, strong) BulkCargoOperateLoadView *upLoadImageView;
@property (nonatomic, strong) BulkCargoOperateLoadView *upUnLoadImageView;

//location
@property (nonatomic, assign) CLLocationCoordinate2D locationStart;
@property (nonatomic, assign) CLLocationCoordinate2D locationEnd;
@property (nonatomic, strong) NSMutableArray *aryLocationRequest;

//hide animation
@property (nonatomic, assign) BOOL isMonitor;
@property (nonatomic, assign) BOOL isBottomHide;

@end

@implementation BulkCargoOperateVC
#pragma mark lazy init
- (UIImageView *)ivBottomBg{
    if (_ivBottomBg == nil) {
        _ivBottomBg = [UIImageView new];
        _ivBottomBg.image =IMAGE_WHITE_BG;
    }
    return _ivBottomBg;
}
- (BulkCargoOperateLoadView *)upLoadImageView{
    if (!_upLoadImageView) {
        _upLoadImageView = [BulkCargoOperateLoadView new];
        WEAKSELF
        _upLoadImageView.blockComplete = ^(NSArray *aryImages) {
            NSMutableArray *ary = [aryImages fetchValues:@"url"];
            [weakSelf requestOperate:[ary componentsJoinedByString:@","]];
        };
    }
    return _upLoadImageView;
}
- (BulkCargoOperateLoadView *)upUnLoadImageView{
    if (!_upUnLoadImageView) {
        _upUnLoadImageView = [BulkCargoOperateLoadView new];
        [_upUnLoadImageView.labelInput fitTitle:@"上传完成凭证" variable:0];
        [_upUnLoadImageView.labelTitle fitTitle:@"请上传完成凭证 (回单、卸车磅单)" variable:0];
        WEAKSELF
        _upUnLoadImageView.blockComplete = ^(NSArray *aryImages) {
            NSMutableArray *ary = [aryImages fetchValues:@"url"];
            [weakSelf requestOperate:[ary componentsJoinedByString:@","]];
        };
    }
    return _upUnLoadImageView;
}
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
        _mapView.showsScale= NO;
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.rotateEnabled = false;
        _mapView.rotateCameraEnabled = false;
        _mapView.showsUserLocation = false;
        [_mapView setZoomLevel:MAPZOOMNUM animated:true];
        _mapView.userTrackingMode = MAUserTrackingModeNone;
    }
    return _mapView;
}

- (BulkCargoOperateTopView *)topView{
    if (!_topView) {
        _topView = [BulkCargoOperateTopView new];
        _topView.top = 0;
        [_topView resetViewWithModel:self.modelOrder];
        WEAKSELF
        _topView.blockClick = ^{
            [ShareView showBulkCargo:weakSelf.modelOrder];
        };
    }
    return _topView;
}
- (BulkCargoOperateMidView  *)midView{
    if (!_midView) {
        _midView = [BulkCargoOperateMidView new];
        [_midView resetViewWithModel:self.modelOrder];
        WEAKSELF
        _midView.blockBottomClick = ^{
            [weakSelf showBottom];
        };
    }
    return _midView;
}
- (BulkCargoOperateBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [BulkCargoOperateBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        [_bottomView resetViewWithModel:self.modelOrder];
       
        _bottomView.blockDetailClick = ^{
            BulkCargoOrderDetailVC  * detailVC = [BulkCargoOrderDetailVC new];
            detailVC.modelOrder = weakSelf.modelOrder;
            [GB_Nav pushViewController:detailVC animated:true];
        };
        
        _bottomView.blockOperateClick = ^{
            [weakSelf operateClick];
        };
    }
    return _bottomView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.ivBottomBg];
    [self.view addSubview:self.midView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.topView];
    //init location
    [self reconfigView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reconfigView) name:NOTICE_SELFMODEL_CHANGE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

    double finishTime = self.modelOrder.unloadTime?self.modelOrder.unloadTime:self.modelOrder.finishTime;
    if (!finishTime) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestTrick) name:NOTICE_LOCATION_UP_SUCCESS object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationChange) name:NOTICE_LOCATION_CHANGE object:nil];

    }

    [self requestDetail];
}
#pragma mark location
- (void)resignActive{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTICE_LOCATION_UP_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTICE_LOCATION_CHANGE object:nil];

}
- (void)becomeActive{
    double finishTime = self.modelOrder.unloadTime?self.modelOrder.unloadTime:self.modelOrder.finishTime;
    if (!finishTime) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestTrick) name:NOTICE_LOCATION_UP_SUCCESS object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationChange) name:NOTICE_LOCATION_CHANGE object:nil];

        [self requestTrick];
    }
}
- (void)locationChange{
    [self drawLine:self.aryLocationRequest.mutableCopy];
}

#pragma mark init location
- (void)fetchLocation:(CLLocation *)location{
    [self.mapView setCenterCoordinate:location.coordinate animated:false];
    self.isMonitor = true;
}



#pragma mark refonfig view
- (void)reconfigView{
    //bottom view
    [self.bottomView resetViewWithModel:self.modelOrder];
    self.bottomView.bottom = SCREEN_HEIGHT - iphoneXBottomInterval- W(10);
    
    [self.midView resetViewWithModel:self.modelOrder];
    self.midView.bottom = self.bottomView.top;
    
    self.ivBottomBg.frame = CGRectInset(CGRectMake(W(10), self.midView.top, SCREEN_WIDTH-W(20), self.bottomView.bottom - self.midView.top), -W(10), -W(10));
}

#pragma mark request
- (void)operateClick{
    //装车
    if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD) {
        [self.upLoadImageView show];
        return;
    }
    //卸车
    //装车
    if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD) {
        [self.upUnLoadImageView show];
        return;
    }
    //判断地理位置权限
    if (![GlobalMethod fetchLocalAuthorityBlock:nil]) {
        return;
    }
    //接单
    ModelBtn * modelDismiss = [ModelBtn   modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    WEAKSELF
    modelConfirm.blockClick = ^(void){
        [weakSelf requestOperate:nil];
    };
    [BaseAlertView initWithTitle:@"提示" content:[NSString stringWithFormat:@"确认%@?",self.bottomView.btnOperate.titleLabel.text] aryBtnModels:@[modelDismiss,modelConfirm] viewShow:self.view];
}
- (void)requestOperate:(NSString *)url{
    
    [RequestApi requestOperateBulkCargoOrder:self.modelOrder.iDProperty operateType:self.modelOrder.operateType url:url delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
        [RequestApi requestBulkCargoDetailWithId:strDotF(self.modelOrder.iDProperty) delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.modelOrder = [ModelBulkCargoOrder modelObjectWithDictionary:response];
            [self reconfigView];
                        if (self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE||self.modelOrder.operateType == ENUM_BULKCARGO_ORDER_OPERATE_ARRIVE) {
//                            [GB_Nav popLastAndPushVC:^(){
//                                BulkCargoOrderDetailVC  * detailVC = [BulkCargoOrderDetailVC new];
//                                detailVC.modelOrder =self.modelOrder;
//                                return detailVC;
//                            }()];
            
                        }else{
                            WEAKSELF
                            [[LocationRecordInstance sharedInstance]upLocation:^{
                                [weakSelf requestDetail];
                            }];
                        }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDetail{
    [RequestApi requestBulkCargoDetailWithId:strDotF(self.modelOrder.iDProperty) delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelOrder = [ModelBulkCargoOrder modelObjectWithDictionary:response];
        [self requestTrick];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

-(void)requestTrick{
    if (!self.modelOrder.loadTime) {
        self.mapView.showsUserLocation = true;
        [self initLocation];
        return;
    }
    double finishTime = self.modelOrder.unloadTime?self.modelOrder.unloadTime:self.modelOrder.finishTime;
    [RequestApi requestCarLocationWithuploaderId:self.modelOrder.driverId startTime:self.modelOrder.loadTime endTime:finishTime?finishTime:[[NSDate date]timeIntervalSince1970] vehicleNumber:self.modelOrder.vehicleNumber  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryLocationRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelLocationItem"];
        [self drawLine:self.aryLocationRequest.mutableCopy];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        self.mapView.showsUserLocation = true;
        [self initLocation];
    } ];
    
}



#pragma mark line
- (void)drawLine:(NSMutableArray *)aryLocation{
    {//增加本地位置数据
        NSArray * aryGlobal = [GlobalData sharedInstance].aryLocations.copy;
        double finishTime = self.modelOrder.unloadTime?self.modelOrder.unloadTime:self.modelOrder.finishTime;
        if (!finishTime && isAry(aryGlobal)) {
            ModelLocationItem * itemNewest = aryLocation.firstObject;
            for (int i = 0; i<aryGlobal.count ; i++) {
                ModelAddress * item = [aryGlobal objectAtIndex:i];
                if (item.dateRecord > itemNewest.collectTime) {
                    for (int m = i; m<aryGlobal.count; m++) {
                        ModelAddress * itemAdd = [aryGlobal objectAtIndex:m];
                        [aryLocation insertObject:^(){
                            ModelLocationItem * modelAdd = [ModelLocationItem new];
                            modelAdd.lat = itemAdd.lat;
                            modelAdd.lng = itemAdd.lng;
                            modelAdd.collectTime = itemAdd.dateRecord;
                            return modelAdd;
                        }() atIndex:0];
                    }
                    break;
                }
            }
        }
    }
    if (!isAry(aryLocation)) {
        self.mapView.showsUserLocation = true;
        [self initLocation];
        return;
    }
    {
        ModelLocationItem *item = aryLocation.firstObject;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(item.lat, item.lng) animated:false];
        self.isMonitor = true;
    }
    
    //draw line
    CLLocationCoordinate2D commonPolylineCoords[aryLocation.count];
    for (int i = 0; i<aryLocation.count; i++) {
        ModelLocationItem *item = aryLocation[i];
        commonPolylineCoords[i].latitude = item.lat;
        commonPolylineCoords[i].longitude = item.lng;
    }
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:aryLocation.count];
    
    //在地图上添加折线对象
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView addOverlay:commonPolyline];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    //drwa end point annotation
    if (isAry(aryLocation)) {
        ModelLocationItem *item = aryLocation.firstObject;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(item.lat, item.lng);
        self.locationEnd = pointAnnotation.coordinate;
        [self.mapView addAnnotation:pointAnnotation];
    }
    
    //draw start point annotation
    ModelLocationItem *item = aryLocation.lastObject;
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(item.lat, item.lng);
    self.locationStart = pointAnnotation.coordinate;
    [self.mapView addAnnotation:pointAnnotation];
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView =  [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        if(annotation.coordinate.latitude == self.locationStart.latitude && annotation.coordinate.longitude == self.locationStart.longitude){
            annotationView.image =  [UIImage imageNamed:@"origin_map"];
        }
        if(annotation.coordinate.latitude == self.locationEnd.latitude && annotation.coordinate.longitude == self.locationEnd.longitude){
            annotationView.image =  [UIImage imageNamed:@"car_map"];
        }
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        //        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        polylineRenderer.strokeImage = [UIImage imageNamed:@"arrowTexture"];
        
        return polylineRenderer;
    }
    return nil;
}

#pragma mark map move listen
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    if (self.isMonitor && wasUserAction) {
        [self hideBottom];
    }
}
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction{
    if (self.isMonitor && wasUserAction) {
        [self hideBottom];
    }
}

- (void)hideBottom{
    if (!self.isBottomHide) {
        self.isBottomHide = true;
        [UIView animateWithDuration:0.3 animations:^{
            self.midView.top = SCREEN_HEIGHT - iphoneXBottomInterval- W(10) - W(55);
            self.midView.height = W(55);
            self.bottomView.top = self.midView.bottom;
            
            self.ivBottomBg.frame = CGRectInset(CGRectMake(W(10), self.midView.top, SCREEN_WIDTH-W(20), self.midView.height), -W(10), -W(10));
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)showBottom{
    if (self.isBottomHide) {
        self.isBottomHide = false;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomView.bottom = SCREEN_HEIGHT - iphoneXBottomInterval- W(10);
            [self.midView resetViewWithModel:self.modelOrder];
            self.midView.bottom = self.bottomView.top;
            self.ivBottomBg.frame = CGRectInset(CGRectMake(W(10), self.midView.top, SCREEN_WIDTH-W(20), self.bottomView.bottom - self.midView.top), -W(10), -W(10));
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark 选择图片
- (void)imagesSelect:(NSArray *)aryImages
{
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil fail:nil];
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

@end
