//
//  OrderListCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderListCell.h"
//order detail vc
#import "OrderDetailVC.h"
//request


@interface OrderListCell ()

@end

@implementation OrderListCell
#pragma mark 懒加载

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.width = SCREEN_WIDTH;
    }
    return _viewBG;
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
- (UIImageView *)iconAddress{
    if (_iconAddress == nil) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"right_balck"];
        iv.widthHeight = XY(W(17),W(17));
        _iconAddress = iv;
    }
    return _iconAddress;
}
- (OrderListCellBtnView *)btnView{
    if (!_btnView) {
        _btnView = [OrderListCellBtnView new];
    }
    return _btnView;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        self.backgroundColor = COLOR_BACKGROUND;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = false;
        [self.contentView addSubview:self.viewBG];
        [self.contentView addSubview:self.addressFrom];
        [self.contentView addSubview:self.addressTo];
        [self.contentView addSubview:self.iconAddress];
        [self.contentView addSubview:self.btnView];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelTransportOrder *)model{
    self.model = model;
    //刷新view
    self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
    
    [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startCityName),UnPackStr(model.startCountyName)] variable:W(160)];
    self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endCityName),UnPackStr(model.endCountyName)] variable:W(160)];

    self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
    
    CGFloat top = self.addressTo.bottom;
    
    top = [self addLabel:@[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运单号：";
        m.subTitle = model.orderNumber;
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货量：";
        m.subTitle = [NSString stringWithFormat:@"%@%@",model.qtyShow,model.unitShow];
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称：";
        m.subTitle = isStr(model.cargoName)?model.cargoName:@"暂无货物名称";
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货联系人：";
        m.subTitle = model.startContacter;
        m.colorSelect = nil;
        m.thirdTitle = model.startPhone;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货时间：";
        m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.startTime andFormatter:TIME_SEC_SHOW];
        m.colorSelect = nil;
        m.thirdTitle = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前状态：";
        m.subTitle = model.orderStatusShow;
        m.colorSelect = model.colorStateShow;
        m.thirdTitle = nil;
        return m;
    }()] top:top];
    
   
    [self.btnView resetViewWithModel:self.model];
    self.btnView.top = top + W(20);
    if (self.btnView.height>1) {
        top = self.btnView.bottom;
    }

    self.viewBG.height = top + W(20);
    //设置总高度
    self.height = self.viewBG.bottom + W(12);
    
}

- (CGFloat)addLabel:(NSArray *)ary top:(CGFloat)top{
    [self.contentView removeSubViewWithTag:1];
    top = top + W(25) - W(15);
    for (ModelBtn *m in ary) {
        {
            UILabel * l = [UILabel new];
            l.tag = 1;
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15),top + W(15));
            [self.contentView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.tag = 1;
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = m.colorSelect?m.colorSelect:COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 1;
            [l fitTitle:m.subTitle variable:SCREEN_WIDTH - W(105) - W(15)];
            l.leftTop = XY(W(105),top + W(15));
            [self.contentView addSubview:l];
            top = l.bottom;
            if (isStr(m.thirdTitle)) {
                UILabel * phone = [UILabel new];
                phone.tag = 1;
                phone.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                phone.textColor =COLOR_BLUE;
                phone.backgroundColor = [UIColor clearColor];
                [phone fitTitle:m.thirdTitle variable:SCREEN_WIDTH - W(105) - W(15)];
                phone.leftCenterY = XY(l.right + W(10),l.centerY);
                [self.contentView addSubview:phone];
                
                UIView * con =[self.contentView addControlFrame:CGRectInset(phone.frame, -W(20), -W(20)) belowView:phone target:self action:@selector(phoneClick)];
                con.tag = 1;
            }
        }
    }
    return top;
}

- (void)phoneClick{
    if (isStr(self.model.startPhone)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.startPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [GlobalMethod showAlert:@"暂无联系电话"];
    }
}
@end


