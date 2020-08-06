//
//  BulkCargoOrderDetailView.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "BulkCargoOrderDetailView.h"
//detail
#import "ImageDetailBigView.h"
#import "BulkCargoListCell.h"

@interface BulkCargoOrderDetailTopView ()

@end

@implementation BulkCargoOrderDetailTopView
#pragma mark 懒加载
- (UILabel *)labelBill{
    if (_labelBill == nil) {
        _labelBill = [UILabel new];
        _labelBill.textColor = COLOR_666;
        _labelBill.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _labelBill.numberOfLines = 0;
        _labelBill.lineSpace = 0;
        [_labelBill fitTitle:@"运单号" variable:0];
    }
    return _labelBill;
}
- (UILabel *)labelCopy{
    if (_labelCopy == nil) {
        _labelCopy = [UILabel new];
        _labelCopy.textColor = COLOR_666;
        _labelCopy.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _labelCopy.numberOfLines = 0;
        _labelCopy.lineSpace = 0;
        [_labelCopy fitTitle:@"点击运单号可复制" variable:0];
        
    }
    return _labelCopy;
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
    [self addSubview:self.labelCopy];
    
    //初始化页面
    [self resetViewWithModel:nil ];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model  {
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.labelBill.centerXTop = XY(SCREEN_WIDTH/2.0,W(25));
    [self.labelBillNo fitTitle:UnPackStr(model.waybillNumber ) variable:0];
    self.labelBillNo.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelBill.bottom + W(25));
    
    self.labelCopy.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelBillNo.bottom + W(15));
    
    [self addControlFrame:CGRectInset(self.labelBillNo.frame, -W(40), -W(50)) belowView:self.labelBillNo target:self action:@selector(copyClick)];
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelCopy.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    __block int tag = 100;
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"下单时间";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_SEC_SHOW];
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前状态";
        m.subTitle = model.orderStatusShow;
        m.color = model.colorStateShow;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称";
        m.subTitle = model.cargoName;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发  货  量";
        m.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(model.actualLoad),UnPackStr(model.loadUnit)];;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    self.height = top+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

- (void)copyClick{
    [GlobalMethod copyToPlte:self.model.waybillNumber];
    [GlobalMethod showAlert:@"复制成功"];
}

@end



@implementation BulkCargoOrderDetailStatusView
#pragma mark 懒加载
- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = COLOR_666;
        _labelStatus.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelStatus.numberOfLines = 0;
        _labelStatus.lineSpace = 0;
        [_labelStatus fitTitle:@"运单状态" variable:0];
        
    }
    return _labelStatus;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}
- (UIScrollView *)sc{
    if (!_sc) {
        _sc = [UIScrollView new];
        _sc.scrollEnabled = true;
        _sc.backgroundColor = [UIColor clearColor];
        _sc.showsVerticalScrollIndicator = false;
        _sc.showsHorizontalScrollIndicator = false;
        if (@available(iOS 11.0, *)) {
            _sc.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _sc;
}
-(UIButton *)btnLeft{
    if (_btnLeft == nil) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _btnLeft.widthHeight = XY(W(30),W(40));
    }
    return _btnLeft;
}
-(UIButton *)btnRight{
    if (_btnRight == nil) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRight.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _btnRight;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelStatus];
    [self addSubview:self.sc];
    [self addSubview:self.btnLeft];
    [self addSubview:self.btnRight];

}

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary  model:(ModelBulkCargoOrder *)model{
    self.model = model;
    self.aryDatas = ary;
    [self removeAllSubViews];//移除线
    [self addSubView];
    //刷新view
    self.labelStatus.leftTop = XY(W(25),W(20));
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelStatus.bottom + W(18), SCREEN_WIDTH - W(50), 1)];
    
    self.sc.frame = CGRectMake(W(10), top, SCREEN_WIDTH - W(20), W(86));
    CGFloat left = W(33);
    [self.sc removeAllSubViews];
    for (int i = 0; i<ary.count; i++) {
        ModelBaseData * item = ary[i];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = isStr(item.subString)?COLOR_BLUE:COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:item.string variable:0];
        l.leftTop = XY(left, W(18));
        [self.sc addSubview:l];
        left = l.right + W(76);
        
        NSString * time = isStr(item.subString)?[GlobalMethod exchangeString:item.subString fromFormatter:TIME_SEC_SHOW toFormatter:TIME_DAY_SHOW]:[NSString stringWithFormat:@"未%@",item.string];
        NSString * subTime = isStr(item.subString)?[GlobalMethod exchangeString:item.subString fromFormatter:TIME_SEC_SHOW toFormatter:@"HH:mm:ss"]:@"";
        
        UILabel * subLabel = [UILabel new];
        subLabel.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        subLabel.textColor = COLOR_666;
        subLabel.backgroundColor = [UIColor clearColor];
        [subLabel fitTitle:time variable:0];
        subLabel.centerXTop = XY(l.centerX, l.bottom + W(9));
        [self.sc addSubview:subLabel];
        
        if (isStr(subTime)) {
            UILabel * subTimeLabel = [UILabel new];
            subTimeLabel.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
            subTimeLabel.textColor = COLOR_666;
            subTimeLabel.backgroundColor = [UIColor clearColor];
            [subTimeLabel fitTitle:subTime variable:0];
            subTimeLabel.centerXTop = XY(l.centerX, subLabel.bottom + W(2));
            [self.sc addSubview:subTimeLabel];
        }
        
        if (i != ary.count -1) {
            UIView * viewLine = [UIView new];
            viewLine.widthHeight = XY(W(20), 1);
            viewLine.backgroundColor = isStr(subTime)?COLOR_BLUE:COLOR_666;
            viewLine.leftCenterY = XY(l.right + W(28), l.centerY);
            [self.sc addSubview:viewLine];
        }
        
    }
    self.sc.contentSize = CGSizeMake(left, 0);
    
    //设置总高度
    self.height = [self resetBtn:self.sc.bottom];
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}
- (CGFloat)resetBtn:(CGFloat)top {
    self.btnRight.hidden = true;
    self.btnLeft.hidden = true;
    return top;
    switch (self.model.operateType) {
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE:
            [self.btnLeft setTitle:@"拒单" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.btnLeft.widthHeight = XY(W(155), W(40));
            self.btnLeft.backgroundColor = [UIColor whiteColor];
            self.btnLeft.tag = 1;
            self.btnLeft.leftTop = XY(W(25), top + W(15));
            self.btnLeft.hidden = false;
            [GlobalMethod setRoundView:self.btnLeft color:[UIColor colorWithHexString:@"#D9D9D9"] numRound:5 width:1];
            
            [self.btnRight setTitle:@"接单" forState:UIControlStateNormal];
            [self.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnRight.widthHeight = XY(W(155), W(40));
            self.btnRight.backgroundColor = COLOR_BLUE;
            self.btnRight.tag = 2;
            self.btnRight.rightTop = XY(SCREEN_WIDTH - W(25), top + W(15));
            [GlobalMethod setRoundView:self.btnRight color:[UIColor clearColor] numRound:5 width:0];
            self.btnRight.hidden = false;
            return self.btnLeft.bottom + W(15);
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD:
            [self.btnLeft setTitle:@"点击装车" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnLeft.widthHeight = XY(W(325), W(40));
            self.btnLeft.backgroundColor = [UIColor colorWithHexString:@"#F97A1B"];
            self.btnLeft.tag = 3;
            self.btnLeft.leftTop = XY(W(25), top + W(15));
            self.btnLeft.hidden = false;
            [GlobalMethod setRoundView:self.btnLeft color:[UIColor clearColor] numRound:5 width:0];
            return self.btnLeft.bottom + W(15);
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD:
            [self.btnLeft setTitle:@"点击到达" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnLeft.widthHeight = XY(W(325), W(40));
            self.btnLeft.backgroundColor = [UIColor colorWithHexString:@"#66CC00"];
            self.btnLeft.tag = 4;
            self.btnLeft.leftTop = XY(W(25), top + W(15));
            self.btnLeft.hidden = false;
            [GlobalMethod setRoundView:self.btnLeft color:[UIColor clearColor] numRound:5 width:0];
            return self.btnLeft.bottom + W(15);
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE:
        case ENUM_BULKCARGO_ORDER_OPERATE_ARRIVE:
        case ENUM_BULKCARGO_ORDER_OPERATE_CLOSE:
            break;
        default:
            break;
    }
    return top;
}
- (void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1://reject
            if (self.blockReject) {
                self.blockReject(self.model);
            }
            break;
        case 2://accept
            if (self.blockAccept) {
                self.blockAccept(self.model);
            }
            break;
        case 3://load
            if (self.blockLoad) {
                self.blockLoad(self.model);
            }
            break;
        case 4://arrive
            if (self.blockArrive) {
                self.blockArrive(self.model);
            }
            break;
        case 5://call
        {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.startPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 6://detail
            if (self.blockDetail) {
                self.blockDetail(self.model);
            }
            break;
        default:
            break;
    }
}
@end



@implementation BulkCargoOrderDetailPathView
#pragma mark 懒加载
- (UILabel *)labelPath{
    if (_labelPath == nil) {
        _labelPath = [UILabel new];
        _labelPath.textColor = COLOR_666;
        _labelPath.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelPath;
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
        _iconAddress = [UIImageView new];
        _iconAddress.image = [UIImage imageNamed:@"arrow_address"];
        _iconAddress.widthHeight = XY(W(25),W(25));
    }
    return _iconAddress;
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
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelPath];
    [self addSubview:self.addressFrom];
    [self addSubview:self.addressTo];
    [self addSubview:self.iconAddress];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelPath fitTitle:@"路线信息" variable:0];
    self.labelPath.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelPath.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    __block int tag = 100;
    
    self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(20) + top);
    
    [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startProvinceName),[model.startCityName isEqualToString:model.startProvinceName]?@"":UnPackStr(model.startCityName)] variable:W(160)];
    self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    
    [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endProvinceName),[model.endCityName isEqualToString:model.endProvinceName]?@"":UnPackStr(model.endCityName)] variable:W(160)];
    self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发  货  地";
        m.subTitle = model.startAddressShow;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:self.iconAddress.bottom + W(22)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收  货  地";
        m.subTitle = model.endAddressShow;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    
    self.height = top + W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

@end


@implementation BulkCargoOrderDetailSendView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelTitle fitTitle:@"发货信息" variable:0];
        
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
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    __block int tag = 100;
    
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"单位名称";
        m.subTitle = model.shipperName;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联  系  人";
        m.subTitle = model.startContact;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联系电话";
        m.subTitle = model.startPhone;
        m.colorSelect = COLOR_BLUE;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    [self addControlFrame:CGRectMake(0, top - W(50), SCREEN_WIDTH, W(50)) belowView:[self viewWithTag:tag] target:self action:@selector(phoneClick)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货时间";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.startTime andFormatter:TIME_SEC_SHOW];
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    
    self.height = top + W(18);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.startPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end


@implementation BulkCargoOrderDetailReceiveView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelTitle fitTitle:@"收货信息" variable:0];
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
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    __block int tag = 100;
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"单位名称";
        m.subTitle = model.endEntName;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联  系  人";
        m.subTitle = model.endContact;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联系电话";
        m.subTitle = model.endPhone;
        m.colorSelect = COLOR_BLUE;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    [self addControlFrame:CGRectMake(0, top - W(50), SCREEN_WIDTH, W(50)) belowView:[self viewWithTag:tag] target:self action:@selector(phoneClick)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"截止收货时间";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.endTime andFormatter:TIME_SEC_SHOW];
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    self.height = top + W(18);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.endPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end



@implementation BulkCargoOrderDetailDriverView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_333;
        _labelName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelName.numberOfLines = 0;
        _labelName.lineSpace = 0;
    }
    return _labelName;
}
- (UILabel *)labelPhone{
    if (_labelPhone == nil) {
        _labelPhone = [UILabel new];
        _labelPhone.textColor = COLOR_333;
        _labelPhone.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelPhone.numberOfLines = 0;
        _labelPhone.lineSpace = 0;
    }
    return _labelPhone;
}
- (UIImageView *)ivHead{
    if (_ivHead == nil) {
        _ivHead = [UIImageView new];
        _ivHead.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
        _ivHead.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_ivHead color:[UIColor clearColor] numRound:_ivHead.width/2.0 width:0];
    }
    return _ivHead;
}
- (UIImageView *)ivPhone{
    if (_ivPhone == nil) {
        _ivPhone = [UIImageView new];
        _ivPhone.image = [UIImage imageNamed:@"orderCell_call"];
        _ivPhone.widthHeight = XY(W(25),W(25));
    }
    return _ivPhone;
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
    [self addSubview:self.labelName];
    [self addSubview:self.labelPhone];
    [self addSubview:self.ivHead];
    //    [self addSubview:self.ivPhone];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.model = model;
    //刷新view
    [self.labelTitle fitTitle:@"承运司机" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self.ivHead sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.ivHead.leftTop = XY(W(25),self.labelTitle.bottom+W(35));
    
    NSString * strTruckNum =isStr( model.vehicleNumber)? [NSString stringWithFormat:@" (%@)",model.vehicleNumber]:@"";
    [self.labelName fitTitle:[NSString stringWithFormat:@"%@%@",[GlobalData sharedInstance].GB_UserModel.nickname,strTruckNum] variable:0];
    self.labelName.leftTop = XY(self.ivHead.right + W(10),self.ivHead.top + W(3));
    
    [self.labelPhone fitTitle:UnPackStr(model.driverPhone) variable:0];
    self.labelPhone.leftBottom = XY(self.labelName.left,self.ivHead.bottom);
    
    self.ivPhone.rightCenterY = XY(SCREEN_WIDTH - W(25),self.ivHead.centerY);
    
    self.height = self.ivHead.bottom + W(15);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

#pragma mark click
- (void)phoneClick{
    //    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[GlobalData sharedInstance].GB_UserModel.account];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end


@implementation BulkCargoOrderDetailRemarkView
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
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:@"备注信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self.labelSubTitle fitTitle:model.internalBaseClassDescription variable:SCREEN_WIDTH - W(50)];
    self.labelSubTitle.leftTop = XY(self.labelTitle.left, self.labelTitle.bottom + W(35));
    
    self.height = self.labelSubTitle.bottom + W(15);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end

@implementation BulkLoadImageView
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

- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = false;
        self.width = SCREEN_WIDTH;
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
}

#pragma mark 刷新view
- (void)resetViewWithLoadModel:(ModelBulkCargoOrder *)model{
    [self resetViewWithTitle:@"装车信息" aryImage:model.loadUrlList];
}
- (void)resetViewWithUnloadModel:(ModelBulkCargoOrder *)model{
    [self resetViewWithTitle:@"到达信息" aryImage:model.unloadUrlList];
    
}
- (void)resetViewWithTitle:(NSString *)title aryImage:(NSArray *)aryImages{
    [self removeAllSubViews];//移除线
    [self addSubView];
    //刷新view
    [self.labelTitle fitTitle:title variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    CGFloat bottom =  [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)] + W(20);
    
    
    [self.aryDatas removeAllObjects];
    CGFloat left = self.labelTitle.left;
    for (int i = 0; i< aryImages.count; i++) {
        NSString * strUrl = aryImages[i];
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = strUrl;
        [self.aryDatas addObject:modelImageInfo];
        
        UIImageView * iv = [UIImageView new];
        iv.widthHeight = XY(W(100), W(100));
        iv.leftTop = XY(left, bottom);
        iv.userInteractionEnabled = true;
        iv.clipsToBounds = true;
        iv.tag = i;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        [iv addTarget:self action:@selector(ivClick:)];
        [iv sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        [self addSubview:iv];
        
        left = iv.right + W(12);
        if ((i+1)%3==0) {
            left = self.labelTitle.left;
            bottom = iv.bottom +W(15);
        }
        self.height = iv.bottom + W(20);
    }
    
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

#pragma mark click
- (void)ivClick:(UITapGestureRecognizer *)tap{
    UIImageView * iv = (UIImageView *)tap.view;
    if (![iv isKindOfClass:[UIImageView class]]) {
        return;
    }
    ImageDetailBigView * detailView = [ImageDetailBigView new];
    [detailView resetView:self.aryDatas isEdit:false index: iv.tag];
    [detailView showInView:GB_Nav.lastVC.view imageViewShow:iv];
}


@end
