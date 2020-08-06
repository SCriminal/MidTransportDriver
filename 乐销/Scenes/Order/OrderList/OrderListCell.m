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
#import "RequestApi+Order.h"
#import "BulkCargoListCell.h"

@interface OrderListCell ()

@end

@implementation OrderListCell

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
- (UIView *)iconAddress{
    if (_iconAddress == nil) {
        _iconAddress = [UIView new];
        _iconAddress.widthHeight = XY(W(30),W(2));
        _iconAddress.backgroundColor = [UIColor colorWithHexString:@"#4E4745"];
    }
    return _iconAddress;
}
- (UILabel *)packageAddress{
    if (_packageAddress == nil) {
        _packageAddress = [UILabel new];
        _packageAddress.textColor = COLOR_666;
        _packageAddress.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _packageAddress;
}
- (UILabel *)import{
    if (_import == nil) {
        _import = [UILabel new];
        _import.textColor = COLOR_666;
        _import.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _import;
}
- (UILabel *)loadAddress{
    if (_loadAddress == nil) {
        _loadAddress = [UILabel new];
        _loadAddress.textColor = COLOR_666;
        _loadAddress.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _loadAddress;
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
        [self.contentView addSubview:self.import];
        [self.contentView addSubview:self.packageAddress];
        [self.contentView addSubview:self.loadAddress];
        [self.contentView addSubview:self.btnLeft];
        [self.contentView addSubview:self.btnRight];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderList *)model{
    self.model = model;
       //刷新view
       CGFloat top = 0;
       __block int tag = 100;
       top = [BulkCargoListCell addTitle:^(){
           ModelBtn * m = [ModelBtn new];
           m.title = @"提单号";
           m.subTitle = model.blNumber;
           m.tag = ++tag;
           return m;
       }() view:self.contentView top:W(35)];

       top = [self.contentView addLineFrame:CGRectMake(W(25), top + W(20), SCREEN_WIDTH - W(50), 1)];
       
       self.iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(50) + top);
       
       [self.addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startProvinceName),[model.startPortName isEqualToString:model.startProvinceName]?@"":UnPackStr(model.startPortName)] variable:W(160)];
       self.addressFrom.centerXCenterY = XY((self.iconAddress.left - W(10))/2.0+W(10), self.iconAddress.centerY);
    if (model.orderType == ENUM_ORDER_TYPE_INPUT) {
               [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.placeProvinceName),[model.placeCityName isEqualToString:model.placeProvinceName]?@"":UnPackStr(model.placeCityName)] variable:W(160)];

    }else {
        [self.addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endProvinceName),[model.endPortName isEqualToString:model.endProvinceName]?@"":UnPackStr(model.endPortName)] variable:W(160)];

    }
       self.addressTo.centerXCenterY = XY((SCREEN_WIDTH - self.iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + self.iconAddress.width/2.0, self.iconAddress.centerY);
       
    [self.import fitTitle:model.orderType== ENUM_ORDER_TYPE_INPUT?@"进口":@"出口" variable:0];
    self.import.centerXBottom = XY(SCREEN_WIDTH/2.0, self.iconAddress.top - W(18));
    
    [self.packageAddress fitTitle:model.orderType == ENUM_ORDER_TYPE_INPUT?@"提箱港":@"提箱点" variable:0];
    self.packageAddress.centerXCenterY = XY(self.addressFrom.centerX, self.import.centerY);
    
    [self.loadAddress fitTitle:model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货地":@"装货地" variable:0];
    self.loadAddress.centerXCenterY = XY(self.addressTo.centerX, self.import.centerY);
    
       
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
              m.title = @"运单编号";
              m.subTitle = model.waybillNumber;
              m.tag = ++tag;
              return m;
       }() view:self.contentView top:top + W(15)];
       
       top = [BulkCargoListCell addTitle:^(){
              ModelBtn * m = [ModelBtn new];
              m.title = @"箱型箱量";
           NSString * type = [ModelPackageInfo exchangeContainerType:model.total];
           m.subTitle = model.containers;
              m.tag = ++tag;
              return m;
       }() view:self.contentView top:top + W(15)];
       
       top = [BulkCargoListCell addTitle:^(){
              ModelBtn * m = [ModelBtn new];
              m.title = model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货单位":@"装货单位";
              m.subTitle = model.shipperName;
              m.tag = ++tag;
              return m;
       }() view:self.contentView top:top + W(15)];
       
       top = [BulkCargoListCell addTitle:^(){
              ModelBtn * m = [ModelBtn new];
              m.title = model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货时间":@"装货时间";
              m.subTitle = [GlobalMethod exchangeTimeWithStamp:model.placeTime andFormatter:TIME_SEC_SHOW];
              m.tag = ++tag;
              return m;
       }() view:self.contentView top:top + W(15)];
       
       top = [BulkCargoListCell addTitle:^(){
              ModelBtn * m = [ModelBtn new];
              m.title = model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货联系人":@"装货联系人";
              m.subTitle = [NSString stringWithFormat:@"%@ %@",UnPackStr(model.placeContact),UnPackStr(model.placePhone)];
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
}
- (void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        
        case 5://call
        {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.placePhone];
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

@end

