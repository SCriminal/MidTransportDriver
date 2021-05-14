//
//  BulkCargoListCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "BulkCargoListCell.h"

@interface BulkCargoListCell ()

@end

@implementation BulkCargoListCell
#pragma mark 懒加载
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        self.backgroundColor = COLOR_BACKGROUND;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = false;
        self.contentView.clipsToBounds = false;
        [self.contentView addSubview:self.ivBg];
        [self.contentView addSubview:self.addressFrom];
        [self.contentView addSubview:self.addressTo];
        [self.contentView addSubview:self.iconAddress];
        [self.contentView addSubview:self.btnLeft];
        [self.contentView addSubview:self.btnRight];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBulkCargoOrder *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];
    self.model = model;
    //刷新view
    CGFloat top = 0;
    __block int tag = 100;
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运单号";
        m.subTitle = model.waybillNumber;
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:W(35)];
    
    top = [self.contentView addLineFrame:CGRectMake(W(25), top + W(20), SCREEN_WIDTH - W(50), 1)];
    
    self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(20) + top);
    
    [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startProvinceName),[model.startCityName isEqualToString:model.startProvinceName]?@"":UnPackStr(model.startCityName)] variable:W(160)];
    self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    
    [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endProvinceName),[model.endCityName isEqualToString:model.endProvinceName]?@"":UnPackStr(model.endCityName)] variable:W(160)];
    self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
    
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前状态";
        m.subTitle = model.orderStatusShow;
        m.color = model.colorStateShow;
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:self.iconAddress.bottom + W(22)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称";
        m.subTitle = model.cargoName;
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发  货  量";
        m.subTitle = [NSString stringWithFormat:@"%@ %@",NSNumber.dou(model.actualLoad).stringValue,UnPackStr(model.loadUnit)];
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发  货  方";
        m.subTitle = model.shipperName;
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"托  运  方";
        m.subTitle = @"中车运";
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货时间";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.startTime andFormatter:TIME_SEC_SHOW];
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [BulkCargoListCell addTitle:^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货联系人";
        m.subTitle = [NSString stringWithFormat:@"%@ %@",UnPackStr(model.startContact),UnPackStr(model.startPhone)];
        m.tag = ++tag;
        return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [self.contentView addLineFrame:CGRectMake(W(25), top + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self resetBtn:top];
    
    //设置总高度
    self.height = top + W(70);
    
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height + W(10));
    
}

- (void)resetBtn:(CGFloat)top {
    self.btnRight.hidden = true;
    switch (self.model.operateType) {
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_RECEIVE:
            [self.btnLeft setTitle:@"拒单" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.btnLeft.widthHeight = XY(W(155), W(40));
            self.btnLeft.backgroundColor = [UIColor whiteColor];
            self.btnLeft.tag = 1;
            self.btnLeft.leftTop = XY(W(25), top + W(15));
            [GlobalMethod setRoundView:self.btnLeft color:[UIColor colorWithHexString:@"#D9D9D9"] numRound:5 width:1];
            
            [self.btnRight setTitle:@"接单" forState:UIControlStateNormal];
            [self.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnRight.widthHeight = XY(W(155), W(40));
            self.btnRight.backgroundColor = COLOR_BLUE;
            self.btnRight.tag = 2;
            self.btnRight.rightTop = XY(SCREEN_WIDTH - W(25), top + W(15));
            [GlobalMethod setRoundView:self.btnRight color:[UIColor clearColor] numRound:5 width:0];
            self.btnRight.hidden = false;
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_LOAD:
            [self.btnLeft setTitle:@"点击装车" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnLeft.widthHeight = XY(W(325), W(40));
            self.btnLeft.backgroundColor = [UIColor colorWithHexString:@"#F97A1B"];
            self.btnLeft.tag = 3;
            self.btnLeft.leftTop = XY(W(25), top + W(15));
            [GlobalMethod setRoundView:self.btnLeft color:[UIColor clearColor] numRound:5 width:0];
            
            break;
        case ENUM_BULKCARGO_ORDER_OPERATE_WAIT_UNLOAD:
            [self.btnLeft setTitle:@"点击到达" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnLeft.widthHeight = XY(W(325), W(40));
            self.btnLeft.backgroundColor = [UIColor colorWithHexString:@"#66CC00"];
            self.btnLeft.tag = 4;
            self.btnLeft.leftTop = XY(W(25), top + W(15));
            [GlobalMethod setRoundView:self.btnLeft color:[UIColor clearColor] numRound:5 width:0];
            break;
            case ENUM_BULKCARGO_ORDER_OPERATE_COMPLETE:
        case ENUM_BULKCARGO_ORDER_OPERATE_ARRIVE:
        case ENUM_BULKCARGO_ORDER_OPERATE_CLOSE:
            [self.btnLeft setTitle:@"呼叫" forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
            self.btnLeft.widthHeight = XY(W(155), W(40));
            self.btnLeft.backgroundColor = [UIColor whiteColor];
            self.btnLeft.tag = 5;
            self.btnLeft.leftTop = XY(W(25), top + W(15));
            [GlobalMethod setRoundView:self.btnLeft color:[UIColor colorWithHexString:@"#D9D9D9"] numRound:5 width:1];
            
            [self.btnRight setTitle:@"查看" forState:UIControlStateNormal];
            [self.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.btnRight.widthHeight = XY(W(155), W(40));
            self.btnRight.backgroundColor = COLOR_BLUE;
            self.btnRight.tag = 6;
            self.btnRight.rightTop = XY(SCREEN_WIDTH - W(25), top + W(15));
            [GlobalMethod setRoundView:self.btnRight color:[UIColor clearColor] numRound:5 width:0];
            self.btnRight.hidden = false;
            break;
        default:
            break;
    }
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

+ (CGFloat)addTitle:(ModelBtn *)modelBtn  view:(UIView *)superView top:(CGFloat)top {
    UILabel * labelTitle = [superView viewWithTag:modelBtn.tag];
    if (labelTitle == nil) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        l.lineSpace = W(0);
        l.tag = modelBtn.tag;
        [superView addSubview:l];
        labelTitle = l;
    }
    [labelTitle fitTitle:UnPackStr(modelBtn.title) variable:W(100)];
    labelTitle.leftTop = XY(modelBtn.left?modelBtn.left:W(25), top);
    
    UILabel * labelSubtitle = [superView viewWithTag:modelBtn.tag+100];
    if (labelSubtitle == nil) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        l.lineSpace = W(0);
        l.tag = modelBtn.tag + 100;
        l.textAlignment = NSTextAlignmentRight;
        [superView addSubview:l];
        labelSubtitle = l;
    }
    if (modelBtn.color) {
        labelSubtitle.fontNum = F(11);
        labelSubtitle.backgroundColor = modelBtn.color;
        labelSubtitle.textColor = [UIColor whiteColor];
        labelSubtitle.textAlignment = NSTextAlignmentCenter;
        CGFloat width = [modelBtn.subTitle sizeWithAttributes:@{NSFontAttributeName: labelSubtitle.font}].width + W(10);
        labelSubtitle.widthHeight = XY(width, W(18));
        [GlobalMethod setRoundView:labelSubtitle color:[UIColor clearColor] numRound:3 width:0];
        labelSubtitle.text = modelBtn.subTitle;
        labelSubtitle.rightCenterY = XY(SCREEN_WIDTH - (modelBtn.right?modelBtn.right:W(25)), labelTitle.centerY);
    }else{
        labelSubtitle.numberOfLines = modelBtn.numOfLines?modelBtn.numOfLines:1;
        [labelSubtitle fitTitle:isStr(modelBtn.subTitle)?modelBtn.subTitle:@"暂无" variable:W(250)];
        labelSubtitle.textColor = modelBtn.colorSelect?modelBtn.colorSelect:COLOR_333;
        labelSubtitle.rightTop = XY(SCREEN_WIDTH - (modelBtn.right?modelBtn.right:W(25)), top);
    }

    return MAX(labelTitle.bottom, labelSubtitle.bottom);
}

@end
