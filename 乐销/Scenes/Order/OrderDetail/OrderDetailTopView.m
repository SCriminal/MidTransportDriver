//
//  OrderDetailTopView.m
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import "OrderDetailTopView.h"
#import "BulkCargoListCell.h"

@interface OrderDetailTopView ()

@end

@implementation OrderDetailTopView
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
        [self addTarget:self action:@selector(copyCodeClick)];
        
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
    [self resetViewWithModel:nil goodlist:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model  goodlist:(NSArray *)ary{
    self.aryDatas = ary;
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.labelBill.centerXTop = XY(SCREEN_WIDTH/2.0,W(25));
    [self.labelBillNo fitTitle:UnPackStr(model.blNumber ) variable:0];
    self.labelBillNo.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelBill.bottom + W(15));
    self.labelCopy.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelBillNo.bottom + W(15));
    
    [self addControlFrame:CGRectInset(self.labelBillNo.frame, -W(90), -W(50)) belowView:self.labelBillNo target:self action:@selector(copyCodeClick)];
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelCopy.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    __block int tag = 100;
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
        m.title = @"下单时间";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_SEC_SHOW];
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运单编号";
        m.subTitle = model.waybillNumber;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"船      名";
        m.subTitle = isStr(model.oceanVessel)?model.oceanVessel:@"暂无";
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"船      次";
        m.subTitle = isStr(model.voyageNumber)?model.voyageNumber:@"暂无";
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    
    self.height = top+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}
#pragma mark 点击事件
- (void)copyCodeClick{
    [GlobalMethod copyToPlte:self.model.blNumber];
    [GlobalMethod showAlert:@"复制成功"];
}
@end

@implementation OrderDetailPackageView

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

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary{
    self.aryDatas = ary;
    [self removeAllSubViews];//移除线
    
    CGFloat height = 0;
    
    CGFloat top = 0;
    
       
          __block int tag = 100;
    for (ModelPackageInfo * modelPackage in ary) {
        
        UIImageView * _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
        [self addSubview:_ivBg];
        
        top = [BulkCargoListCell addTitle:^(){
            ModelBtn * m = [ModelBtn new];
            m.title = @"箱货信息";
            m.subTitle = @" ";
            m.tag = ++tag;
            return m;
        }() view:self top:height + W(20)];
        
       top = [self addLineFrame:CGRectMake(W(25), top + W(20), SCREEN_WIDTH - W(50), 1)];
        
        top = [BulkCargoListCell addTitle:^(){
            ModelBtn * m = [ModelBtn new];
            m.title = @"货物名称";
            m.subTitle = modelPackage.cargoName;
            m.tag = ++tag;
            return m;
        }() view:self top:top + W(18)];
        
        top = [BulkCargoListCell addTitle:^(){
                   ModelBtn * m = [ModelBtn new];
                   m.title = @"箱型箱量";
                   m.subTitle = [NSString stringWithFormat:@"%@*1",modelPackage.containerTypeShow];
                   m.tag = ++tag;
                   return m;
               }() view:self top:top + W(18)];
        
        top = [BulkCargoListCell addTitle:^(){
            ModelBtn * m = [ModelBtn new];
            m.title = @"铅  封  号";
            m.subTitle = isStr(modelPackage.sealNumber)?modelPackage.sealNumber:@"暂无";
            m.tag = ++tag;
            return m;
        }() view:self top:top + W(18)];
        top = [BulkCargoListCell addTitle:^(){
            ModelBtn * m = [ModelBtn new];
            m.title = @"箱      号";
            m.subTitle = isStr(modelPackage.containerNumber)?modelPackage.containerNumber:@"暂无";
            m.tag = ++tag;
            return m;
        }() view:self top:top + W(18)];
       
        
        _ivBg.frame = CGRectMake(0, height-W(10), SCREEN_WIDTH, top - height + W(40));
        height = top + W(40);

    }
    
    self.height = height-W(20);
    
   
    
}


@end


@implementation OrderDetailStatusView
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
    
}
#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary {
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
    self.height = self.sc.bottom;
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end



@implementation OrderDetailPathView
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
- (UIView *)iconAddress{
    if (_iconAddress == nil) {
        _iconAddress = [UIView new];
        _iconAddress.widthHeight = XY(W(30),W(2));
        _iconAddress.backgroundColor = [UIColor colorWithHexString:@"#4E4745"];
    }
    return _iconAddress;
}
- (UILabel *)packageAddress{
    if (_packageAddress == nil) {
        _packageAddress = [UILabel new];
        _packageAddress.textColor = COLOR_666;
        _packageAddress.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _packageAddress;
}
- (UILabel *)import{
    if (_import == nil) {
        _import = [UILabel new];
        _import.textColor = COLOR_666;
        _import.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _import;
}
- (UILabel *)loadAddress{
    if (_loadAddress == nil) {
        _loadAddress = [UILabel new];
        _loadAddress.textColor = COLOR_666;
        _loadAddress.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _loadAddress;
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
    [self addSubview:self.labelTitle];
    [self addSubview:self.addressFrom];
    [self addSubview:self.addressTo];
    [self addSubview:self.iconAddress];
    [self addSubview:self.packageAddress];
    [self addSubview:self.import];
    [self addSubview:self.loadAddress];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.labelTitle.leftTop = XY(W(25),W(20));
    //刷新view
    CGFloat top =     [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    __block int tag = 100;
    
    
    
    self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(50) + top);
    
    [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startProvinceName),[model.startPortName isEqualToString:model.startProvinceName]?@"":UnPackStr(model.startPortName)] variable:W(160)];
    self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    
    if (model.orderType == ENUM_ORDER_TYPE_INPUT) {
               [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.placeProvinceName),[model.placeCityName isEqualToString:model.placeProvinceName]?@"":UnPackStr(model.placeCityName)] variable:W(160)];

    }else {
        [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endProvinceName),[model.endPortName isEqualToString:model.endProvinceName]?@"":UnPackStr(model.endPortName)] variable:W(160)];

    }
    self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
    
    [self.import fitTitle:model.orderType== ENUM_ORDER_TYPE_INPUT?@"进口":@"出口" variable:0];
    self.import.centerXBottom = XY(SCREEN_WIDTH/2.0, self.iconAddress.top - W(18));
    
    [self.packageAddress fitTitle:model.orderType == ENUM_ORDER_TYPE_INPUT?@"提箱港":@"提箱点" variable:0];
    self.packageAddress.centerXCenterY = XY(self.addressFrom.centerX, self.import.centerY);
    
    [self.loadAddress fitTitle:model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货地":@"装货地" variable:0];
    self.loadAddress.centerXCenterY = XY(self.addressTo.centerX, self.import.centerY);
    
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.orderType == ENUM_ORDER_TYPE_INPUT?@"提  箱  港":@"提  箱  点";
        m.subTitle = model.backPackageAddressShow;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:self.iconAddress.bottom + W(34)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸  货  地":@"装  货  地";
        m.subTitle = model.loadAddressShow;
        m.numOfLines = 10;
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    self.height = top+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end


@implementation OrderDetailLoadView
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
- (void)resetViewWithModel:(ModelOrderList *)modelOrder{
    self.model = modelOrder;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    [self.labelTitle fitTitle:modelOrder.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货信息":@"装货信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
       __block int tag = 100;
       top = [BulkCargoListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = @"单位名称";
           m.subTitle = modelOrder.placeEnvName;
           m.tag = ++tag;
           return m;
       }() view:self top:top + W(18)];
      top = [BulkCargoListCell addTitle:^(){
             ModelBtn * m = [ModelBtn new];
             m.title = @"联  系  人";
             m.subTitle = modelOrder.placeContact;
             m.tag = ++tag;
             return m;
         }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
                ModelBtn * m = [ModelBtn new];
                m.title = @"联系电话";
                m.subTitle = modelOrder.placePhone;
                m.tag = ++tag;
                return m;
            }() view:self top:top + W(18)];
    
    [self addControlFrame:CGRectMake(0, top - W(50), SCREEN_WIDTH, W(50)) belowView:[self viewWithTag:tag] target:self action:@selector(phoneClick)];

    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = modelOrder.orderType == ENUM_ORDER_TYPE_OUTPUT?@"装货时间":@"卸货时间" ;
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:modelOrder.placeTime andFormatter:TIME_SEC_SHOW];
        m.tag = ++tag;
        return m;
    }() view:self top:top + W(18)];
    
    self.height = top + W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.placePhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end


@implementation OrderDetailStationView
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
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)modelOrder{
    [self removeAllSubViews];//移除线
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    
    self.model = modelOrder;
    //刷新view
    //刷新view
    [self.labelTitle fitTitle:modelOrder.orderType == ENUM_ORDER_TYPE_OUTPUT?@"提箱点信息":@"提箱港区信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
       __block int tag = 100;
       top = [BulkCargoListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = modelOrder.orderType == ENUM_ORDER_TYPE_OUTPUT?@"提  箱  点":@"提箱港区";
           m.subTitle = modelOrder.startCyName;
           m.tag = ++tag;
           return m;
       }() view:self top:top + W(18)];
      top = [BulkCargoListCell addTitle:^(){
             ModelBtn * m = [ModelBtn new];
             m.title = @"联  系  人";
             m.subTitle = modelOrder.startContact;
             m.tag = ++tag;
             return m;
         }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
                ModelBtn * m = [ModelBtn new];
                m.title = @"联系电话";
                m.subTitle = modelOrder.startPhone;
                m.tag = ++tag;
                return m;
            }() view:self top:top + W(18)];
    
    [self addControlFrame:CGRectMake(0, top - W(50), SCREEN_WIDTH, W(50)) belowView:[self viewWithTag:tag] target:self action:@selector(phoneClick)];

   
    
    self.height = top + W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

#pragma mark click
- (void)phoneClick{
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.startPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}
@end

@implementation OrderDetailReturnAddressView
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
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)modelOrder{
    [self removeAllSubViews];//移除线
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    
    self.model = modelOrder;
    //刷新view
    [self.labelTitle fitTitle:@"还箱点信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
       __block int tag = 100;
       top = [BulkCargoListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = @"还  箱  点";
           m.subTitle = modelOrder.endCyName;
           m.tag = ++tag;
           return m;
       }() view:self top:top + W(18)];
      top = [BulkCargoListCell addTitle:^(){
             ModelBtn * m = [ModelBtn new];
             m.title = @"联  系  人";
             m.subTitle = modelOrder.endContact;
             m.tag = ++tag;
             return m;
         }() view:self top:top + W(18)];
    
    top = [BulkCargoListCell addTitle:^(){
                ModelBtn * m = [ModelBtn new];
                m.title = @"联系电话";
                m.subTitle = modelOrder.endPhone;
                m.tag = ++tag;
                return m;
            }() view:self top:top + W(18)];
    
    [self addControlFrame:CGRectMake(0, top - W(50), SCREEN_WIDTH, W(50)) belowView:[self viewWithTag:tag] target:self action:@selector(phoneClick)];

   
    
    self.height = top + W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

#pragma mark click
- (void)phoneClick{
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.endPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}
@end



@implementation OrderDetailRemarkView
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
- (void)resetViewWithModel:(ModelOrderList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:@"备注信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self.labelSubTitle fitTitle:model.iDPropertyDescription variable:SCREEN_WIDTH - W(50)];
    self.labelSubTitle.leftTop = XY(self.labelTitle.left, self.labelTitle.bottom + W(35));
    
    self.height = self.labelSubTitle.bottom + W(15);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end

