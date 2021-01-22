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
//operate
#import "DriverOperateVC.h"
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
@interface AutoConfigOrderListVC ()
@property (nonatomic, strong) AutoConfigOrderListFilterView *filterView;
@property (nonatomic, strong) AutoConfigOrderListAutoFilterView *topView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) ModelProvince *areaStart;
@property (nonatomic, strong) ModelProvince *areaEnd;

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
        [_noResultView removeAllSubViews];
        {
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:@"empty_auto"];
            iv.widthHeight = XY(W(162),W(120));
            iv.centerXTop = XY(SCREEN_WIDTH/2.0,W(90));
            [_noResultView addSubview:iv];
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
            [_noResultView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"添加后平台自动为您推送匹配路线资源" variable:SCREEN_WIDTH];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(284));
            [_noResultView addSubview:l];
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
            [_noResultView addSubview:btn];
        }
    }
    return _noResultView;
}
- (AutoConfigOrderListFilterView *)filterView{
    if (!_filterView) {
        _filterView = [AutoConfigOrderListFilterView new];
        _filterView.blockSearchClick = ^(NSInteger carType, NSInteger orderType) {
            
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
            [[UIApplication sharedApplication].keyWindow addSubview:selectView];
        };
        _topView.blockEnd = ^{
            SelectDistrictView * selectView = [SelectDistrictView new];
            selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                weakSelf.areaEnd = area;
                [weakSelf.topView reconfigEnd:area];
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
            listNew.blockSelected = ^(NSInteger index) {
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
   
    [self initLocation];
    [self addNav];
    [self.view addSubview:self.topView];
    [self.tableView registerClass:[AutoConfigOrderListCell class] forCellReuseIdentifier:@"AutoConfigOrderListCell"];
    self.tableView.frame = CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.topView.bottom - TABBAR_HEIGHT);

    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(12), 0);
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}
- (void)addNav{
    //table
    BaseNavView * nav = [BaseNavView initNavTitle:@"智能配货" leftImageName:@"nav_auto" leftImageSize:CGSizeMake(W(23), W(23)) leftBlock:^{
        
    } rightTitle:@"我的报价" righBlock:^{
        
    }];
    [nav configBlueStyle];
    [self.view addSubview:nav];
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
//    [cell.newsView timerStart];
    
    WEAKSELF
    cell.blockDetail = ^(ModelAutOrderListItem *model) {
        [weakSelf jumpToDetail:model];
    };
    cell.blockOutTime = ^(AutoConfigOrderListCell *c) {
        [weakSelf.aryDatas removeObject:c.model];
        [weakSelf.tableView reloadData];
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
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:operateVC animated:true];
}
#pragma mark request
- (void)requestList{
    
    ModelAddress * location = [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
    [RequestApi requestAutoOrderListWithMode:nil startAreaId:NSNumber.dou(self.areaStart.iDProperty).stringValue endAreaId:NSNumber.dou(self.areaEnd.iDProperty).stringValue createStartTime:0 createEndTime:0 page:self.pageNum count:20 lat:NSNumber.dou(location.lat).stringValue lng:NSNumber.dou(location.lng).stringValue sort:self.topView.indexSelected+1 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.isRequestSuccess = true;
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAutOrderListItem"];
        
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
    [super viewWillAppear:animated];
    [self timerStart];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self timerStop];
}
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
}
- (void)timerRun{
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
    BaseNavView * nav = [BaseNavView initNavTitle:@"最新货源" leftImageName:@"nav_auto" leftImageSize:CGSizeMake(W(23), W(23)) leftBlock:^{
        
    } rightTitle:@"我的报价" righBlock:^{
        
    }];
    [nav configBlueStyle];
    [self.view addSubview:nav];
}
- (void)requestList{
    
    ModelAddress * location = [GlobalMethod readModelForKey:LOCAL_LOCATION_UPTODATE modelName:@"ModelAddress" exchange:false];
    [RequestApi requestNewOrderListWithStartareaid:self.areaStart.iDProperty endAreaId:self.areaEnd.iDProperty page:self.pageNum count:20 vehicleTypeId:0 mode:0 lat:NSNumber.dou(location.lat).stringValue lng:NSNumber.dou(location.lng).stringValue sort:self.topView.indexSelected+1                           vehicleTypeCode:nil
 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.isRequestSuccess = true;
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAutOrderListItem"];
        
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

