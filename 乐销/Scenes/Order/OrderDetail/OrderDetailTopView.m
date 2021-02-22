//
//  OrderDetailTopView.m
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import "OrderDetailTopView.h"

@implementation OrderDetailView
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTransportOrder *)model{
    [self removeAllSubViews];//移除线
    self.model = model;
    {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_BACKGROUND;
        view.widthHeight = XY(SCREEN_WIDTH, W(10));
        [self addSubview:view];
    }
    {
        UILabel *addressFrom = [UILabel new];
        addressFrom.textColor = COLOR_333;
        addressFrom.numberOfLines = 1;
        addressFrom.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [self addSubview:addressFrom];
        
        UILabel * addressTo = [UILabel new];
        addressTo.textColor = COLOR_333;
        addressTo.numberOfLines = 1;
        addressTo.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [self addSubview:addressTo];
        
        UIImageView * iconAddress = [UIImageView new];
        iconAddress.backgroundColor = [UIColor clearColor];
        iconAddress.contentMode = UIViewContentModeScaleAspectFill;
        iconAddress.clipsToBounds = true;
        iconAddress.image = [UIImage imageNamed:@"right_balck"];
        iconAddress.widthHeight = XY(W(17),W(17));
        [self addSubview:iconAddress];
        
        iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(30));
        
        [addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startCityName),UnPackStr(model.startCountyName)] variable:W(160)];
        addressFrom.centerXCenterY = XY((iconAddress.left - W(10))/2.0+W(10), iconAddress.centerY);
        [addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endCityName),UnPackStr(model.endCountyName)] variable:W(160)];

        addressTo.centerXCenterY = XY((SCREEN_WIDTH - iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + iconAddress.width/2.0, iconAddress.centerY);
    }
    NSArray * ary0 = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运单号：";
        m.subTitle = model.orderNumber;
        m.colorSelect = nil;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货量：";
        m.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(model.qtyShow),model.unitShow];
        m.colorSelect = nil;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输费用：";
        m.subTitle = [NSString stringWithFormat:@"%@元",NSNumber.dou(model.shipperPrice/100.0).stringValue];
        m.colorSelect = COLOR_RED;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称：";
        m.subTitle = model.cargoName;
        m.colorSelect = nil;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前状态：";
        m.subTitle = model.orderStatusShow;
        m.colorSelect = model.colorStateShow;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"路线信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货地：";
        m.subTitle = [NSString stringWithFormat:@"%@%@%@%@",model.startProvinceName,[model.startCityName isEqualToString:model.startProvinceName]?UnPackStr(model.startCityName):@"",model.startCountyName,model.startAddr];
        m.colorSelect = nil;
        m.left = W(77);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收货地：";
        m.subTitle = [NSString stringWithFormat:@"%@%@%@%@",model.endProvinceName,[model.endCityName isEqualToString:model.endProvinceName]?UnPackStr(model.endCityName):@"",model.endCountyName,model.endAddr];
        m.colorSelect = nil;
        m.left = W(77);
            return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货联系人：";
        m.subTitle = model.startContacter;
        m.colorSelect = nil;
        m.thirdTitle = model.startPhone;
        m.left = W(108);
        m.tag = 1;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货时间：";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.startTime andFormatter:TIME_SEC_SHOW];
        m.colorSelect = nil;
        m.left = W(108);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收货信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收货联系人：";
        m.subTitle = model.endContacter;
        m.colorSelect = nil;
        m.thirdTitle = model.endPhone;
        m.tag = 2;
        m.left = W(123);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"截止收货时间：";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.endTime andFormatter:TIME_SEC_SHOW];
        m.colorSelect = nil;
        m.left = W(123);
        return m;
    }()];
    NSMutableArray * ary1 = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"流转信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.bizOrderTime?@"下单：":nil;
        m.subTitle = model.bizOrderTime?[GlobalMethod exchangeTimeWithStamp:model.bizOrderTime andFormatter:TIME_SEC_SHOW]:nil;
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.acceptTime?@"接单：":nil;
        m.subTitle = model.acceptTime?[GlobalMethod exchangeTimeWithStamp:model.acceptTime andFormatter:TIME_SEC_SHOW]:nil;
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.loadTime?@"装车：":nil;
        m.subTitle = model.loadTime?[GlobalMethod exchangeTimeWithStamp:model.loadTime andFormatter:TIME_SEC_SHOW]:nil;
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.unloadTime?@"到达：":nil;
        m.subTitle = model.unloadTime?[GlobalMethod exchangeTimeWithStamp:model.unloadTime andFormatter:TIME_SEC_SHOW]:nil;
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.confirmTime?@"确认：":nil;
        m.subTitle = model.confirmTime?[GlobalMethod exchangeTimeWithStamp:model.confirmTime andFormatter:TIME_SEC_SHOW]:nil;
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.finishTime?@"完成：":nil;
        m.subTitle = model.finishTime?[GlobalMethod exchangeTimeWithStamp:model.finishTime andFormatter:TIME_SEC_SHOW]:nil;
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }()].mutableCopy;
    NSArray * ary2 = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"路线轨迹";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前位置：";
        m.subTitle = @"山东省潍坊市奎文区世博国际大厦";
        m.colorSelect = nil;
        m.left = W(93);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前时速：";
        m.subTitle = @"20km/h";
        m.colorSelect = nil;
        m.left = W(93);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"已驶里程：";
        m.subTitle = @"20km";
        m.colorSelect = nil;
        m.left = W(93);
        return m;
    }()].mutableCopy;
    NSMutableArray * aryAll = [NSMutableArray arrayWithArray:ary0];
    [aryAll addObjectsFromArray:ary1];
//    [aryAll addObjectsFromArray:ary2];
    
    CGFloat top =  [self addLabel:aryAll top:W(72)];
    self.height = top;
}
-(CGFloat)addLabel:(NSArray *)ary top:(CGFloat)top{
    for (ModelBtn *m in ary) {
        if (m.title == nil && m.subTitle == nil) {
            continue;
        }
        if (m.isSelected) {
            UIView * view = [UIView new];
            view.backgroundColor = COLOR_BACKGROUND;
            view.widthHeight = XY(SCREEN_WIDTH, W(10));
            view.top = top+W(5);
            [self addSubview:view];
            
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15),view.bottom + W(15));
            [self addSubview:l];
            
            top = [self addLineFrame:CGRectMake(W(15), l.bottom + W(15), SCREEN_WIDTH - W(30), 1)] + W(15);
        }else{
            {
                UILabel * l = [UILabel new];
                l.tag = 1;
                l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                l.textColor = COLOR_666;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                l.lineSpace = W(0);
                [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
                l.leftTop = XY(W(15),top);
                [self addSubview:l];
            }
            {
                UILabel * l = [UILabel new];
                l.tag = 1;
                l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                l.textColor = m.colorSelect?m.colorSelect:COLOR_333;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                [l fitTitle:m.subTitle variable:SCREEN_WIDTH - m.left - W(15)];
                l.leftTop = XY(m.left,top);
                [self addSubview:l];
                top = l.bottom + W(15);
                if (isStr(m.thirdTitle)) {
                    UILabel * phone = [UILabel new];
                    phone.tag = 1;
                    phone.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                    phone.textColor =COLOR_BLUE;
                    phone.backgroundColor = [UIColor clearColor];
                    [phone fitTitle:m.thirdTitle variable:SCREEN_WIDTH - W(105) - W(15)];
                    phone.leftCenterY = XY(l.right + W(10),l.centerY);
                    [self addSubview:phone];
                    
                    UIView * con =[self addControlFrame:CGRectInset(phone.frame, -W(20), -W(20)) belowView:phone target:self action:@selector(phoneClick:)];
                    con.tag = m.tag;
                }
            }
        }
    }
    return top;
}
#pragma mark click
- (void)phoneClick:(UIControl *)con{
    if (con.tag == 1) {
        NSLog(@"1");
    }
    if (con.tag == 2) {
           NSLog(@"2");
       }
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.startPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
@end



@implementation OrderDetailTrackCell
#pragma mark 懒加载
- (UILabel *)l{
    if (_l == nil) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        _l = l;
    }
    return _l;
}
- (UILabel *)time{
    if (_time == nil) {
        UILabel * time = [UILabel new];
        time.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        time.textColor = COLOR_333;
        time.numberOfLines = 0;
        time.lineSpace = W(3);
        time.backgroundColor = [UIColor clearColor];
        _time = time;
    }
    return _time;
}
- (UIView *)dot{
    if (_dot == nil) {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
        view.widthHeight = XY(W(5), W(5));
        [GlobalMethod setRoundView:view color:[UIColor clearColor] numRound:view.width/2.0 width:0];
        _dot = view;
    }
    return _dot;
}
- (UIView *)line{
    if (_line == nil) {
        UIView * line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
        line.width = 1;
        _line = line;
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.l];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.dot];
    [self.contentView addSubview:self.line];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelLocationItem *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view


    [self.l fitTitle:isStr(model.addr)?model.addr:@"暂无地点名称数据" variable:W(315)];
    self.l.leftTop = XY(W(44),0);

    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.collectTime andFormatter:TIME_SEC_SHOW] variable:W(315)];
    self.time.leftTop = XY(W(44),self.l.bottom+W(10));


    self.dot.leftTop = XY(W(22),self.l.top + ([UIFont fetchHeight:F(15)]/2.0)-W(2.5));
    
    //设置总高度
    self.height = self.time.bottom + W(20);

//    line.widthHeight = XY(1, view.centerY - centerY);
//    line.centerXBottom = XY(view.centerX, view.top);
    self.line.centerX = self.dot.centerX;
    if (!model.isFirst  && !model.isLast) {
        self.line.top = 0;
        self.line.height = self.height;
    }else if (model.isFirst && model.isLast){
        self.line.height = 0;
    }else if(model.isFirst){
        self.line.top = self.dot.centerY;
        self.line.height = self.height - self.dot.centerY;
    }else{
        self.line.top = 0;
        self.line.height = self.dot.centerY;
    }

}

@end


@implementation OrderDetailCommentView
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTransportOrder *)model{
    [self removeAllSubViews];//移除线
    self.model = model;
    CGFloat top = 0;
    {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_BACKGROUND;
        view.widthHeight = XY(SCREEN_WIDTH, W(10));
        top = view.bottom;
        [self addSubview:view];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"我的评价" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(15)+top);
        [self addSubview:l];
        top = l.bottom;
        
        top = [self addLineFrame:CGRectMake(W(15), top+W(15), SCREEN_WIDTH - W(30), 1)];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"评分：" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(15) + top);
        [self addSubview:l];
        top = l.bottom;
        
        CommentStarView * starView = [CommentStarView new];
        self.starView = starView;
        starView.isShowGrayStarBg = true;
        starView.interval = W(12);
        [starView configDefaultView];
        starView.userInteractionEnabled = true;
        starView.leftCenterY = XY(W(64), l.centerY);
        [self addSubview:starView];
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(345), W(80));
        view.leftTop = XY(W(15), W(15)+top);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        [self addSubview:view];
        top = view.bottom;
        
        PlaceHolderTextView *textView = [PlaceHolderTextView new];
        textView.backgroundColor = [UIColor clearColor];
        self.textView = textView;
        [GlobalMethod setLabel:textView.placeHolder widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_SUBTITLE text:@"请填写评价内容"];
        textView.font = textView.placeHolder.font;
        [textView setTextColor:COLOR_TITLE];
        textView.widthHeight = XY(view.width - W(24), view.height - W(30));
        textView.center = view.center;
        [self addSubview:textView];

    }
    
    {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_BACKGROUND;
        view.widthHeight = XY(SCREEN_WIDTH, W(10));
        view.top = top + W(15);
        top = view.bottom;
        [self addSubview:view];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(355), W(39));
        btn.backgroundColor = COLOR_BLUE;
        [btn setTitle:@"提交评价" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.leftTop = XY(W(10), W(10)+top);
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:COLOR_BORDER];
        [self addSubview:btn];
        top = btn.bottom;
    }
    self.height = top;
}
- (void)btnConfirmClick{
    if (self.blockConfirm) {
        self.blockConfirm(self.starView.currentScore, self.textView.text);
    }
}
@end
