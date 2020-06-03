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
- (UILabel *)labelBillNo{
    if (_labelBillNo == nil) {
        _labelBillNo = [UILabel new];
        _labelBillNo.textColor = COLOR_333;
        _labelBillNo.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightBold];
        _labelBillNo.numberOfLines = 1;
        _labelBillNo.lineSpace = 0;
    }
    return _labelBillNo;
}
- (UIView *)colorLine{
    if (!_colorLine) {
        _colorLine = [UIView new];
        _colorLine.widthHeight = XY(W(4), W(20));
        _colorLine.backgroundColor = COLOR_BLUE;
        [GlobalMethod setRoundView:_colorLine color:[UIColor clearColor] numRound:_colorLine.width/2.0 width:0];
    }
    return _colorLine;
}

- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = COLOR_BLUE;
        _labelStatus.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightBold];
        _labelStatus.numberOfLines = 1;
        _labelStatus.lineSpace = 0;
    }
    return _labelStatus;
}


- (UILabel *)labelAddressFrom{
    if (_labelAddressFrom == nil) {
        _labelAddressFrom = [UILabel new];
        _labelAddressFrom.textColor = COLOR_333;
        _labelAddressFrom.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddressFrom.numberOfLines = 1;
        _labelAddressFrom.lineSpace = 0;
    }
    return _labelAddressFrom;
}
- (UILabel *)labelAddressTo{
    if (_labelAddressTo == nil) {
        _labelAddressTo = [UILabel new];
        _labelAddressTo.textColor = COLOR_333;
        _labelAddressTo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddressTo.numberOfLines = 1;
        _labelAddressTo.lineSpace = 0;
    }
    return _labelAddressTo;
}
- (UILabel *)labelConnect{
    if (_labelConnect == nil) {
        _labelConnect = [UILabel new];
        _labelConnect.textColor = COLOR_333;
        _labelConnect.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelConnect.numberOfLines = 1;
        _labelConnect.lineSpace = 0;
    }
    return _labelConnect;
}
- (UILabel *)labelOperateTime{
    if (_labelOperateTime == nil) {
        _labelOperateTime = [UILabel new];
        _labelOperateTime.textColor = COLOR_666;
        _labelOperateTime.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelOperateTime.numberOfLines = 1;
        _labelOperateTime.lineSpace = 0;
    }
    return _labelOperateTime;
}
- (UILabel *)labelCompany{
    if (_labelCompany == nil) {
        _labelCompany = [UILabel new];
        _labelCompany.textColor = COLOR_333;
        _labelCompany.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelCompany.numberOfLines = 1;
        _labelCompany.lineSpace = 0;
    }
    return _labelCompany;
}
- (UILabel *)labelPortType{
    if (_labelPortType == nil) {
        _labelPortType = [UILabel new];
        _labelPortType.textColor = COLOR_333;
        _labelPortType.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelPortType.numberOfLines = 1;
        _labelPortType.lineSpace = 0;
    }
    return _labelPortType;
}
- (UIImageView *)ivUser{
    if (_ivUser == nil) {
        _ivUser = [UIImageView new];
        _ivUser.image = [UIImage imageNamed:@"orderCell_driver"];
        _ivUser.widthHeight = XY(W(25),W(25));
    }
    return _ivUser;
}

- (UIImageView *)ivCompany{
    if (_ivCompany == nil) {
        _ivCompany = [UIImageView new];
        _ivCompany.image = [UIImage imageNamed:@"orderCell_company"];
        _ivCompany.widthHeight = XY(W(25),W(25));
    }
    return _ivCompany;
}
- (UIImageView *)ivPortType{
    if (_ivPortType == nil) {
        _ivPortType = [UIImageView new];
        _ivPortType.image = [UIImage imageNamed:@"orderCell_type"];
        _ivPortType.widthHeight = XY(W(25),W(25));
    }
    return _ivPortType;
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
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor clearColor];
        _viewBG.width = SCREEN_WIDTH;
    }
    return _viewBG;
}
- (UIView *)dotBlue{
    if (_dotBlue == nil) {
        _dotBlue = [UIView new];
        _dotBlue.backgroundColor = COLOR_BLUE;
        _dotBlue.widthHeight = XY(W(7), W(7));
        [GlobalMethod setRoundView:_dotBlue color:[UIColor clearColor] numRound:_dotBlue.width/2.0 width:0];
        
    }
    return _dotBlue;
}
- (UIView *)lineVertical{
    if (_lineVertical == nil) {
        _lineVertical = [UIView new];
        _lineVertical.backgroundColor = COLOR_LINE;
    }
    return _lineVertical;
}
- (UIView *)dotRed{
    if (_dotRed == nil) {
        _dotRed = [UIView new];
        _dotRed.backgroundColor = COLOR_RED;
        _dotRed.widthHeight = XY(W(7), W(7));
        [GlobalMethod setRoundView:_dotRed color:[UIColor clearColor] numRound:_dotRed.width/2.0 width:0];
    }
    return _dotRed;
}
- (UIControl *)conPhone{
    if (_conPhone == nil) {
        _conPhone = [UIControl new];
        [_conPhone addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
        _conPhone.backgroundColor = [UIColor clearColor];
        _conPhone.widthHeight = XY(SCREEN_WIDTH,W(0));
    }
    return _conPhone;
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
        [self.viewBG addSubview:self.labelBillNo];
        [self.viewBG addSubview:self.labelStatus];
        [self.viewBG addSubview:self.labelCompany];
        [self.viewBG addSubview:self.labelAddressFrom];
        [self.viewBG addSubview:self.labelAddressTo];
        [self.viewBG addSubview:self.labelConnect];
        [self.viewBG addSubview:self.labelOperateTime];
        [self.viewBG addSubview:self.labelPortType];
        [self.viewBG addSubview:self.ivPortType];
        [self.viewBG addSubview:self.ivUser];
        [self.viewBG addSubview:self.ivCompany];
        [self.viewBG addSubview:self.ivPhone];
        [self.viewBG addSubview:self.lineVertical];
        [self.viewBG addSubview:self.dotBlue];
        [self.viewBG addSubview:self.dotRed];
        [self.viewBG addSubview:self.conPhone];
        [self.viewBG addSubview:self.colorLine];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBulkCargoOrder *)model{
    self.model = model;
    [self.viewBG removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.labelStatus fitTitle:model.orderStatusShow variable:0];
    self.labelStatus.textColor = model.colorStateShow;
    self.labelStatus.rightTop = XY(self.viewBG.width - W(25),W(36));
    
    self.colorLine.left = W(25);
    self.colorLine.backgroundColor = model.colorStateShow;
    
    [self.labelBillNo fitTitle:[NSString stringWithFormat:@"运单号：%@",UnPackStr(model.waybillNumber)] fixed:self.labelStatus.left - W(40) - self.colorLine.right];
    self.labelBillNo.leftCenterY = XY(self.colorLine.right + W(20),self.labelStatus.centerY);
    
    
    self.colorLine.centerY = self.labelBillNo.centerY;
    
    CGFloat bottom =  [self.viewBG addLineFrame:CGRectMake(W(25), self.labelBillNo.bottom + W(20), self.viewBG.width - W(50), 1)];
    
    self.ivCompany.leftTop = XY(W(25),bottom+W(14));
    
    [self.labelCompany fitTitle:UnPackStr(model.shipperName) variable:self.viewBG.width - self.ivCompany.right - W(40)];
    self.labelCompany.leftCenterY = XY(self.ivCompany.right + W(11),self.ivCompany.centerY);
    
    
    self.ivPortType.leftTop = XY(self.ivCompany.left,self.ivCompany.bottom + W(10));
    
    [self.labelPortType fitTitle:[NSString stringWithFormat:@"%@ %@%@  ",UnPackStr(model.cargoName),NSNumber.dou(model.actualLoad),model.loadUnit] variable:self.viewBG.width - self.ivPortType.right - W(40)];
    self.labelPortType.leftCenterY = XY(self.ivPortType.right + W(11),self.ivPortType.centerY);
    
    
    self.dotBlue.centerXTop = XY(self.ivPortType.centerX, self.ivPortType.bottom + W(19));
    
    [self.labelAddressFrom fitTitle:[NSString stringWithFormat:@"%@：%@",@"发货地",UnPackStr(model.startAddressShow)] variable:self.viewBG.width - self.dotBlue.right - W(40)];
    self.labelAddressFrom.leftCenterY = XY(self.dotBlue.right + W(20),self.dotBlue.centerY);
    
    self.dotRed.centerXTop = XY(self.ivPortType.centerX, self.dotBlue.bottom + W(28));
    [self.labelAddressTo fitTitle:[NSString stringWithFormat:@"%@：%@",@"收货地",UnPackStr(model.endAddressShow)] variable:self.viewBG.width - self.dotBlue.right - W(40)];
    self.labelAddressTo.leftCenterY = XY(self.labelAddressFrom.left,self.dotRed.centerY);
    
    self.lineVertical.frame = CGRectMake(self.dotRed.centerX-1, self.dotRed.centerY, 1, self.dotBlue.centerY - self.dotRed.centerY);
    
    
    
    bottom =  [self.viewBG addLineFrame:CGRectMake(W(25), self.labelAddressTo.bottom + W(20), self.viewBG.width - W(50), 1)];
    
    self.ivUser.left = W(25);
    
    [self.labelConnect fitTitle:[NSString stringWithFormat:@"%@：%@",@"发货时间",[GlobalMethod exchangeTimeWithStamp:model.startTime andFormatter:TIME_SEC_SHOW]] variable:self.ivUser.left - self.ivUser.right - W(40)];
    self.labelConnect.leftTop = XY(self.ivUser.right + W(11),bottom+W(20));
    
    self.ivUser.top = self.labelConnect.centerY;
    self.ivPhone.rightCenterY = XY(self.viewBG.width - W(25),self.ivUser.centerY);

    
    [self.labelOperateTime fitTitle:[NSString stringWithFormat:@"联系人：%@ %@",UnPackStr(model.startContact),UnPackStr(model.startPhone)] variable:self.ivUser.left - self.ivUser.right - W(40)];
    self.labelOperateTime.leftCenterY = XY(self.labelConnect.left,self.ivUser.bottom+W(1));
    
    
    self.viewBG.height = self.labelOperateTime.bottom +W(16);
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.viewBG.height+W(10));
    //设置总高度
    self.height = self.viewBG.bottom;
    
    self.conPhone.frame = CGRectMake(0, bottom, self.viewBG.width, self.viewBG.height - bottom);
}

#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.startPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

@end
