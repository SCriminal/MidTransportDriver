//
//  GuideView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "GuideView.h"

@interface GuideView ()

@end

@implementation GuideView
#pragma mark 懒加载
- (UIScrollView *)scView{
    if (!_scView) {
        _scView = [UIScrollView new];
        _scView.contentSize = CGSizeMake(SCREEN_WIDTH *3.0, 0);
        _scView.pagingEnabled = true;
        _scView.bounces = false;
        _scView.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        _scView.showsVerticalScrollIndicator = false;
        _scView.showsHorizontalScrollIndicator = false;
    }
    return _scView;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.scView];
    {
        UIImageView * iv = [UIImageView new];
        iv.widthHeight = XY(W(375), W(512));
        iv.leftTop = XY(0, NAVIGATIONBAR_HEIGHT);
        iv.image = [UIImage imageNamed:@"guidebg_location"];
        
        UIImageView * ivSlide = [UIImageView new];
        ivSlide.widthHeight = XY(W(29), W(5));
        ivSlide.centerXBottom = XY(iv.centerX, iv.bottom + W(36));
        ivSlide.image = [UIImage imageNamed:@"guideSlide1"];
        
        [self.scView addSubview:iv];
        [self.scView addSubview:ivSlide];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.widthHeight = XY(W(375), W(512));
        iv.leftTop = XY(SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        iv.image = [UIImage imageNamed:@"guidebg_indent"];
        
        UIImageView * ivSlide = [UIImageView new];
        ivSlide.widthHeight = XY(W(29), W(5));
        ivSlide.centerXBottom = XY(iv.centerX, iv.bottom + W(36));
        ivSlide.image = [UIImage imageNamed:@"guideSlide2"];
        
        [self.scView addSubview:iv];
        [self.scView addSubview:ivSlide];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.widthHeight = XY(W(375), W(512));
        iv.leftTop = XY(SCREEN_WIDTH*2, NAVIGATIONBAR_HEIGHT);
        iv.image = [UIImage imageNamed:@"guidebg_arrive"];
        
        UIButton * btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
        btnEnter.backgroundColor = [UIColor clearColor];
        btnEnter.widthHeight = XY(W(173), W(39));
        btnEnter.centerXTop = XY(iv.centerX, iv.bottom + W(7));
        btnEnter.backgroundColor = COLOR_BLUE;
        [btnEnter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnEnter setTitle:@"立即进入" forState:UIControlStateNormal];
        btnEnter.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [btnEnter addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
        [btnEnter addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:W(39)/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        
        [self.scView addSubview:iv];
        [self.scView addSubview:btnEnter];
    }
  
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    //设置总高度
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)enterClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
