//
//  AutoConfigOrderListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/11/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoConfigOrderListVC.h"
#import "AutoConfigOrderListCell.h"
//detail
#import "OrderDetailVC.h"
//bottom view
#import "OrderManagementBottomView.h"
#import "AutoConfigDetailVC.h"
//list view
#import "ListAlertView.h"
#import "AutoConfigOrderListFilterView.h"
//request
#import "RequestDriver2.h"
#import "SelectDistrictView.h"
#import "BaseVC+Location.h"
#import "AuthOneVC.h"
#import "AutoConfigRobView.h"
#import "RequestInstance.h"
#import "CustomTabBarController.h"

@interface AutoConfigOrderListVC ()
@property (nonatomic, strong) AutoConfigOrderListFilterView *filterView;
@property (nonatomic, strong) AutoConfigOrderListAutoFilterView *topView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) ModelProvince *areaStart;
@property (nonatomic, strong) ModelProvince *areaEnd;
@property (nonatomic, strong) NSMutableDictionary *dicComments;
@property (nonatomic, strong) ModelAuthCar *modelCarInfo;
@property (nonatomic, strong) ModelAutOrderListItem *modelList;
@property (nonatomic, assign) NSInteger orderTypeIndex;
@property (nonatomic, assign) BOOL isRequestSuccess;
@end

@implementation AutoConfigOrderListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
    }
    return _noResultView;
}
- (NSMutableDictionary *)dicComments{
    if (!_dicComments) {
        _dicComments = [NSMutableDictionary new];
    }
    return _dicComments;
}
- (AutoConfigOrderListFilterView *)filterView{
    if (!_filterView) {
        _filterView = [AutoConfigOrderListFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSInteger carType, NSInteger orderType) {
            weakSelf.orderTypeIndex = orderType;
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterView;
}
- (AutoConfigOrderListAutoFilterView *)topView{
    if (!_topView) {
        _topView = [AutoConfigOrderListAutoFilterView new];
        _topView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _topView.blockStart = ^{
            SelectDistrictView * selectView = [SelectDistrictView new];
            selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                weakSelf.areaStart = area;
                [weakSelf.topView reconfigStart:area];
                [weakSelf refreshHeaderAll];
            };
            selectView.blockDismiss = ^{
                weakSelf.areaStart = nil;
                [weakSelf.topView reconfigStart:nil];
                [weakSelf refreshHeaderAll];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        };
        _topView.blockEnd = ^{
            SelectDistrictView * selectView = [SelectDistrictView new];
            selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                weakSelf.areaEnd = area;
                [weakSelf.topView reconfigEnd:area];
                [weakSelf refreshHeaderAll];
            };
            selectView.blockDismiss = ^{
                weakSelf.areaEnd = nil;
                [weakSelf.topView reconfigEnd:nil];
                [weakSelf refreshHeaderAll];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        };
        _topView.blockAuto = ^{
            [GlobalMethod endEditing];
            ListAlertView * listNew = [ListAlertView new];
            listNew.indexSelected = weakSelf.topView.indexSelected;
            NSMutableArray * aryTitle = @[@"智能排序",@"时间排序",@"距离排序"].mutableCopy;
            [listNew showWithPoint:CGPointMake(0, weakSelf.topView.bottom)  width:SCREEN_WIDTH  ary:aryTitle];
            listNew.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                listNew.alpha = 1;
            }];
            listNew.blockSelected = ^(int index) {
                switch (index) {
                    case 0:
                        weakSelf.topView.labelAuto.text = @"智能";
                        break;
                    case 1:
                        weakSelf.topView.labelAuto.text = @"时间";
                        break;
                    case 2:
                        weakSelf.topView.labelAuto.text = @"距离";
                        break;
                    default:
                        break;
                }
                weakSelf.topView.indexSelected = index;
                [weakSelf refreshHeaderAll];
            };
        };
        _topView.blockFilter = ^{
            [weakSelf.filterView show];
        };
        _topView.blockVoice = ^{
            
        };
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNav];
    [self.view addSubview:self.topView];
    [self.tableView registerClass:[AutoConfigOrderListCell class] forCellReuseIdentifier:@"AutoConfigOrderListCell"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timerStop) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timerStart) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_AUTOORDER_REFERSH object:nil];

    self.tableView.frame = CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.topView.bottom - TABBAR_HEIGHT);
    self.tableView.tableHeaderView = ^(){
        UIView * v = [UIView new];
        v.backgroundColor = COLOR_BACKGROUND;
        v.widthHeight = XY(SCREEN_WIDTH, W(12));
        return v;
    }();
    self.tableView.backgroundColor = COLOR_BACKGROUND;
//    self.tableView.contentInset = UIEdgeInsetsMake(W(12), 0, 0, 0);
    [self addRefreshHeader];
    [self addRefreshFooter];
}
- (void)addNav{
    //table

    BaseNavView * nav = [BaseNavView initNavTitle:@"智能配货" leftImageName:@"nav_auto" leftImageSize:CGSizeMake(W(25), W(25)) leftBlock:^{
        [GB_Nav pushVCName:@"MyMsgVC" animated:true];

    } rightTitle:@"我的报价" righBlock:^{
        [GB_Nav pushVCName:@"MyPriceOrderListManagementVC" animated:true];
    }];
    [nav configBlueStyle];
    [self.view addSubview:nav];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestExtendToken) name:NOTICE_EXTENDTOKEN object:nil];

    [self initLocation];


}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoConfigOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AutoConfigOrderListCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDetail = ^(ModelAutOrderListItem *model) {
        weakSelf.modelList = model;
        [weakSelf requestCarInfo];
    };
    cell.blockOutTime = ^(AutoConfigOrderListCell *c) {
        if ([weakSelf.aryDatas containsObject:c.model]) {
            [weakSelf.aryDatas removeObject:c.model];
            [weakSelf.tableView reloadData];
        }
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AutoConfigOrderListCell fetchHeight:[self.aryDatas safe_objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelAutOrderListItem * model = self.aryDatas[indexPath.row];
    [self jumpToDetail:model];
}
- (void)jumpToDetail:(ModelAutOrderListItem *)model{
    AutoConfigDetailVC * operateVC = [AutoConfigDetailVC new];
    operateVC.modelList = model;
    WEAKSELF
    operateVC.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll]        ;
    };
    [GB_Nav pushViewController:operateVC animated:true];
}
#pragma mark request
- (void)requestList{
   
    ModelAddress * location = [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
    [RequestApi requestAutoOrderListWithMode:self.orderTypeIndex?NSNumber.dou(self.orderTypeIndex).stringValue:nil startAreaId:NSNumber.dou(self.areaStart.iDProperty).stringValue endAreaId:NSNumber.dou(self.areaEnd.iDProperty).stringValue createStartTime:0 createEndTime:0 page:self.pageNum count:20 lat:NSNumber.dou(location.lat).stringValue lng:NSNumber.dou(location.lng).stringValue sort:self.topView.indexSelected+1 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.isRequestSuccess = true;
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAutOrderListItem"];
        for (ModelAutOrderListItem * item in aryRequest.copy) {
            int interval = [item.dateStart timeIntervalSinceNow];
                if(interval<=0  || item.storageQty == 0){
                    [aryRequest removeObject:item];
                }
        }
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
        if (self.aryDatas.count == 0) {
            [self requestPath];
        }
        [self requestCommentList];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            if (self.aryDatas.count == 0) {
                [self requestPath];
            }
        }];
   
}
- (void)requestPath{
    [RequestApi requestPathListDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryPath = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelPathListItem"];
        [self pathRequested:aryPath];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            [self pathRequested:nil];
        }];
}
- (void)pathRequested:(NSArray *)aryPath{
    [self.noResultView removeFromSuperview];
    if (aryPath.count == 0) {
        [self.noResultView removeAllSubViews];
        {
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:@"empty_auto"];
            iv.widthHeight = XY(W(162),W(120));
            iv.centerXTop = XY(SCREEN_WIDTH/2.0,W(90));
            [self.noResultView addSubview:iv];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"您还未添加常运路线！" variable:SCREEN_WIDTH];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(260));
            [self.noResultView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"添加后平台自动为您推送匹配路线货源" variable:SCREEN_WIDTH];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(284));
            [self.noResultView addSubview:l];
        }
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY(W(315), W(39));
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:@"+ 添加常用路线" forState:UIControlStateNormal];
            btn.titleLabel.fontNum = F(15);
            [btn setTitleColor:COLOR_RED forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
            [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:COLOR_RED];
            btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(348));
            [self.noResultView addSubview:btn];
        }
    }else{
        self.noResultView = [NoResultView new];
        [self.noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无数据"];
    }
    [self showNoResult];
}
-  (void)requestCarInfo{
    [RequestApi requestCarAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthCar * model = [ModelAuthCar modelObjectWithDictionary:response];
        self.modelCarInfo = model;
        if (!model.vehicleId) {
            ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"立即提交" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
            modelConfirm.blockClick = ^(void){
                AuthOneVC * vc = [AuthOneVC new];
                vc.isFirst = true;
                [GB_Nav pushViewController:vc animated:true];
            };
            [BaseAlertView initWithTitle:@"提示" content:@"请先提交车辆信息" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
            return;
        }
        WEAKSELF
        if (self.modelList.mode == 1) {
            //抢单
            AutoConfigRobView * robView = [AutoConfigRobView new];
            robView.modelCarInfo = model;
            robView.blockConfirm = ^(double weight, double price) {
                [weakSelf requestRobe:price weight:weight];
            };
            [robView resetViewWithModel:self.modelList];
            [[UIApplication sharedApplication].keyWindow addSubview:robView];
        }else{
            //报价
            AutoConfigOfferPriceView * robView = [AutoConfigOfferPriceView new];
            robView.modelCarInfo = model;
            robView.blockConfirm = ^(double weight, double price) {
                [weakSelf requestPrice:price weight:weight];
            };
            [robView resetViewWithModel:self.modelList];
            [[UIApplication sharedApplication].keyWindow addSubview:robView];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestPrice:(double)price weight:(double)weight{
    
    [RequestApi requestPlanPriceWithPlannumber:self.modelList.planNumber vehicleId:self.modelCarInfo.vehicleId qty:[self.modelList exchangeRequestQty:weight] price:price*100.0  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"报价成功"];
        [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
   
}
- (void)requestRobe:(double)price weight:(double)weight{
    [RequestApi requestRobWithPlannumber:self.modelList.planNumber vehicleId:self.modelCarInfo.vehicleId qty:[self.modelList exchangeRequestQty:weight] price:price*100.0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"抢单成功"];
        [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
   
}

- (void)requestCommentList{
    NSMutableArray * ary = [NSMutableArray array];
    for (ModelAutOrderListItem * modelItem in self.aryDatas) {
        if (!isStr(modelItem.comment)) {
            if (modelItem.shipperId) {
                [ary addObject:NSNumber.dou(modelItem.shipperId).stringValue];
            }
        }
    }
    [RequestApi requestCommentListWithUserIds:[ary componentsJoinedByString:@","] delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelComment"];
        for (ModelComment * item in ary) {
            [self.dicComments setObject:item forKey:NSNumber.dou(item.userId).stringValue];
        }
        for (ModelAutOrderListItem * item in self.aryDatas) {
            if (!isStr(item.comment)) {
                ModelComment * comment = [self.dicComments objectForKey:NSNumber.dou(item.shipperId).stringValue];
                if (comment.userId) {
                    item.comment = [NSString stringWithFormat:@"%@      成交量：%@      好评率：%@",comment.cellphone.secretPhone,NSNumber.dou(comment.finishWaybillSum).stringValue,comment.praiseRateShow];
                }
            }
        }
        [self.tableView reloadData];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//btn click
- (void)btnAddClick{
    [GB_Nav pushVCName:@"AddPathVC" animated:true];
}
- (void)fetchAddress{
    if (!self.isRequestSuccess) {
        [self refreshHeaderAll];
    }
}

#pragma mark 定时器相关
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self timerStart];
    [self refreshHeaderAll];
}

- (void)requestExtendToken{
    static int requestSuccess = 0;
    if (requestSuccess) {
        return;
    }
    if (![GlobalMethod isLoginSuccess]) {
        requestSuccess = 1;
        return;
    }
    if ([RequestInstance sharedInstance].tasks.count == 0) {
        requestSuccess = 1;
        [RequestApi requestRefreshTokenDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSString * token = [response stringValueForKey:@"token"];
            if (isStr(token)) {
                [GlobalData sharedInstance].GB_Key = token;
                [GlobalData sharedInstance].GB_REFRESH_TOKEN =  [response stringValueForKey:@"refreshToken"];
            }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

        }];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self timerStop];
}
- (void)timerStart{
    //开启定时器
    CustomTabBarController * vc = (CustomTabBarController *)GB_Nav.lastVC;
    if([vc isKindOfClass:CustomTabBarController.class]){
        if([[vc selectedViewController]isEqual:self]){
            if (_timer == nil) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:true];
            }
        }
    }
   
}
- (void)timerRun{
    NSLog(@"time run sld");
    if (self.aryDatas.count) {
        for (AutoConfigOrderListCell * cell in self.tableView.visibleCells) {
            [cell.timeView resetTime];
        }

    }
}
- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}
@end

@implementation NewAutoConfigOrderListVC

- (void)addNav{
    //table
    BaseNavView * nav = [BaseNavView initNavTitle:@"最新货源" leftImageName:@"nav_auto" leftImageSize:CGSizeMake(W(25), W(25)) leftBlock:^{
        [GB_Nav pushVCName:@"MyMsgVC" animated:true];

    } rightTitle:@"我的报价" righBlock:^{
        [GB_Nav pushVCName:@"MyPriceOrderListManagementVC" animated:true];
    }];
    [nav configBlueStyle];
    [self.view addSubview:nav];
    
//    self.topView.blockFilter = nil;
}
- (void)requestList{
    
    ModelAddress * location = [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
    [RequestApi requestNewOrderListWithStartareaid:self.areaStart.iDProperty endAreaId:self.areaEnd.iDProperty page:self.pageNum count:20 vehicleTypeId:0 mode:self.orderTypeIndex?:0 lat:NSNumber.dou(location.lat).stringValue lng:NSNumber.dou(location.lng).stringValue sort:self.topView.indexSelected+1                           vehicleTypeCode:nil
 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.isRequestSuccess = true;
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAutOrderListItem"];
        for (ModelAutOrderListItem * item in aryRequest.copy) {
            int interval = [item.dateStart timeIntervalSinceNow];
            if(interval<=0 || item.storageQty == 0){
                    [aryRequest removeObject:item];
                }
        }
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
        [self requestCommentList];
        if (self.aryDatas.count == 0) {
            [self requestPath];
        }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            if (self.aryDatas.count == 0) {
                [self requestPath];
            }
        }];
   
   
}

- (void)requestPath{
    [self pathRequested:nil];
}
- (void)pathRequested:(NSArray *)aryPath{
    [self.noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无数据"];
    [self showNoResult];
}
@end

