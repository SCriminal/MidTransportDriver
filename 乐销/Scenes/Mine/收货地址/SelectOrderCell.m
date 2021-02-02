//
//  SelectOrderCell.m
//  Driver
//
//  Created by 隋林栋 on 2021/2/2.
//  Copyright © 2021 ping. All rights reserved.
//

#import "SelectOrderCell.h"

@implementation SelectOrderCell
#pragma mark 懒加载

- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_default"];
        _iconSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _iconSelected.widthHeight = XY(W(19),W(19));
    }
    return _iconSelected;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_999;
        _address.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _address.numberOfLines = 1;
        _address.lineSpace = W(4);
    }
    return _address;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = W(4);
    }
    return _time;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.iconSelected];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.address];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelTransportOrder *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.iconSelected.leftTop = XY(W(15),W(32));


    [self.name fitTitle:[NSString stringWithFormat:@"运单编号：%@",UnPackStr(model.orderNumber)] variable:SCREEN_WIDTH - self.iconSelected.right - W(15)];
    self.name.leftTop = XY(self.iconSelected.right + W(15),W(18));

    
    [self.address fitTitle:[NSString stringWithFormat:@"路线：%@%@-%@%@",UnPackStr(model.startCityName),UnPackStr(model.startCountyName),UnPackStr(model.endCityName),UnPackStr(model.endCountyName)] variable:SCREEN_WIDTH - self.iconSelected.right - W(15)];
    self.address.leftTop = XY(self.iconSelected.right + +W(15),self.name.bottom+W(13));
    
    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.startTime andFormatter:TIME_SEC_SHOW] variable:SCREEN_WIDTH - self.iconSelected.right - W(15)];
    self.time.leftTop = XY(self.iconSelected.right + +W(15),self.address.bottom+W(13));
    //设置总高度
    self.height =self.time.bottom + W(18);
    self.iconSelected.centerY = self.height/2.0;
}


@end
