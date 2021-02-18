//
//  ScanListCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/11/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "ScanListCell.h"
#import "ScanListCell.h"

@interface ScanListCell ()

@end

@implementation ScanListCell
#pragma mark 懒加载
- (UILabel *)labelFrom{
    if (_labelFrom == nil) {
        _labelFrom = [UILabel new];
        _labelFrom.textColor = COLOR_333;
        _labelFrom.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelFrom.numberOfLines = 1;
        _labelFrom.lineSpace = 0;
    }
    return _labelFrom;
}
- (UILabel *)labelTo{
    if (_labelTo == nil) {
        _labelTo = [UILabel new];
        _labelTo.textColor = COLOR_333;
        _labelTo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelTo.numberOfLines = 1;
        _labelTo.lineSpace = 0;
    }
    return _labelTo;
}
- (UILabel *)labelAddressFrom{
    if (_labelAddressFrom == nil) {
        _labelAddressFrom = [UILabel new];
        _labelAddressFrom.textColor = COLOR_333;
        _labelAddressFrom.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightBold];
        _labelAddressFrom.numberOfLines = 1;
        _labelAddressFrom.lineSpace = 0;
    }
    return _labelAddressFrom;
}
- (UILabel *)labelAddressTo{
    if (_labelAddressTo == nil) {
        _labelAddressTo = [UILabel new];
        _labelAddressTo.textColor = COLOR_333;
        _labelAddressTo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightBold];
        _labelAddressTo.numberOfLines = 1;
        _labelAddressTo.lineSpace = 0;
    }
    return _labelAddressTo;
}

- (UIImageView *)iconArrow{
    if (_iconArrow == nil) {
        _iconArrow = [UIImageView new];
        _iconArrow.image = [UIImage imageNamed:@"schedule_arrow"];
        _iconArrow.widthHeight = XY(W(25),W(25));
    }
    return _iconArrow;
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        self.backgroundColor = COLOR_BACKGROUND;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = false;
        self.contentView.clipsToBounds = false;
        [self.contentView addSubview:self.ivBg];
        [self.contentView addSubview:self.labelFrom];
        [self.contentView addSubview:self.labelTo];
        [self.contentView addSubview:self.labelAddressFrom];
        [self.contentView addSubview:self.labelAddressTo];
        [self.contentView addSubview:self.iconArrow];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelScheduleList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.iconArrow.centerXTop = XY(SCREEN_WIDTH/2.0, W(54));

    [self.labelAddressFrom fitTitle:model.addressFromShow variable:SCREEN_WIDTH/2.0 -W(60)];
       self.labelAddressFrom.centerXCenterY = XY((self.iconArrow.left - W(10))/2.0+W(10), self.iconArrow.centerY);

       [self.labelAddressTo fitTitle:model.addressToShow variable:SCREEN_WIDTH/2.0 -W(60)];
       self.labelAddressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconArrow.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconArrow.width/2.0, self.iconArrow.centerY);

    [self.labelFrom fitTitle:@"发货地" variable:0];
    self.labelFrom.centerXBottom = XY(self.labelAddressFrom.centerX, self.iconArrow.top - W(6));
    [self.labelTo fitTitle:@"收货地" variable:0];
    self.labelTo.centerXBottom = XY(self.labelAddressTo.centerX, self.iconArrow.top - W(6));
    
    __block int tag = 100;
   CGFloat top = [ScanListCell addTitle:^(){
                ModelBtn * m = [ModelBtn new];
                m.title = @"当前状态";
                m.subTitle = model.scheduleStatusShow;
               m.color = model.colorStateShow;
                m.tag = ++tag;
                return m;
         }() view:self.contentView top:self.iconArrow.bottom + W(22)];
    
    top = [ScanListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = @"发货单号";
           m.subTitle = model.planNumber;
           m.tag = ++tag;
           return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [ScanListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = @"货物名称";
           m.subTitle = model.cargoName;
           m.tag = ++tag;
           return m;
    }() view:self.contentView top:top + W(15)];
    
    top = [ScanListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = @"发  货  量";
           m.subTitle = [NSString stringWithFormat:@"%@%@",NSNumber.dou(model.actualLoad),UnPackStr(model.loadUnit)];
           m.tag = ++tag;
           return m;
    }() view:self.contentView top:top + W(15)];

    
    self.height = top +W(20);
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height+W(10));
    
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
