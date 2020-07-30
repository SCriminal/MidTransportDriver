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



@implementation BulkCargoOrderDetailPathView
#pragma mark 懒加载
- (UILabel *)labelPath{
    if (_labelPath == nil) {
        _labelPath = [UILabel new];
        _labelPath.textColor = COLOR_333;
        _labelPath.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelPath;
}
- (UILabel *)labelAddressFrom{
    if (_labelAddressFrom == nil) {
        _labelAddressFrom = [UILabel new];
        _labelAddressFrom.textColor = COLOR_333;
        _labelAddressFrom.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddressFrom.numberOfLines = 0;
        _labelAddressFrom.lineSpace = 0;
    }
    return _labelAddressFrom;
}
- (UILabel *)labelAddressTo{
    if (_labelAddressTo == nil) {
        _labelAddressTo = [UILabel new];
        _labelAddressTo.textColor = COLOR_333;
        _labelAddressTo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
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
    [self addSubview:self.labelAddressFrom];
    [self addSubview:self.labelAddressTo];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBulkCargoOrder *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelPath fitTitle:@"路线信息" variable:0];
    self.labelPath.leftTop = XY(W(25),W(20));
    
    [self addLineFrame:CGRectMake(W(25), self.labelPath.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self.labelAddressFrom fitTitle:[NSString stringWithFormat:@"%@：%@",@"发货地",UnPackStr(model.startAddressShow)] variable:SCREEN_WIDTH - W(57)*2];
    self.labelAddressFrom.leftTop = XY(W(57),self.labelPath.bottom+W(40));
    [self.labelAddressTo fitTitle:[NSString stringWithFormat:@"%@：%@",@"收货地",UnPackStr(model.endAddressShow)] variable:SCREEN_WIDTH - W(57)*2];
    self.labelAddressTo.leftTop = XY(self.labelAddressFrom.left,self.labelAddressFrom.bottom+W(20));
    
    UIView * viewDot = [UIView new];
    viewDot.widthHeight = XY(W(7), W(7));
    [GlobalMethod setRoundView:viewDot color:[UIColor clearColor] numRound:viewDot.width/2.0 width:0];
    viewDot.backgroundColor = COLOR_BLUE;
    viewDot.leftCenterY = XY( W(30), self.labelAddressFrom.centerY);
    [self addLineFrame:CGRectMake(viewDot.centerX-1, viewDot.centerY, 1, self.labelAddressTo.centerY - self.labelAddressFrom.centerY)];
    viewDot.tag = TAG_LINE;
    [self addSubview:viewDot];
    
    UIView * viewDotRed = [UIView new];
    viewDotRed.widthHeight = XY(W(7), W(7));
    [GlobalMethod setRoundView:viewDotRed color:[UIColor clearColor] numRound:viewDot.width/2.0 width:0];
    viewDotRed.backgroundColor = COLOR_RED;
    viewDotRed.leftCenterY = XY( W(30), self.labelAddressTo.centerY);
    [self addSubview:viewDotRed];
    viewDotRed.tag = TAG_LINE;
    
    self.height = self.labelAddressTo.bottom + W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

@end


@implementation BulkCargoOrderDetailSendView
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
- (void)resetViewWithModel:(ModelBulkCargoOrder *)modelOrder{
    self.model = modelOrder;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    [self.labelTitle fitTitle:@"发货信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    NSArray * aryModels = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系人员：";
        model.subTitle = UnPackStr(modelOrder.startContact);
        model.isSelected = false;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系电话：";
        model.subTitle = UnPackStr(modelOrder.startPhone);
        model.isSelected = true;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发货时间：";
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelOrder.startTime andFormatter:TIME_SEC_SHOW];
        model.isSelected = false;
        return model;
    }()];
    CGFloat top = self.labelTitle.bottom + W(40);
    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.textColor = COLOR_333;
        [label fitTitle:model.title variable:0];
        label.leftTop = XY(W(25), top);
        label.tag = TAG_LINE;
        [self addSubview:label];
        top = label.bottom + W(20);
        
        
        UILabel * labelTime = [UILabel new];
        labelTime.fontNum = F(15);
        labelTime.textColor = model.isSelected?COLOR_BLUE:COLOR_333;
        [labelTime fitTitle:UnPackStr(model.subTitle) variable:SCREEN_WIDTH - label.right -W(5)];
        labelTime.leftCenterY = XY(label.right + W(2), label.centerY);
        labelTime.tag = TAG_LINE;
        [self addSubview:labelTime];
        
    }
    
    self.height = top;
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
- (void)resetViewWithModel:(ModelBulkCargoOrder *)modelOrder{
    self.model = modelOrder;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    [self.labelTitle fitTitle:@"收货信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    NSArray * aryModels = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系人员：";
        model.subTitle = UnPackStr(modelOrder.endContact);
        model.isSelected = false;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系电话：";
        model.subTitle = UnPackStr(modelOrder.endPhone);
        model.isSelected = true;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"截止收货时间：";
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelOrder.endTime andFormatter:TIME_SEC_SHOW];
        model.isSelected = false;
        return model;
    }()];
    CGFloat top = self.labelTitle.bottom + W(40);
    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.textColor = COLOR_333;
        [label fitTitle:model.title variable:0];
        label.leftTop = XY(W(25), top);
        label.tag = TAG_LINE;
        [self addSubview:label];
        top = label.bottom + W(20);
        
        
        UILabel * labelTime = [UILabel new];
        labelTime.fontNum = F(15);
        labelTime.textColor = model.isSelected?COLOR_BLUE:COLOR_333;
        [labelTime fitTitle:UnPackStr(model.subTitle) variable:SCREEN_WIDTH - label.right -W(5)];
        labelTime.leftCenterY = XY(label.right + W(2), label.centerY);
        labelTime.tag = TAG_LINE;
        [self addSubview:labelTime];
        
    }
    
    self.height = top;
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
        _labelTitle.textColor = COLOR_333;
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
        _labelTitle.textColor = COLOR_333;
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
    [self resetViewWithTitle:@"装车凭证" aryImage:model.loadUrlList];
}
- (void)resetViewWithUnloadModel:(ModelBulkCargoOrder *)model{
    [self resetViewWithTitle:@"送抵凭证" aryImage:model.unloadUrlList];

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
