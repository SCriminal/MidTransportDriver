//
//  ScanListCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/11/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "ScanListCell.h"

@interface ScanListCell ()

@end

@implementation ScanListCell
#pragma mark 懒加载
- (UILabel *)labelBillNo{
    if (_labelBillNo == nil) {
        _labelBillNo = [UILabel new];
        _labelBillNo.textColor = COLOR_333;
        _labelBillNo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelBillNo.numberOfLines = 1;
        _labelBillNo.lineSpace = 0;
    }
    return _labelBillNo;
}
- (UILabel *)labelScheduleNo{
    if (_labelScheduleNo == nil) {
        _labelScheduleNo = [UILabel new];
        _labelScheduleNo.textColor = COLOR_333;
        _labelScheduleNo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelScheduleNo.numberOfLines = 1;
        _labelScheduleNo.lineSpace = 0;
    }
    return _labelScheduleNo;
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

- (UILabel *)labelCargo{
    if (_labelCargo == nil) {
        _labelCargo = [UILabel new];
        _labelCargo.textColor = COLOR_333;
        _labelCargo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelCargo.numberOfLines = 1;
        _labelCargo.lineSpace = 0;
    }
    return _labelCargo;
}
- (UILabel *)labelWeight{
    if (_labelWeight == nil) {
        _labelWeight = [UILabel new];
        _labelWeight.textColor = COLOR_333;
        _labelWeight.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelWeight.numberOfLines = 1;
        _labelWeight.lineSpace = 0;
    }
    return _labelWeight;
}
- (UIImageView *)iconScheduleNo{
    if (_iconScheduleNo == nil) {
        _iconScheduleNo = [UIImageView new];
        _iconScheduleNo.image = [UIImage imageNamed:@"schedule_scheduleNo"];
        _iconScheduleNo.widthHeight = XY(W(25),W(25));
    }
    return _iconScheduleNo;
}
- (UIImageView *)iconNo{
    if (_iconNo == nil) {
        _iconNo = [UIImageView new];
        _iconNo.image = [UIImage imageNamed:@"schedule_No"];
        _iconNo.widthHeight = XY(W(25),W(25));
    }
    return _iconNo;
}

- (UIImageView *)iconCargo{
    if (_iconCargo == nil) {
        _iconCargo = [UIImageView new];
        _iconCargo.image = [UIImage imageNamed:@"schedule_cargo"];
        _iconCargo.widthHeight = XY(W(25),W(25));
    }
    return _iconCargo;
}
- (UIImageView *)iconWeight{
    if (_iconWeight == nil) {
        _iconWeight = [UIImageView new];
        _iconWeight.image = [UIImage imageNamed:@"schedule_weight"];
        _iconWeight.widthHeight = XY(W(25),W(25));
    }
    return _iconWeight;
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
        [self.contentView addSubview:self.labelScheduleNo];
        [self.contentView addSubview:self.labelTo];
        [self.contentView addSubview:self.labelBillNo];
        [self.contentView addSubview:self.labelStatus];
        [self.contentView addSubview:self.labelCargo];
        [self.contentView addSubview:self.labelAddressFrom];
        [self.contentView addSubview:self.labelAddressTo];
        [self.contentView addSubview:self.labelWeight];
        [self.contentView addSubview:self.iconWeight];
        [self.contentView addSubview:self.iconNo];
        [self.contentView addSubview:self.iconScheduleNo];
        [self.contentView addSubview:self.iconCargo];
        [self.contentView addSubview:self.iconArrow];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelScheduleList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
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

    [self.contentView addLineFrame:CGRectMake(W(25), self.labelAddressFrom.bottom+W(20), SCREEN_WIDTH - W(50), 1)];
    
    self.iconScheduleNo.leftTop = XY(W(25), self.labelAddressFrom.bottom + W(35));
    [self.labelScheduleNo fitTitle:[NSString stringWithFormat:@"计划单号：%@",UnPackStr(model.planNumber)] variable:SCREEN_WIDTH - self.iconNo.right - W(40)];
    self.labelScheduleNo.leftCenterY = XY(self.iconScheduleNo.right + W(10), self.iconScheduleNo.centerY);
    
    self.iconNo.leftTop = XY(self.iconScheduleNo.left, self.iconNo.bottom+ W(10));
    [self.labelBillNo fitTitle:[NSString stringWithFormat:@"运单号：%@",UnPackStr(model.waybillNumber)] variable:SCREEN_WIDTH - self.iconNo.right - W(40)];
    self.labelBillNo.leftCenterY = XY(self.iconNo.right + W(10), self.iconNo.centerY);
    
   
    BOOL isNoInvalid = !isStr(model.waybillNumber);
    self.iconNo.hidden = isNoInvalid;
    self.labelBillNo.hidden = isNoInvalid;
    
    self.iconCargo.leftTop = XY(self.iconNo.left,isNoInvalid? self.iconScheduleNo.bottom+ W(10):self.iconNo.bottom+ W(10));
    [self.labelCargo fitTitle:[NSString stringWithFormat:@"货物名称：%@",UnPackStr(model.cargoName)] variable:SCREEN_WIDTH - self.iconNo.right - W(40)];
    self.labelCargo.leftCenterY = XY(self.iconCargo.right + W(10), self.iconCargo.centerY);
    
    self.iconWeight.leftTop = XY(self.iconNo.left,self.iconCargo.bottom+ W(10));
    [self.labelWeight fitTitle:[NSString stringWithFormat:@"发货量：%@%@",NSNumber.dou(model.actualLoad),UnPackStr(model.loadUnit)] variable:SCREEN_WIDTH - self.iconNo.right - W(80)];
    self.labelWeight.leftCenterY = XY(self.iconWeight.right + W(10), self.iconWeight.centerY);
    
    [self.labelStatus fitTitle:model.scheduleStatusShow variable:0];
    self.labelStatus.textColor = model.colorStateShow;
    self.labelStatus.rightCenterY = XY(SCREEN_WIDTH - W(25),self.iconWeight.centerY);
    
    self.contentView.height = self.iconWeight.bottom +W(16);
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.height+W(10));
    //设置总高度
    self.height = self.contentView.bottom;
    
}



@end
