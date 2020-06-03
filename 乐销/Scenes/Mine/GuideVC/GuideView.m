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
        iv.widthHeight = XY(W(375), W(344));
        iv.leftTop = XY(0, STATUSBAR_HEIGHT + W(37));
        iv.image = [UIImage imageNamed:@"guidebg_location"];
        
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:F(25) weight:UIFontWeightSemibold];
        label.textColor = COLOR_333;
        [label fitTitle:@"实时定位" variable:0];
        label.centerXTop = XY(iv.centerX, iv.bottom + W(85));
        
        UILabel *subLabel = [UILabel new];
        subLabel.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightSemibold];
        subLabel.textColor = COLOR_999;
        [subLabel fitTitle:@"掌握行程，运输更高效" variable:0];
        subLabel.centerXTop = XY(iv.centerX, label.bottom + W(20));
        
        UIImageView * ivSlide = [UIImageView new];
        ivSlide.widthHeight = XY(W(44), W(8));
        ivSlide.centerXBottom = XY(iv.centerX, SCREEN_HEIGHT - iphoneXBottomInterval - W(45));
        ivSlide.image = [UIImage imageNamed:@"guideSlide1"];
        
        [self.scView addSubview:iv];
        [self.scView addSubview:label];
        [self.scView addSubview:subLabel];
        [self.scView addSubview:ivSlide];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.widthHeight = XY(W(375), W(344));
        iv.leftTop = XY(SCREEN_WIDTH, STATUSBAR_HEIGHT + W(37));
        iv.image = [UIImage imageNamed:@"guidebg_indent"];
        
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:F(25) weight:UIFontWeightSemibold];
        label.textColor = COLOR_333;
        [label fitTitle:@"订单跟踪" variable:0];
        label.centerXTop = XY(iv.centerX, iv.bottom + W(85));
        
        UILabel *subLabel = [UILabel new];
        subLabel.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightSemibold];
        subLabel.textColor = COLOR_999;
        [subLabel fitTitle:@"实时追踪，安全又便利" variable:0];
        subLabel.centerXTop = XY(iv.centerX, label.bottom + W(20));
        
        UIImageView * ivSlide = [UIImageView new];
        ivSlide.widthHeight = XY(W(44), W(8));
        ivSlide.centerXBottom = XY(iv.centerX, SCREEN_HEIGHT - iphoneXBottomInterval - W(45));
        ivSlide.image = [UIImage imageNamed:@"guideSlide2"];
        
        [self.scView addSubview:iv];
        [self.scView addSubview:label];
        [self.scView addSubview:subLabel];
        [self.scView addSubview:ivSlide];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.widthHeight = XY(W(375), W(344));
        iv.leftTop = XY(SCREEN_WIDTH*2, STATUSBAR_HEIGHT + W(37));
        iv.image = [UIImage imageNamed:@"guidebg_arrive"];
        
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:F(25) weight:UIFontWeightSemibold];
        label.textColor = COLOR_333;
        [label fitTitle:@"快速抵达" variable:0];
        label.centerXTop = XY(iv.centerX, iv.bottom + W(85));
        
        UILabel *subLabel = [UILabel new];
        subLabel.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightSemibold];
        subLabel.textColor = COLOR_999;
        [subLabel fitTitle:@"极速送达，省时又省事" variable:0];
        subLabel.centerXTop = XY(iv.centerX, label.bottom + W(20));
        
        UIButton * btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
        btnEnter.backgroundColor = [UIColor clearColor];
        btnEnter.widthHeight = XY(W(130), W(49));
        btnEnter.centerXBottom = XY(iv.centerX, SCREEN_HEIGHT - iphoneXBottomInterval - W(35));
        [btnEnter setBackgroundImage:[UIImage imageNamed:@"guideEnter"] forState:UIControlStateNormal];
        [btnEnter addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scView addSubview:iv];
        [self.scView addSubview:label];
        [self.scView addSubview:subLabel];
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
