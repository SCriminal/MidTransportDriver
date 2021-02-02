//
//  IntegralCenterView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralCenterView.h"

@interface IntegralCenterTopView ()
@property (nonatomic, strong) UILabel *labelNum;

@end

@implementation IntegralCenterTopView

#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)ary{
    [self removeAllSubViews];
    self.backgroundColor = [UIColor clearColor];
    
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"creditbg"];
        iv.widthHeight = XY(W(375),W(210));
        iv.leftTop = XY(0,-W(64));
        [self addSubview:iv];
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(345), W(154));
        view.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
        [self addSubview:view];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        l.textColor = COLOR_BLUE;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"200000" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(33), W(35));
        [self addSubview:l];
        self.labelNum = l;
        
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"当前积分" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(33), W(65));
        [self addSubview:l];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(80), W(34));
        btn.backgroundColor = COLOR_BLUE;
        [btn setTitle:@"签到" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnSignClick) forControlEvents:UIControlEventTouchUpInside];
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor clearColor]];
        btn.rightTop = XY(SCREEN_WIDTH - W(33), W(39));
        [self addSubview:btn];
    }
    //重置视图坐标
    
    CGFloat left = W(33);
    for (int i = 0; i<ary.count; i++) {
        ModelBaseData * item = ary[i];
        UILabel * l = [UILabel new];
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightMedium];
        l.widthHeight = XY(W(32), W(32));
        l.text = item.string;
        l.leftTop = XY(left, W(107));
        [self addSubview:l];
        left = l.right + W(14);
        if (item.enumType == 1) {
            l.textColor = [UIColor whiteColor];
            l.backgroundColor = COLOR_BLUE;
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:l.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        }
        if (item.enumType ==0) {
            l.textColor = [UIColor colorWithHexString:@"#D4DEF0"];
            l.backgroundColor = [UIColor whiteColor];
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:l.width/2.0 lineWidth:1 lineColor:l.textColor];
        }
        if (item.enumType ==-1) {
            l.textColor = COLOR_BLUE;
            l.backgroundColor = [UIColor whiteColor];
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:l.width/2.0 lineWidth:1 lineColor:l.textColor];
        }
    }
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"积分商品" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(189));
        [self addSubview:l];
    }
    //设置总高度
    self.height = W(205);
}
- (void)btnSignClick{
    if (self.blockSign) {
        self.blockSign();
    }
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

@end
