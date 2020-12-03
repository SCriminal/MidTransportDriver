//
//  OrderDetailTopView.m
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import "OrderDetailTopView.h"
#import "BulkCargoListCell.h"
@implementation OrderDetailView
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model{
    [self removeAllSubViews];//移除线
    self.model = model;
    {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_BACKGROUND;
        view.widthHeight = XY(SCREEN_WIDTH, W(10));
        [self addSubview:view];
    }
    {
        UILabel *addressFrom = [UILabel new];
        addressFrom.textColor = COLOR_333;
        addressFrom.numberOfLines = 1;
        addressFrom.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [self addSubview:addressFrom];
        
        UILabel * addressTo = [UILabel new];
        addressTo.textColor = COLOR_333;
        addressTo.numberOfLines = 1;
        addressTo.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [self addSubview:addressTo];
        
        UIImageView * iconAddress = [UIImageView new];
        iconAddress.backgroundColor = [UIColor clearColor];
        iconAddress.contentMode = UIViewContentModeScaleAspectFill;
        iconAddress.clipsToBounds = true;
        iconAddress.image = [UIImage imageNamed:@"right_balck"];
        iconAddress.widthHeight = XY(W(17),W(17));
        [self addSubview:iconAddress];
        
        iconAddress.centerXTop = XY(SCREEN_WIDTH/2.0, W(30));
        
        [addressFrom fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.startProvinceName),[model.startPortName isEqualToString:model.startProvinceName]?@"":UnPackStr(model.startPortName)] variable:W(160)];
        addressFrom.centerXCenterY = XY((iconAddress.left - W(10))/2.0+W(10), iconAddress.centerY);
        if (model.orderType == ENUM_ORDER_TYPE_INPUT) {
            [addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.placeProvinceName),[model.placeCityName isEqualToString:model.placeProvinceName]?@"":UnPackStr(model.placeCityName)] variable:W(160)];
        }else {
            [addressTo fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.endProvinceName),[model.endPortName isEqualToString:model.endProvinceName]?@"":UnPackStr(model.endPortName)] variable:W(160)];
        }
        addressTo.centerXCenterY = XY((SCREEN_WIDTH - iconAddress.right - W(10))/2.0 + SCREEN_WIDTH/2.0 + iconAddress.width/2.0, iconAddress.centerY);
    }
    NSArray * ary0 = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运单号：";
        m.subTitle = @"QD338888882222239";
        m.colorSelect = nil;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货量：";
        m.subTitle = @"2000吨";
        m.colorSelect = nil;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输费用：";
        m.subTitle = @"3000元";
        m.colorSelect = COLOR_RED;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称：";
        m.subTitle = @"设备零配件";
        m.colorSelect = nil;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前状态：";
        m.subTitle = @"待装车";
        m.colorSelect = COLOR_ORANGE;
        m.left = W(92);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"路线信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货地：";
        m.subTitle = @"山东省潍坊市寿光市和平路200号";
        m.colorSelect = nil;
        m.left = W(77);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收货地：";
        m.subTitle = @"山东省潍坊市寿光市和平路200号山东省潍坊市寿光市和平路200号山东省潍坊市寿光市和平路200号";
        m.colorSelect = nil;
        m.left = W(77);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货联系人：";
        m.subTitle = @"李林";
        m.colorSelect = nil;
        m.thirdTitle = @"15679823999";
        m.left = W(108);
        m.tag = 1;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货时间：";
        m.subTitle = @"2020-11-19 12:09:20";
        m.colorSelect = nil;
        m.left = W(108);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收货信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收货联系人：";
        m.subTitle = @"李林";
        m.colorSelect = nil;
        m.thirdTitle = @"15679823999";
        m.tag = 2;
        m.left = W(123);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"截止收货时间：";
        m.subTitle = @"2020-11-19 12:09:20";
        m.colorSelect = nil;
        m.left = W(123);
        return m;
    }()];
    NSMutableArray * ary1 = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"流转信息";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"下单：";
        m.subTitle = @"2020-11-19 12:09:20";
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"接单：";
        m.subTitle = @"2020-11-19 12:09:20";
        m.colorSelect = nil;
        m.left = W(62);
        return m;
    }()].mutableCopy;
    NSArray * ary2 = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"路线轨迹";
        m.subTitle = nil;
        m.colorSelect = nil;
        m.isSelected = true;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前位置：";
        m.subTitle = @"山东省潍坊市奎文区世博国际大厦";
        m.colorSelect = nil;
        m.left = W(93);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"当前时速：";
        m.subTitle = @"20km/h";
        m.colorSelect = nil;
        m.left = W(93);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"已驶里程：";
        m.subTitle = @"20km";
        m.colorSelect = nil;
        m.left = W(93);
        return m;
    }()].mutableCopy;
    NSMutableArray * aryAll = [NSMutableArray arrayWithArray:ary0];
    [aryAll addObjectsFromArray:ary1];
    [aryAll addObjectsFromArray:ary2];
    
    CGFloat top =  [self addLabel:aryAll top:W(72)];
    self.height = top;
}
-(CGFloat)addLabel:(NSArray *)ary top:(CGFloat)top{
    for (ModelBtn *m in ary) {
        if (m.isSelected) {
            UIView * view = [UIView new];
            view.backgroundColor = COLOR_BACKGROUND;
            view.widthHeight = XY(SCREEN_WIDTH, W(10));
            view.top = top+W(5);
            [self addSubview:view];
            
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15),view.bottom + W(15));
            [self addSubview:l];
            
            top = [self addLineFrame:CGRectMake(W(15), l.bottom + W(15), SCREEN_WIDTH - W(30), 1)] + W(15);
        }else{
            {
                UILabel * l = [UILabel new];
                l.tag = 1;
                l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                l.textColor = COLOR_666;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                l.lineSpace = W(0);
                [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
                l.leftTop = XY(W(15),top);
                [self addSubview:l];
            }
            {
                UILabel * l = [UILabel new];
                l.tag = 1;
                l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                l.textColor = m.colorSelect?m.colorSelect:COLOR_333;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                [l fitTitle:m.subTitle variable:SCREEN_WIDTH - m.left - W(15)];
                l.leftTop = XY(m.left,top);
                [self addSubview:l];
                top = l.bottom + W(15);
                if (isStr(m.thirdTitle)) {
                    UILabel * phone = [UILabel new];
                    phone.tag = 1;
                    phone.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                    phone.textColor =COLOR_BLUE;
                    phone.backgroundColor = [UIColor clearColor];
                    [phone fitTitle:m.thirdTitle variable:SCREEN_WIDTH - W(105) - W(15)];
                    phone.leftCenterY = XY(l.right + W(10),l.centerY);
                    [self addSubview:phone];
                    
                    UIView * con =[self addControlFrame:CGRectInset(phone.frame, -W(20), -W(20)) belowView:phone target:self action:@selector(phoneClick:)];
                    con.tag = m.tag;
                }
            }
        }
    }
    return top;
}
#pragma mark click
- (void)phoneClick:(UIControl *)con{
    if (con.tag == 1) {
        NSLog(@"1");
    }
    if (con.tag == 2) {
           NSLog(@"2");
       }
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.startPhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
@end
