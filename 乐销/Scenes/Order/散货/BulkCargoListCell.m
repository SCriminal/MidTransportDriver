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
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor clearColor];
        _viewBG.width = SCREEN_WIDTH;
    }
    return _viewBG;
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
        [self.contentView addSubview:self.viewBG];
        [self.contentView addSubview:self.addressFrom];
        [self.contentView addSubview:self.addressTo];
        [self.contentView addSubview:self.iconAddress];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBulkCargoOrder *)model{
    self.model = model;
    [self.viewBG removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat top = 0;
    __block int tag = 0;
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
    self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0, self.iconAddress.centerY);
    
    [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endProvinceName),[model.endCityName isEqualToString:model.endProvinceName]?@"":UnPackStr(model.endCityName)] variable:W(160)];
    self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0, self.iconAddress.centerY);
    
    
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
           m.title = @"发 货 量";
        m.subTitle = NSNumber.dou(model.actualLoad).stringValue;
           m.tag = ++tag;
           return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [BulkCargoListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = @"单位名称";
           m.subTitle = model.shipperName;
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
    
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, top+W(26));
    //设置总高度
    self.height = self.ivBg.height - W(10);
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
        [superView addSubview:l];
        labelTitle = l;
    }
    [labelTitle fitTitle:UnPackStr(modelBtn.title) variable:W(90)];
    labelTitle.leftTop = XY(W(25), top);

    UILabel * labelSubtitle = [superView viewWithTag:modelBtn.tag+100];
    if (labelSubtitle == nil) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        l.lineSpace = W(0);
        [superView addSubview:l];
        labelSubtitle = l;
    }
    if (modelBtn.color) {
        labelSubtitle.fontNum = F(11);
        labelSubtitle.backgroundColor = modelBtn.color;
        labelSubtitle.textColor = [UIColor whiteColor];
        labelSubtitle.textAlignment = NSTextAlignmentCenter;
        labelSubtitle.widthHeight = XY(W(45), W(18));
        [GlobalMethod setRoundView:labelSubtitle color:[UIColor clearColor] numRound:3 width:0];
        labelSubtitle.text = modelBtn.subTitle;
        labelSubtitle.rightCenterY = XY(SCREEN_WIDTH - W(25), labelTitle.centerY);
    }else{
        [labelSubtitle fitTitle:UnPackStr(modelBtn.subTitle) variable:W(250)];
        labelSubtitle.rightTop = XY(SCREEN_WIDTH - W(25), top);
    }
    return labelTitle.bottom;
}

#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.startPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

@end
