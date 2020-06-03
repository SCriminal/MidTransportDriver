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


@interface ScheduleInfoTopView ()

@end

@implementation ScheduleInfoTopView
#pragma mark 懒加载
- (UILabel *)labelBill{
    if (_labelBill == nil) {
        _labelBill = [UILabel new];
        _labelBill.textColor = COLOR_333;
        _labelBill.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
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
    self.labelBillNo.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelBill.bottom + W(25));
    
    CGFloat bottom = [self addLineFrame:CGRectMake(W(25), self.labelBillNo.bottom + W(25), SCREEN_WIDTH - W(50), 1)];
    
    
    {
        NSMutableArray * aryModels = [NSMutableArray array];
        [aryModels addObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"货物名称：";
            model.subTitle = UnPackStr(modelCargo.cargoName);
            return model;
        }()];
        [aryModels addObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"发  货  量：";
            model.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(modelCargo.waybillVolume),UnPackStr(modelCargo.unit)];
            return model;
        }()];
       
        for (int i = 0; i<aryModels.count; i++) {
            ModelBtn * model = aryModels[i];
            if (!isStr(model.title)) {
                bottom = [self addLineFrame:CGRectMake(W(25), bottom + W(20), SCREEN_WIDTH - W(50), 1)];
                continue;
            }
            UILabel * label = [UILabel new];
            label.fontNum = F(15);
            label.textColor = COLOR_333;
            [label fitTitle:model.title variable:0];
            label.leftTop = XY(W(25), bottom + W(20));
            label.tag = TAG_LINE;
            [self addSubview:label];
            bottom = label.bottom;
            
            UILabel * labelTime = [UILabel new];
            labelTime.fontNum = F(15);
            labelTime.textColor = COLOR_333;
            [labelTime fitTitle:UnPackStr(model.subTitle) variable:0];
            labelTime.leftCenterY = XY(label.right + W(2), label.centerY);
            labelTime.tag = TAG_LINE;
            [self addSubview:labelTime];
            
            
        }
    }
    self.height = bottom+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end






@implementation ScheduleInfoPathView
#pragma mark 懒加载
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
- (UILabel *)labelFrom{
    if (_labelFrom == nil) {
        _labelFrom = [UILabel new];
        _labelFrom.textColor = COLOR_666;
        _labelFrom.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelFrom.numberOfLines = 1;
        _labelFrom.lineSpace = 0;
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
    }
    return _labelTo;
}
- (UIImageView *)iconArrow{
    if (_iconArrow == nil) {
        _iconArrow = [UIImageView new];
        _iconArrow.image = [UIImage imageNamed:@"schedule_arrow"];
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

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    //刷新view
    [self.labelFrom fitTitle:@"发货地" variable:0];
    self.labelFrom.leftTop = XY(W(45), W(30));
    [self.labelTo fitTitle:@"收货地" variable:0];
    self.labelTo.leftTop = XY(SCREEN_WIDTH - W(135), self.labelFrom.top);
    
    [self.labelAddressFrom fitTitle:model.addressFromShow variable:SCREEN_WIDTH/2.0 -W(60)];
    self.labelAddressFrom.leftTop = XY(self.labelFrom.left,self.labelFrom.bottom+W(10));
    
    [self.labelAddressTo fitTitle:model.addressToShow variable:SCREEN_WIDTH/2.0 -W(60)];
    self.labelAddressTo.leftTop = XY(self.labelTo.left,self.labelTo.bottom+W(10));
    
    self.iconArrow.centerXCenterY = XY(SCREEN_WIDTH/2.0, self.labelAddressFrom.centerY);
    
    CGFloat bottom = self.labelAddressFrom.bottom + W(10);
    
    
    {
        NSMutableArray * aryModels = [NSMutableArray array];
        [aryModels addObject:^(){
            ModelBtn * modelItem = [ModelBtn new];
            modelItem.title = @"发  货  地：";
            modelItem.subTitle = UnPackStr(model.addressFromDetailShow);
            return modelItem;
        }()];
        [aryModels addObject:^(){
            ModelBtn * modelItem = [ModelBtn new];
            modelItem.title = @"收  货  地：";
            modelItem.subTitle = UnPackStr(model.addressToDetailShow);
            return modelItem;
        }()];
        
        for (int i = 0; i<aryModels.count; i++) {
            ModelBtn * model = aryModels[i];
            if (!isStr(model.title)) {
                bottom = [self addLineFrame:CGRectMake(W(25), bottom + W(20), SCREEN_WIDTH - W(50), 1)];
                continue;
            }
            UILabel * label = [UILabel new];
            label.fontNum = F(15);
            label.textColor = COLOR_333;
            [label fitTitle:model.title variable:0];
            label.leftTop = XY(W(25), bottom + W(20));
            label.tag = TAG_LINE;
            [self addSubview:label];
            
            UILabel * labelTime = [UILabel new];
            labelTime.fontNum = F(15);
            labelTime.textColor = COLOR_333;
            labelTime.numberOfLines = 0;
            [labelTime fitTitle:UnPackStr(model.subTitle) variable:SCREEN_WIDTH - label.right - W(30)];
            labelTime.leftTop = XY(label.right + W(2), label.top);
            labelTime.tag = TAG_LINE;
            [self addSubview:labelTime];
            bottom = MAX(label.bottom, labelTime.bottom);
        }
    }
    self.height = bottom+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end


@implementation ScheduleInfoSendView
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
    [self.labelTitle fitTitle:@"发货信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    NSArray * aryModels = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"单位名称：";
        model.subTitle = UnPackStr(modelOrder.entName);
        model.isSelected = false;
        return model;
    }(),^(){
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
    }()];
//    ,^(){
//        ModelBtn * model = [ModelBtn new];
//        model.title = @"发货时间：";
//        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelOrder.startTime andFormatter:TIME_SEC_SHOW];
//        model.isSelected = false;
//        return model;
//    }()
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
    
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    NSArray * aryModels = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"单位名称：";
        model.subTitle = UnPackStr(modelOrder.endEntName);
        model.isSelected = false;
        return model;
    }(),^(){
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
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelOrder.closeTime andFormatter:TIME_SEC_SHOW];
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
        [labelTime fitTitle:UnPackStr(model.subTitle) variable:SCREEN_WIDTH - label.right - W(5)];
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
