//
//  AutoConfigDetailVC.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/1.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoConfigDetailVC.h"
#import "AutoConfigTimeView.h"
#import "NSDate+YYAdd.h"
#import "AutoConfigRobView.h"
//request
#import "RequestDriver2.h"
#import "AuthOneVC.h"
@interface AutoConfigDetailVC ()
@property (nonatomic, strong) AutoConfigTimeView *timeView;
@property (nonatomic, strong) AutoConfigDetailView *topView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) ModelAuthCar *modelCarInfo;

@end

@implementation AutoConfigDetailVC
- (AutoConfigTimeView *)timeView{
    if (!_timeView) {
        _timeView = [AutoConfigTimeView new];
        _timeView.date = [GlobalMethod exchangeTimeStampToDate:self.modelList.startTime];
        WEAKSELF
        _timeView.blockOutTime = ^{
            [GlobalMethod showAlert:@"倒计时结束"];
            [GB_Nav popViewControllerAnimated:true];
        };
        _timeView.blockClick = ^{
            [weakSelf requestCarInfo];
        };
        [_timeView resetView:self.modelList.mode];
    }
    return _timeView;
}
- (AutoConfigDetailView *)topView{
    if (!_topView) {
        _topView = [AutoConfigDetailView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    {
        UIView * view = [UIView new];
        view.widthHeight = XY(SCREEN_WIDTH, self.timeView.height + W(20) + iphoneXBottomInterval);
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:self.timeView];
        self.timeView.centerXTop = XY(SCREEN_WIDTH/2.0, W(10));
        view.bottom = SCREEN_HEIGHT;
        [self.view addSubview:view];
        self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - view.height;
    }
    [self.topView resetViewWithModel:self.modelList];
    [self.timeView resetTime];
    
    self.tableView.tableHeaderView = self.topView;
    
    //table
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"配货详情" rightView:nil];
    [nav configBackBlueStyle];
    [self.view addSubview:nav];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark request
- (void)requestList{
    [RequestApi requestPlanDetailWithNumber:self.modelList.planNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAutOrderListItem * orderDetail = [ModelAutOrderListItem modelObjectWithDictionary:response];
        orderDetail.comment = self.modelList.comment;
        self.modelList = orderDetail;
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
}

-  (void)requestCarInfo{
    [RequestApi requestCarAuthDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthCar * model = [ModelAuthCar modelObjectWithDictionary:response];
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
            [self.view addSubview:robView];
        }else{
            //报价
            AutoConfigOfferPriceView * robView = [AutoConfigOfferPriceView new];
            robView.modelCarInfo = model;
            robView.blockConfirm = ^(double weight, double price) {
                [weakSelf requestPrice:price weight:weight];
            };
            [robView resetViewWithModel:self.modelList];
            [self.view addSubview:robView];
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
    [RequestApi requestRobWithPlannumber:self.modelList.planNumber vehicleId:self.modelCarInfo.vehicleId qty:[self.modelList exchangeRequestQty:weight] price:price delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"抢单成功"];
        [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
   
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
    [self.timeView resetTime];
}
- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}
@end



@implementation AutoConfigDetailView
- (AutoNewsView *)newsView{
    if (!_newsView) {
        _newsView = [AutoNewsView new];
    }
    return _newsView;
}
- (UILabel *)addressFrom{
    if (_addressFrom == nil) {
        _addressFrom = [UILabel new];
        _addressFrom.textColor = COLOR_333;
        _addressFrom.numberOfLines = 1;
        _addressFrom.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _addressFrom;
}
- (UILabel *)addressTo{
    if (_addressTo == nil) {
        _addressTo = [UILabel new];
        _addressTo.textColor = COLOR_333;
        _addressTo.numberOfLines = 1;
        _addressTo.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _addressTo;
}
- (UIImageView *)iconAddress{
    if (_iconAddress == nil) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"right_balck"];
        iv.widthHeight = XY(W(17),W(17));
        _iconAddress = iv;
    }
    return _iconAddress;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubview:self.addressFrom];
        [self addSubview:self.addressTo];
        [self addSubview:self.iconAddress];
        [self addSubview:self.newsView];
        
    }
    return self;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAutOrderListItem *)modelPlan{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
    
    [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(modelPlan.startCityName),UnPackStr(modelPlan.startCountyName)] variable:W(160)];
    self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(modelPlan.endCityName),UnPackStr(modelPlan.endCountyName)] variable:W(160)];
    self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
    
    CGFloat top = self.iconAddress.bottom + W(20);
    self.newsView.centerXTop = XY(SCREEN_WIDTH/2.0, top);
    self.newsView.hidden = true;
    if (isStr(modelPlan.comment)) {
        self.newsView.hidden = false;
        self.newsView.centerXTop = XY(SCREEN_WIDTH/2.0, top);
        [self.newsView resetWithAry:@[modelPlan.comment]];
        top = self.newsView.bottom + W(20);
    }
    
    NSMutableArray * ary = [NSMutableArray new];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"配货编号：";
        model.subTitle = modelPlan.planNumber;
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发货量：";
        model.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(modelPlan.qtyShow).stringValue,modelPlan.unitShow];
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"剩余量：";
        model.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(modelPlan.remainShow).stringValue,modelPlan.unitShow];
        model.isSelected = true;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"货物名称：";
        model.subTitle = modelPlan.cargoName;
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"单价：";
        model.subTitle = [NSString stringWithFormat:@"%@元/%@",NSNumber.dou(modelPlan.priceShow).stringValue,modelPlan.unitShow];
        model.isSelected = true;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"距离：";
        model.subTitle = isStr(modelPlan.distanceShow)?[NSString stringWithFormat:@"约%@装货",modelPlan.distanceShow]:@"未知";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车型要求：";
        model.subTitle = modelPlan.vehicleDescription;
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车长要求：";
        model.subTitle = modelPlan.carLenthSHow;
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"补充说明：";
        model.subTitle = modelPlan.internalBaseClassDescription;
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发货时间：";
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelPlan.startTime andFormatter:TIME_SEC_SHOW];
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发布时间：";
        model.subTitle = [GlobalMethod exchangeTimeStampToDate:modelPlan.createTime].timeAgoShow;;
        model.isSelected = false;
        return model;
    }()];
    
    for (ModelBtn * modelB in ary) {
        if (isStr(modelB.title)) {
            {
                UILabel * l = [UILabel new];
                l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                l.textColor = COLOR_666;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                l.lineSpace = W(0);
                [l fitTitle:modelB.title variable:SCREEN_WIDTH - W(30)];
                l.leftTop = XY(W(15), top + W(15));
                [self addSubview:l];
            }
            {
                UILabel * l = [UILabel new];
                l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                l.textColor = modelB.isSelected?COLOR_RED:COLOR_333;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                l.lineSpace = W(0);
                [l fitTitle:isStr(modelB.subTitle)?modelB.subTitle:@"暂无" variable:SCREEN_WIDTH - W(115)];
                l.leftTop = XY(W(90), top + W(15));
                [self addSubview:l];
                top = l.bottom;
            }
        }else{
            UIView * view = [UIView new];
            view.widthHeight = XY(SCREEN_WIDTH, W(10));
            view.backgroundColor = COLOR_BACKGROUND;
            view.top = top + W(15);
            [self addSubview:view];
            top = view.bottom;
        }
    }
    
    
    //设置总高度
    self.height = top + W(15);
}

@end
