//
//  ExchangeIntegraProductView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/28.
//Copyright © 2020 ping. All rights reserved.
//

#import "ExchangeIntegraProductView.h"

@interface ExchangeIntegraProductView ()
@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) UIImageView *minus;

@end

@implementation ExchangeIntegraProductView
#pragma mark 懒加载
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_333;
        _num.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _num.textAlignment = NSTextAlignmentCenter;
        _num.widthHeight = XY(W(50), W(30));
    }
    return _num;
}
- (UIImageView *)minus{
    if (_minus == nil) {
        _minus = [UIImageView new];
        _minus.image = [UIImage imageNamed:@"exchange_-"];
        _minus.highlightedImage = [UIImage imageNamed:@"exchange_-_select"];
        _minus.widthHeight = XY(W(9),W(1));
    }
    return _minus;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelIntegralProduct *)model{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"商品信息" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(20));
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 2;
        l.lineSpace = W(6);
        [l fitTitle:model.name variable: W(200)];
        l.leftCenterY = XY(W(15), W(66.5));
        [self addSubview:l];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"exchange_frame"];
        iv.widthHeight = XY(W(110),W(30));
        iv.rightTop = XY(SCREEN_WIDTH - W(15),50);
        [self addSubview:iv];
        
        self.num.text = @"1";
        self.num.centerXCenterY = iv.centerXCenterY;
        [self addSubview:self.num];

    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"exchange_+"];
        iv.widthHeight = XY(W(10),W(10));
        iv.rightTop = XY(SCREEN_WIDTH - W(26),W(60));
        [self addSubview:iv];
        [self addControlFrame:CGRectMake(SCREEN_WIDTH - W(15) - W(30), W(40), W(15)+W(30), W(50)) belowView:iv target:self action:@selector(addClick)];
        [self addControlFrame:CGRectMake(SCREEN_WIDTH - W(15) - W(110)- W(20), W(40), W(15)+W(30), W(50)) belowView:iv target:self action:@selector(minClick)];

    }
    self.minus.rightTop = XY(SCREEN_WIDTH - W(103), W(64));
    self.minus.highlighted = true;
    [self addSubview:self.minus];

    //设置总高度
    self.height = W(103);
    [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

- (void)addClick{
    int num = self.num.text.intValue;
    num++;
    self.num.text = NSNumber.dou(num).stringValue;
    self.minus.highlighted = true;
    if (self.blockNumChange) {
        self.blockNumChange(num);
    }
}
- (void)minClick{
    int num = self.num.text.intValue;
    if (num == 0) {
        return;
    }
    num--;
    if (num <=0) {
        num = 0;
        self.minus.highlighted = false;
    }
    self.num.text = NSNumber.dou(num).stringValue;
    if (self.blockNumChange) {
           self.blockNumChange(num);
       }
}
@end



@implementation ExchangeIntegraAddressView


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopAddress *)model{
    [self removeAllSubViews];//移除线
    //刷新view
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"收货信息" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(20));
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_BLUE;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"选择地址" variable:SCREEN_WIDTH - W(30)];
        l.rightTop = XY(SCREEN_WIDTH - W(15), W(20));
        [self addSubview:l];

        [self addControlFrame:CGRectInset(l.frame, -W(30), -W(30)) belowView:l target:self action:@selector(selectClick)];
    }
    CGFloat top = 0;
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:model.iDProperty?[NSString stringWithFormat:@"%@ %@",model.contact,model.phone]:@"请选择收货地址" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(47));
        [self addSubview:l];
        top = l.bottom;
    }
    if (model.iDProperty) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:model.addressDetailShow variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), top + W(10));
        [self addSubview:l];
        top = l.bottom;
    }
    //设置总高度
    self.height = top + W(20);
    [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

- (void)selectClick{
    if (self.blockClick) {
        self.blockClick();
    }
}

@end



@implementation ExchangeIntegraView
#pragma mark 懒加载
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_RED;
        _num.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _num;
}
- (UILabel *)all{
    if (_all == nil) {
        _all = [UILabel new];
        _all.textColor = COLOR_333;
        _all.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _all;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = W(55);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
        [self addSubview:self.num];
    [self addSubview:self.all];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelIntegralProduct *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.num fitTitle:[NSString stringWithFormat:@"%@积分",NSNumber.dou(model.qty*model.point).stringValue] variable:0];
    self.num.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    
    [self.all fitTitle:@"合计：" variable:0];
    self.all.rightCenterY = XY(self.num.left,self.num.centerY);

}

@end
