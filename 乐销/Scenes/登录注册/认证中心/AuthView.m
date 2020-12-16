//
//  AuthView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthView.h"

@interface AuthView ()

@end

@implementation AuthView

#pragma mark 刷新view
- (void)resetViewWithModel:(int)index{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
            l.textColor = [UIColor whiteColor];
            l.backgroundColor = COLOR_BLUE;
            l.text = @"1";
            l.textAlignment = NSTextAlignmentCenter;
            l.widthHeight = XY(W(25), W(25));
            l.leftTop = XY(W(50), W(20));
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:l.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
            [self addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_BLUE;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"司机信息" variable:SCREEN_WIDTH - W(30)];
            l.centerXTop = XY(W(50+12.5), W(57));
            [self addSubview:l];
        }
    }
    {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
            l.textColor = [UIColor whiteColor];
            l.backgroundColor = index>0?COLOR_BLUE:[UIColor colorWithHexString:@"#D4DEF0"];
            l.text = @"2";
            l.textAlignment = NSTextAlignmentCenter;
            l.widthHeight = XY(W(25), W(25));
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:l.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
            [self addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = index>0?COLOR_BLUE:[UIColor colorWithHexString:@"#D4DEF0"];
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"车辆信息" variable:SCREEN_WIDTH - W(30)];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(57));
            [self addSubview:l];
        }
    }
    {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
            l.textColor = [UIColor whiteColor];
            l.backgroundColor = index>1?COLOR_BLUE:[UIColor colorWithHexString:@"#D4DEF0"];
            l.text = @"3";
            l.textAlignment = NSTextAlignmentCenter;
            l.widthHeight = XY(W(25), W(25));
            l.rightTop = XY(SCREEN_WIDTH - W(50), W(20));
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:l.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
            [self addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = index>1?COLOR_BLUE:[UIColor colorWithHexString:@"#D4DEF0"];
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"营运信息" variable:SCREEN_WIDTH - W(30)];
            l.centerXTop = XY(SCREEN_WIDTH - W(50+12.5), W(57));
            [self addSubview:l];
        }
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = index>0?COLOR_BLUE:[UIColor colorWithHexString:@"#D4DEF0"];;
        view.widthHeight = XY(W(88), W(2));
        view.leftTop = XY(W(81), W(32));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:1 lineWidth:0 lineColor:[UIColor clearColor]];
        [self addSubview:view];
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = index>1?COLOR_BLUE:[UIColor colorWithHexString:@"#D4DEF0"];;
        view.widthHeight = XY(W(88), W(2));
        view.leftTop = XY(W(206), W(32));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:1 lineWidth:0 lineColor:[UIColor clearColor]];
        [self addSubview:view];
    }
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = W(89);
    }
    return self;
}

@end

@implementation AuthTitleView

#pragma mark 刷新view
- (void)resetViewWithModel:(NSString *)title{
    [self removeAllSubViews];//移除线
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_999;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(0);
    [l fitTitle:title variable:SCREEN_WIDTH - W(30)];
    l.leftCenterY = XY(W(10), self.height/2.0);
    [self addSubview:l];
    
    if (!isStr(title)) {
        self.height = W(10);
    }
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = W(37);
    }
    return self;
}

@end


@implementation AuthBtnView

#pragma mark 刷新view
- (void)resetViewWithModel:(int)index{
    [self removeAllSubViews];//移除线
    
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(345), W(40));
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        btn.backgroundColor = COLOR_BLUE;
        [btn setTitle:@"下一步" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
        [self addSubview:btn];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(345), W(40));
        btn.centerXCenterY = XY(SCREEN_WIDTH/2.0, W(81.5));
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"保存稍后完善" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [btn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = W(120);
        [self resetViewWithModel:0];
    }
    return self;
}

-(void)btnConfirmClick{
    if (self.blockConfirmClick) {
        self.blockConfirmClick();
    }
}

-(void)btnDismissClick{
    if (self.blockDismissClick) {
        self.blockDismissClick();
    }
}

@end
