//
//  AutoConfigOrderListVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/11/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoConfigOrderListVC.h"
#import "AutoConfigOrderListCell.h"
//request
#import "RequestApi+Order.h"
//detail
#import "OrderDetailVC.h"
//operate
#import "DriverOperateVC.h"
//bottom view
#import "OrderManagementBottomView.h"
#import "AutoConfigDetailVC.h"

@interface AutoConfigOrderListVC ()
@property (nonatomic, strong) AutoConfigOrderListFilterView *filterView;
@property (nonatomic, strong) NSTimer *timer;

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
        _filterView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _filterView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addNav];
    [self.view addSubview:self.filterView];
    [self.tableView registerClass:[AutoConfigOrderListCell class] forCellReuseIdentifier:@"AutoConfigOrderListCell"];
    self.tableView.frame = CGRectMake(0, self.filterView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.filterView.bottom - TABBAR_HEIGHT);

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
    cell.blockDetail = ^(ModelOrderList *model) {
        [weakSelf jumpToDetail:model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AutoConfigOrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelOrderList * model = self.aryDatas[indexPath.row];
    [self jumpToDetail:model];
}
- (void)jumpToDetail:(ModelOrderList *)model{
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
    NSString * strOrderType = nil;
    int sortCreateTime = 1;
    int sortAcceptTime = 1;
    int sortFinishTime = 1;
    strOrderType = @"610";
              sortFinishTime = 3;
    [RequestApi requestOrderListWithWaybillnumber:nil
                                       categoryId:0
                                            state:strOrderType
                                         blNumber:0
                                 shippingLineName:nil
                                       oceanVesel:nil
                                     voyageNumber:nil
                                     startContact:nil
                                       startPhone:nil
                                       endContact:nil endPhone:nil closingStartTime:0 closingEndTime:0 placeEnvName:nil placeStartTime:0 placeEndTime:0 placeContact:nil createStartTime:0 createEndTime:0 acceptStartTime:0 acceptEndTime:0 finishStartTime:0 finishEndTime:0 stuffStartTime:0 stuffEndTime:0 toFactoryStartTime:0 toFactoryEndTime:0 handleStartTime:0 handleEndTime:0
                                             page:self.pageNum
                                            count:50
                                            entId:0
                                   sortAcceptTime:sortAcceptTime
                                   sortFinishTime:sortFinishTime
                                   sortCreateTime:sortCreateTime
                                         delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelOrderList"];
        
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

@end

