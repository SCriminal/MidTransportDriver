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

@interface AutoConfigDetailVC ()
@property (nonatomic, strong) AutoConfigTimeView *timeView;
@property (nonatomic, strong) AutoConfigDetailView *topView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AutoConfigDetailVC
- (AutoConfigTimeView *)timeView{
    if (!_timeView) {
        _timeView = [AutoConfigTimeView new];
        _timeView.title = @"立即报价";
        _timeView.ivBG.image = [UIImage imageNamed:@"autoBtn_bao"];
        [_timeView resetView];
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
    self.timeView.date = [[NSDate date] dateByAddingDays:2];
    [self.timeView resetTime];
    
    self.tableView.tableHeaderView = self.topView;
    
    //table
    //    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
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

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFLOAT_MIN;
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark request
- (void)requestList{
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
- (void)resetViewWithModel:(ModelOrderList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
    
    [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startProvinceName),[model.startPortName isEqualToString:model.startProvinceName]?@"":UnPackStr(model.startPortName)] variable:W(160)];
    self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    if (model.orderType == ENUM_ORDER_TYPE_INPUT) {
        [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.placeProvinceName),[model.placeCityName isEqualToString:model.placeProvinceName]?@"":UnPackStr(model.placeCityName)] variable:W(160)];
    }else {
        [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endProvinceName),[model.endPortName isEqualToString:model.endProvinceName]?@"":UnPackStr(model.endPortName)] variable:W(160)];
        
    }
    self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
    
    CGFloat top = self.iconAddress.bottom + W(20);
    self.newsView.centerXTop = XY(SCREEN_WIDTH/2.0, top);
    [self.newsView resetWithAry:@[@"156****0983      成交量：100      好评率：90%",@"156****0983      成交量：101      好评率：90%"]];
    [self.newsView timerStart];
    top = self.newsView.bottom + W(20);
    
    NSMutableArray * ary = [NSMutableArray new];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"配货编号：";
        model.subTitle = @"QD338888882222239";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发货量：";
        model.subTitle = @"2000吨";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"剩余量：";
        model.subTitle = @"1800吨";
        model.isSelected = true;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"货物名称：";
        model.subTitle = @"设备零配件";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"单价：";
        model.subTitle = @"100.00元/吨";
        model.isSelected = true;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"距离：";
        model.subTitle = @"约220km装货";
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
        model.subTitle = @"高栏";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车长要求：";
        model.subTitle = @"13-17.5米";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"补充说明：";
        model.subTitle = @"一装一卸";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发货时间：";
        model.subTitle = @"2020-11-19 12:09:20";
        model.isSelected = false;
        return model;
    }()];
    [ary addObject:^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发布时间：";
        model.subTitle = @"刚刚";
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
                l.textColor = modelB.isSelected?[UIColor colorWithHexString:@"#FF0000"]:COLOR_333;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                l.lineSpace = W(0);
                [l fitTitle:modelB.subTitle variable:SCREEN_WIDTH - W(115)];
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
