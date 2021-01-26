//
//  MyPirceOrderListVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/26.
//Copyright © 2021 ping. All rights reserved.
//

#import "MyPirceOrderListVC.h"
//request
#import "RequestDriver2.h"

@interface MyPirceOrderListVC ()

@end

@implementation MyPirceOrderListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无运单"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    //table
  [self.tableView registerClass:[MyPirceOrderListCell class] forCellReuseIdentifier:@"MyPirceOrderListCell"];
   self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

   self.tableView.backgroundColor = [UIColor clearColor];
   self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
   [self addRefreshHeader];
   [self addRefreshFooter];
   //request
   [self requestList];    //request
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPirceOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyPirceOrderListCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDismiss = ^(ModelAutOrderListItem *model) {
    };
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyPirceOrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ModelAutOrderListItem * model = self.aryDatas[indexPath.row];
    
}

#pragma mark request
- (void)requestList{
    [RequestApi requestOrderListWithPage:self.pageNum count:20 orderNumber:nil shipperName:nil plateNumber:nil driverName:nil                       startTime:0
                                 endTime:0
                            orderStatues:nil
                                delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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




@implementation MyPirceOrderListCell
#pragma mark 懒加载

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.width = SCREEN_WIDTH;
    }
    return _viewBG;
}
- (UIButton *)btnView{
    if (!_btnView) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(345), W(39));
        btn.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        [btn setTitle:@"取消报价" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        return btn;
        
    }
    return _btnView;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        self.backgroundColor = COLOR_BACKGROUND;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = false;
        [self.contentView addSubview:self.viewBG];
        [self.contentView addSubview:self.btnView];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAutOrderListItem *)model{
    self.model = model;
    //刷新view
  
    CGFloat top = W(20);

    NSMutableArray * ary = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"报价编号：";
        m.subTitle = model.planNumber;
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"配货编号：";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.thirdTitle = model.matchNumber;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输路线：";
        NSString * strFrom = [NSString stringWithFormat:@"%@%@",UnPackStr(model.startCityName),UnPackStr(model.startCountyName)];
        NSString * strTo = [NSString stringWithFormat:@"%@%@",UnPackStr(model.endCityName),UnPackStr(model.endCountyName)];

        m.subTitle = [NSString stringWithFormat:@"%@ 至 %@",strFrom,strTo];
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"车牌号码：";
        m.subTitle = model.plateNumber;
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运费报价：";
        m.subTitle = [NSString stringWithFormat:@"%@元",NSNumber.dou(model.price/100.0).stringValue];
        m.colorSelect = COLOR_RED;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称：";
        m.subTitle = model.cargoName;
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前状态：";
        m.subTitle = [ModelAutOrderListItem matchStatusExchange:model.matchStatus];
        m.colorSelect = [ModelAutOrderListItem matchStatusColorExchange:model.matchStatus];;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"报价时间：";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.matchTime andFormatter:TIME_SEC_SHOW];
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }()].mutableCopy;
   
    if (model.matchStatus == 2) {
        [ary addObject:^(){
            ModelBtn * m = [ModelBtn new];
            m.title = @"确认时间：";
            m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.replyTime andFormatter:TIME_SEC_SHOW];
            m.colorSelect = nil;
            m.thirdTitle = nil;
            return m;
        }()];
    }
    if (model.matchStatus == 11) {
        [ary addObject:^(){
            ModelBtn * m = [ModelBtn new];
            m.title = @"拒绝原因：";
            m.subTitle = model.reason;
            m.colorSelect = COLOR_RED;
            m.thirdTitle = nil;
            return m;
        }()];
    }
    top = [self addLabel:ary top:top];
    
   
    self.btnView.top = top + W(20);
    self.btnView.hidden = model.matchStatus != 1;
    if (!self.btnView.hidden) {
        top = self.btnView.bottom;
    }

    self.viewBG.height = top + W(20);
    //设置总高度
    self.height = self.viewBG.bottom + W(12);
    
}

- (CGFloat)addLabel:(NSArray *)ary top:(CGFloat)top{
    [self.contentView removeSubViewWithTag:1];
    top = top + W(25) - W(15);
    for (ModelBtn *m in ary) {
        {
            UILabel * l = [UILabel new];
            l.tag = 1;
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15),top + W(15));
            [self.contentView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.tag = 1;
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = m.colorSelect?m.colorSelect:COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 1;
            [l fitTitle:m.subTitle variable:SCREEN_WIDTH - W(105) - W(15)];
            l.leftTop = XY(W(105),top + W(15));
            [self.contentView addSubview:l];
            top = l.bottom;
            if (isStr(m.thirdTitle)) {
                UILabel * phone = [UILabel new];
                phone.tag = 1;
                phone.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                phone.textColor =COLOR_BLUE;
                phone.backgroundColor = [UIColor clearColor];
                [phone fitTitle:m.thirdTitle variable:SCREEN_WIDTH - W(105) - W(15)];
                phone.leftCenterY = XY(l.right + W(10),l.centerY);
                [self.contentView addSubview:phone];
                
                UIView * con =[self.contentView addControlFrame:CGRectInset(phone.frame, -W(20), -W(20)) belowView:phone target:self action:@selector(copyClick)];
                con.tag = 1;
            }
        }
    }
    return top;
}

- (void)btnDismissClick{
    if (self.blockDismiss) {
        self.blockDismiss(self.model);
    }
}

- (void)copyClick{
    [GlobalMethod copyToPlte:self.model.matchNumber];
    [GlobalMethod showAlert:@"复制成功"];
}

@end


