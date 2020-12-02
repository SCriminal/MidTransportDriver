//
//  DriverOperateVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "DriverOperateVC.h"
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
#import "DriverOperateView.h"
//deck view
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
//request
#import "RequestApi+Order.h"
#import "RequestApi+Location.h"
//order management vc
#import "OrderDetailVC.h"
//inputView
#import "InputNumView.h"
#import "InputPlumbumNumView.h"
//alert view
#import "TopAlertView.h"
//share
#import "ShareView.h"
//account list
#import "OrderAccountListVC.h"
//upimage
#import "AliClient.h"
//location
#import "LocationRecordInstance.h"
//猎鹰
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapTrackKit/AMapTrackKit.h>

@interface DriverOperateVC ()<MAMapViewDelegate,AMapTrackManagerDelegate,NSURLSessionDelegate>
//地图
@property (nonatomic,strong) MAMapView *mapView;
//top view
@property (nonatomic, strong) DriverOperateTopView *topView;
//mid view
@property (nonatomic, strong) DriverOperateMidView *midView;
//bottom view
@property (nonatomic, strong) DriverOperateBottomView *bottomView;
//input view
@property (nonatomic, strong) InputNumView *inputPackageNoView;
@property (nonatomic, strong) InputPlumbumNumView *inputPlumbumNumView;
@property (strong, nonatomic) UIImageView *ivBottomBg;
@property (nonatomic, strong) NSArray *aryGoods;
@property (nonatomic, assign) BOOL isInputSealNum;
//location
@property (nonatomic, assign) CLLocationCoordinate2D locationStart;
@property (nonatomic, assign) CLLocationCoordinate2D locationEnd;
@property (nonatomic, strong) AMapTrackManager *trackManager;
@property (nonatomic, strong) NSMutableArray *aryLocationRequest;

//hide animation
@property (nonatomic, assign) BOOL isMonitor;
@property (nonatomic, assign) BOOL isBottomHide;

@end

@implementation DriverOperateVC
#pragma mark lazy init

- (UIImageView *)ivBottomBg{
    if (_ivBottomBg == nil) {
        _ivBottomBg = [UIImageView new];
        _ivBottomBg.image =IMAGE_WHITE_BG;
    }
    return _ivBottomBg;
}
- (AMapTrackManager *)trackManager{
    if (!_trackManager) {
        AMapTrackManagerOptions *option = [[AMapTrackManagerOptions alloc] init];
        option.serviceID = @"52936"; //Service ID 需要根据需要进行修改
        //初始化AMapTrackManager
        _trackManager = [[AMapTrackManager alloc] initWithOptions:option];
        _trackManager.delegate = self;
        //配置定位属性
        [_trackManager setAllowsBackgroundLocationUpdates:YES];
        [_trackManager setPausesLocationUpdatesAutomatically:NO];
    }
    return _trackManager;
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
- (InputNumView *)inputPackageNoView{
    if (!_inputPackageNoView) {
        _inputPackageNoView = [InputNumView new];
        WEAKSELF
        _inputPackageNoView.blockComplete = ^(ModelPackageInfo * modelSelected) {
            [weakSelf reqeustInputPackageNum:modelSelected];
        };
        _inputPackageNoView.blockORCClick = ^{
            weakSelf.isInputSealNum = false;
            [weakSelf showImageVC:1];
        };
    }
    return _inputPackageNoView;
}
- (InputPlumbumNumView *)inputPlumbumNumView{
    if (!_inputPlumbumNumView) {
        _inputPlumbumNumView = [InputPlumbumNumView new];
        WEAKSELF
        _inputPlumbumNumView.blockComplete = ^(ModelPackageInfo * modelSelected) {
            [weakSelf reqeustInputPackageNum:modelSelected];
        };
        _inputPlumbumNumView.blockORCClick = ^{
            weakSelf.isInputSealNum = true;
            [weakSelf showImageVC:1];
        };
    }
    return _inputPlumbumNumView;
}

- (DriverOperateTopView *)topView{
    if (!_topView) {
        _topView = [DriverOperateTopView new];
        _topView.top = 0;
        [_topView resetViewWithModel:self.modelOrder];
        WEAKSELF
        _topView.blockClick = ^{
            [ShareView show:weakSelf.modelOrder];
        };
    }
    return _topView;
}
- (DriverOperateMidView  *)midView{
    if (!_midView) {
        _midView = [DriverOperateMidView new];
        [_midView resetViewWithModel:self.modelOrder];
        WEAKSELF
        _midView.blockBottomClick = ^{
            [weakSelf showBottom];
        };
    }
    return _midView;
}
- (DriverOperateBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [DriverOperateBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        [_bottomView resetViewWithModel:self.modelOrder];
        _bottomView.blockInputPlumbumNoNoClick = ^{
            if (weakSelf.modelOrder.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE ||weakSelf.modelOrder.operateType == ENUM_ORDER_OPERATE_BACK_PACKAGE|| weakSelf.modelOrder.operateType == ENUM_ORDER_OPERATE_COMPLETE) {
                [GlobalMethod showAlert:@"当前状态不可录入铅封号"];
                return ;
            }
            [weakSelf.inputPlumbumNumView showWithAry:weakSelf.aryGoods];
        };
        _bottomView.blockInputPackageNoClick = ^{
            if (weakSelf.modelOrder.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE ||weakSelf.modelOrder.operateType == ENUM_ORDER_OPERATE_BACK_PACKAGE|| weakSelf.modelOrder.operateType == ENUM_ORDER_OPERATE_COMPLETE) {
                [GlobalMethod showAlert:@"当前状态不可录入箱号"];
                return ;
            }
            [weakSelf.inputPackageNoView showWithAry:weakSelf.aryGoods];
        };
        _bottomView.blockDetailClick = ^{
            OrderDetailVC * detailVC = [OrderDetailVC new];
            detailVC.modelOrder = weakSelf.modelOrder;
            [GB_Nav pushViewController:detailVC animated:true];
        };
        
        _bottomView.blockInputAccountClick = ^{
            if (weakSelf.modelOrder.operateType == ENUM_ORDER_OPERATE_WAIT_RECEIVE ) {
                [GlobalMethod showAlert:@"当前状态不可记账"];
                return ;
            }
            OrderAccountListVC * vc = [OrderAccountListVC new];
            vc.modelOrder = weakSelf.modelOrder;
            [GB_Nav pushViewController:vc animated:true];
        };
        _bottomView.blockOperateClick = ^{
            //判断地理位置权限
            if (![GlobalMethod fetchLocalAuthorityBlock:nil]) {
                return;
            }
            ModelBtn * modelDismiss = [ModelBtn   modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
            modelConfirm.blockClick = ^(void){
                [weakSelf requestOperate];
            };
            [BaseAlertView initWithTitle:@"提示" content:[NSString stringWithFormat:@"确认%@?",weakSelf.bottomView.btnOperate.titleLabel.text] aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];

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
    //request goods
//    [self track];
    [self requestGoodsInfo];
//detail
    [self requestDetail];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reconfigView) name:NOTICE_SELFMODEL_CHANGE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

    if (!self.modelOrder.finishTime) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestTrick) name:NOTICE_LOCATION_UP_SUCCESS object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationChange) name:NOTICE_LOCATION_CHANGE object:nil];
    }
}

#pragma mark location
- (void)resignActive{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTICE_LOCATION_UP_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTICE_LOCATION_CHANGE object:nil];

}
- (void)becomeActive{
    if (!self.modelOrder.finishTime) {
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
- (void)requestDetail{
    [RequestApi requestOrderDetailWithId:self.modelOrder.iDProperty  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelOrder = [ModelOrderList modelObjectWithDictionary:response];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestOperate{
    
    [RequestApi requestOperateOrder:self.modelOrder.iDProperty operateType:self.modelOrder.operateType delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
#ifdef UP_TRANSPORT
        //如果是提箱则开启l地理位置
        if (self.modelOrder.operateType == ENUM_ORDER_OPERATE_BACK_PACKAGE) {
            [[LocationRecordInstance sharedInstance]startLocationWithShippingNoteInfos:@[self.modelOrder] listener:^(id model, NSError *error) {
                
            }];
        }else if(self.modelOrder.operateType == ENUM_ORDER_OPERATE_RETURN_PACKAGE){
            [[LocationRecordInstance sharedInstance]stopLocationWithShippingNoteInfos:@[self.modelOrder] listener:^(id model, NSError *error) {
                
            }];
        }
#endif
        [RequestApi requestOrderDetailWithId:self.modelOrder.iDProperty  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            self.modelOrder = [ModelOrderList modelObjectWithDictionary:response];
//            if (self.modelOrder.operateType == ENUM_ORDER_OPERATE_COMPLETE) {
//                [GB_Nav popLastAndPushVC:^(){
//                    OrderDetailVC  * detailVC = [OrderDetailVC new];
//                    detailVC.modelOrder =self.modelOrder;
//                    return detailVC;
//                }()];
//            }else{
                [self reconfigView];
                WEAKSELF
                [[LocationRecordInstance sharedInstance]upLocation:^{
                    [weakSelf requestGoodsInfo];
                }];
//            }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
- (void)requestGoodsInfo{
    [RequestApi requestGoosListWithId:self.modelOrder.iDProperty entID:self.modelOrder.shipperId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryGoods = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageInfo"];
        [self requestTrick];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)reqeustInputPackageNum:(ModelPackageInfo *)modelPackage{
    [RequestApi requestInputPackageNumWithWaybillcargoid:modelPackage.cargoId containerNumber:modelPackage.containerNumber sealNumber:modelPackage.sealNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"上传成功"];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

-(void)requestTrick{
    ModelPackageInfo * modelPackage = self.aryGoods.lastObject;
    if (!modelPackage.stuffTime) {
        self.mapView.showsUserLocation = true;
        [self initLocation];
        return;
    }
    [RequestApi requestCarLocationWithuploaderId:modelPackage.driverUserId startTime:modelPackage.stuffTime endTime:modelPackage.finishTime?modelPackage.finishTime:[[NSDate date]timeIntervalSince1970] vehicleNumber:modelPackage.truckNumber  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
        if (!self.modelOrder.finishTime && isAry(aryGlobal)) {
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
    }
    self.isMonitor = true;
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
    [self.mapView addOverlay: commonPolyline];
    
    
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
#pragma mark image select
- (void)imageSelect:(BaseImage *)image{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_ORDER;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:nil upHighQualitySuccess:^{
        [self orc:image.imageURL];
    } fail:^{
        
    }];
}

- (void)orc:(NSString *)imageurl{
    //    [GB_Nav pushVCName:@"MainBlackVC" animated:true];
    NSString *appcode = @"e5125b82866442b8ab5ecaa2a6caa89f";
    NSString *host = @"https://ocrapi-advanced.taobao.com";
    NSString *path = @"/ocrservice/advanced";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = [NSString stringWithFormat:@"{\"url\":\"%@\",\"prob\":false,\"charInfo\":false,\"rotate\":false,\"table\":false}",imageurl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];

    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       NSDictionary * dic = [GlobalMethod exchangeStringToDic:bodyString];
                                                       NSArray * aryAll = [dic arrayValueForKey:@"prism_wordsInfo"];
                                                       NSMutableArray * aryStrings = [NSMutableArray array];
                                                       NSString * strReturn = nil;
                                                       for (NSDictionary * dicWord in aryAll) {
                                                          NSString * strWord = [dicWord stringValueForKey:@"word"];
                                                           if (isStr(strWord)&& strWord.length > 3) {
                                                               strReturn = strWord;
                                                               break;
                                                           }
                                                           if ([aryAll indexOfObject:dicWord]<5) {
                                                               [aryStrings addObject:strWord];
                                                           }
                                                       }
                                                       if (!isStr(strReturn)) {
                                                           strReturn = [aryStrings componentsJoinedByString:@""];
                                                       }
                                                       if (isStr(strReturn)) {
                                                           [GlobalMethod mainQueueBlock:^{
                                                               if (self.isInputSealNum) {
                                                                   self.inputPlumbumNumView.tfNum.text = strReturn;
                                                               }else{
                                                                   self.inputPackageNoView.tfNum.text = strReturn;
                                                               }
                                                           }];
                                                       }else{
                                                           [GlobalMethod mainQueueBlock:^{
                                                               [GlobalMethod showAlert:@"图片解析失败"];
                                                           }];
                                                       }
                                                   }];
    [task resume];
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}

@end
