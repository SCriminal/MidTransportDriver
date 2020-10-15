//
//  ScheduleInfoView.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "ScheduleInfoView.h"
//detail
#import "ImageDetailBigView.h"
#import "BulkCargoListCell.h"


@interface ScheduleInfoTopView ()

@end

@implementation ScheduleInfoTopView
#pragma mark 懒加载
- (UILabel *)labelBill{
    if (_labelBill == nil) {
        _labelBill = [UILabel new];
        _labelBill.textColor = COLOR_666;
        _labelBill.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _labelBill.numberOfLines = 0;
        _labelBill.lineSpace = 0;
    }
    return _labelBill;
}
- (UILabel *)labelBillNo{
    if (_labelBillNo == nil) {
        _labelBillNo = [UILabel new];
        _labelBillNo.textColor = COLOR_333;
        _labelBillNo.font =  [UIFont systemFontOfSize:F(22) weight:UIFontWeightSemibold];
        _labelBillNo.numberOfLines = 0;
        _labelBillNo.lineSpace = 0;
    }
    return _labelBillNo;
}

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelBill];
    [self addSubview:self.labelBillNo];
    
    //初始化页面
    [self resetViewWithModel:nil ];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)modelCargo  {
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelBill fitTitle:@"发货单号" variable:0];
    self.labelBill.centerXTop = XY(SCREEN_WIDTH/2.0,W(25));
    [self.labelBillNo fitTitle:UnPackStr(modelCargo.number ) variable:0];
    self.labelBillNo.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelBill.bottom + W(15));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelBillNo.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    __block int tag = 100;
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称";
        m.subTitle = modelCargo.cargoName;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发  货  量";
        m.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(modelCargo.waybillVolume),UnPackStr(modelCargo.unit)];
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    self.height = top+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end






@implementation ScheduleInfoPathView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelTitle fitTitle:@"路线信息" variable:0];
    }
    return _labelTitle;
}
- (UILabel *)labelAddressFrom{
    if (_labelAddressFrom == nil) {
        _labelAddressFrom = [UILabel new];
        _labelAddressFrom.textColor = COLOR_333;
        _labelAddressFrom.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _labelAddressFrom.numberOfLines = 0;
        _labelAddressFrom.lineSpace = 0;
    }
    return _labelAddressFrom;
}
- (UILabel *)labelAddressTo{
    if (_labelAddressTo == nil) {
        _labelAddressTo = [UILabel new];
        _labelAddressTo.textColor = COLOR_333;
        _labelAddressTo.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _labelAddressTo.numberOfLines = 0;
        _labelAddressTo.lineSpace = 0;
    }
    return _labelAddressTo;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}
- (UILabel *)labelFrom{
    if (_labelFrom == nil) {
        _labelFrom = [UILabel new];
        _labelFrom.textColor = COLOR_666;
        _labelFrom.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelFrom.numberOfLines = 1;
        _labelFrom.lineSpace = 0;
        [_labelFrom fitTitle:@"发货地" variable:0];
    }
    return _labelFrom;
}
- (UILabel *)labelTo{
    if (_labelTo == nil) {
        _labelTo = [UILabel new];
        _labelTo.textColor = COLOR_666;
        _labelTo.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelTo.numberOfLines = 1;
        _labelTo.lineSpace = 0;
        [_labelTo fitTitle:@"收货地" variable:0];
        
    }
    return _labelTo;
}
- (UIImageView *)iconArrow{
    if (_iconArrow == nil) {
        _iconArrow = [UIImageView new];
        _iconArrow.image = [UIImage imageNamed:@"arrow_address"];
        _iconArrow.widthHeight = XY(W(25),W(25));
    }
    return _iconArrow;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelAddressFrom];
    [self addSubview:self.labelAddressTo];
    [self addSubview:self.labelFrom];
    [self addSubview:self.labelTo];
    [self addSubview:self.iconArrow];
    [self addSubview:self.labelTitle];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    __block int tag = 100;
    
    self.iconArrow.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(39));
    
    [self.labelAddressFrom fitTitle:model.addressFromShow variable:SCREEN_WIDTH/2.0 -W(60)];
    self.labelAddressFrom.centerXCenterY = XY((self.iconArrow.left + W(25))/2.0,self.iconArrow.centerY);
    
    [self.labelAddressTo fitTitle:isStr(model.addressToShow)?model.addressToShow:@"暂无" variable:SCREEN_WIDTH/2.0 -W(60)];
    self.labelAddressTo.centerXCenterY = XY(self.iconArrow.right + (self.iconArrow.left - W(25))/2.0,self.iconArrow.centerY);
    
    self.labelFrom.centerXBottom = XY(self.labelAddressFrom.centerX, self.labelAddressFrom.top - W(10));
    self.labelTo.centerXBottom = XY(self.labelAddressTo.centerX, self.labelAddressTo.top - W(10));
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发  货  地";
        m.subTitle = model.addressFromDetailShow;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:self.iconArrow.bottom + W(23)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收  货  地";
        m.subTitle = isStr(model.addressToDetailShow)?model.addressToDetailShow:@"暂无";
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    self.height = top+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end


@implementation ScheduleInfoSendView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
        [self addTarget:self action:@selector(phoneClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)modelOrder{
    self.model = modelOrder;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    [self.labelTitle fitTitle:@"发货信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    __block int tag = 100;
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"单位名称";
        m.subTitle = modelOrder.entName;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联  系  人";
        m.subTitle = modelOrder.startContact;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联系电话";
        m.subTitle = modelOrder.startPhone;
        m.numOfLines = 10;
        m.colorSelect = COLOR_BLUE;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    [self addControlFrame:CGRectMake(0, top - W(50), SCREEN_WIDTH, W(50)) belowView:[self viewWithTag:tag] target:self action:@selector(phoneClick)];
    
    self.height = top+ W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.startPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end


@implementation ScheduleInfoReceiveView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
        [self addTarget:self action:@selector(phoneClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)modelOrder{
    self.model = modelOrder;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    [self.labelTitle fitTitle:@"收货信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    __block int tag = 100;
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"单位名称";
        m.subTitle = modelOrder.endEntName;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联  系  人";
        m.subTitle = modelOrder.endContact;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联系电话";
        m.subTitle = modelOrder.endPhone;
        m.numOfLines = 10;
        m.colorSelect = COLOR_BLUE;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    [self addControlFrame:CGRectMake(0, top - W(50), SCREEN_WIDTH, W(50)) belowView:[self viewWithTag:tag] target:self action:@selector(phoneClick)];
    
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"截止收货时间";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:modelOrder.closeTime andFormatter:TIME_SEC_SHOW];
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    self.height = top+ W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.endPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end



@implementation ScheduleBottomView
#pragma mark 懒加载

-(UIButton *)btnConfirm{
    if (_btnConfirm == nil) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnConfirm addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = COLOR_BLUE;
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [GlobalMethod setRoundView:_btnConfirm color:[UIColor clearColor] numRound:5 width:0];
        [_btnConfirm setTitle:@"确认" forState:(UIControlStateNormal)];
        _btnConfirm.widthHeight = XY(SCREEN_WIDTH - W(20),W(45));
    }
    return _btnConfirm;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = false;
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.btnConfirm];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.btnConfirm.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
    
    self.height = self.btnConfirm.bottom + W(10);
}

#pragma mark click
- (void)btnClick{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end

@implementation ScheduleRemarkView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UILabel *)labelSubTitle{
    if (_labelSubTitle == nil) {
        _labelSubTitle = [UILabel new];
        _labelSubTitle.textColor = COLOR_333;
        _labelSubTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelSubTitle.numberOfLines = 0;
        _labelSubTitle.lineSpace = W(8);
    }
    return _labelSubTitle;
}

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = false;
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(phoneClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelSubTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:@"备注信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self.labelSubTitle fitTitle:UnPackStr(model.iDPropertyDescription) variable:SCREEN_WIDTH - W(50)];
    self.labelSubTitle.leftTop = XY(self.labelTitle.left, self.labelTitle.bottom + W(35));
    
    self.height = self.labelSubTitle.bottom + W(15);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end
