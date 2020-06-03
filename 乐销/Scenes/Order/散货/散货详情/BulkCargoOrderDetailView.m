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

@interface BulkCargoOrderDetailTopView ()

@end

@implementation BulkCargoOrderDetailTopView
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
- (void)resetViewWithModel:(ModelBulkCargoOrder *)modelCargo  {
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelBill fitTitle:@"运单号" variable:0];
    self.labelBill.centerXTop = XY(SCREEN_WIDTH/2.0,W(25));
    [self.labelBillNo fitTitle:UnPackStr(modelCargo.waybillNumber ) variable:0];
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
            model.title = @"货  物  量：";
            model.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(modelCargo.actualLoad),UnPackStr(modelCargo.loadUnit)];
            return model;
        }()];
            [aryModels addObject:^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"车        型：";
                model.subTitle = [NSString stringWithFormat:@"%@ %.f米 ",[GlobalMethod exchangeCarType:modelCargo.vehicleType],modelCargo.vehicleLength];
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



@implementation BulkCargoOrderDetailStatusView
#pragma mark 懒加载
- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = COLOR_333;
        _labelStatus.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelStatus.numberOfLines = 0;
        _labelStatus.lineSpace = 0;
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
}

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary {
    self.aryDatas = ary;
    [self removeAllSubViews];//移除线
    [self addSubView];
    //刷新view
    [self.labelStatus fitTitle:@"运单状态" variable:0];
    self.labelStatus.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelStatus.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    NSMutableArray * aryModels = [NSMutableArray array];
    for (ModelBaseData * item in ary) {
        ModelBtn * model = [ModelBtn new];
        model.title = item.string;
        model.subTitle = item.subString;
        model.isSelected = true;
        [aryModels addObject:model];
    }
    
    CGFloat top = self.labelStatus.bottom + W(50);
    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.textColor = model.isSelected?COLOR_333:COLOR_666;
        [label fitTitle:model.title variable:0];
        label.leftTop = XY(W(25), top);
        [self addSubview:label];
        top = label.bottom + W(35);
        
        UIView * viewDot = [UIView new];
        viewDot.widthHeight = XY(W(7), W(7));
        [GlobalMethod setRoundView:viewDot color:[UIColor clearColor] numRound:viewDot.width/2.0 width:0];
        viewDot.backgroundColor = model.isSelected?COLOR_BLUE:COLOR_666;
        viewDot.leftCenterY = XY(label.right + W(20), label.centerY);
        if (i!=aryModels.count -1) {
            [self addLineFrame:CGRectMake(viewDot.centerX, viewDot.centerY, 1, W(35)+label.height) color:viewDot.backgroundColor];
        }
        [self addSubview:viewDot];
        
        
        UILabel * labelTime = [UILabel new];
        labelTime.fontNum = F(15);
        labelTime.textColor = model.isSelected?COLOR_333:COLOR_666;
        [labelTime fitTitle:UnPackStr(model.subTitle) variable:0];
        labelTime.leftCenterY = XY(viewDot.right + W(25), label.centerY);
        [self addSubview:labelTime];
        
    }
    
    //设置总高度
    self.height = top - W(5);
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
