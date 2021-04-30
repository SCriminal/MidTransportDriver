//
//  ImageCodeView.m
//  Driver
//
//  Created by Happy on 2021/4/12.
//Copyright © 2021 ping. All rights reserved.
//

#import "ImageCodeView.h"

@interface ImageCodeView ()
@property (nonatomic, strong) UIView *bg;
@property (nonatomic, strong) UIView *whitBG;
@property (nonatomic, strong) UIImageView *ivBig;
@property (nonatomic, strong) UIImageView *ivSmall;
@property (nonatomic, strong) UIView *sliderBG;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *alert;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *close;
@property (nonatomic, strong) UIControl *closeControle;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *refresh;
@property (nonatomic, strong) UIControl *refreshControle;


@end

@implementation ImageCodeView
#pragma mark 懒加载
- (UIView *)bg{
    if (!_bg) {
        _bg = [UIView new];
        _bg.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        _bg.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        [_bg addTarget:self action:@selector(hideClick)];
    }
    return _bg;
}
- (UIView *)whitBG{
    if (_whitBG == nil) {
        _whitBG = [UIView new];
        _whitBG.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_whitBG color:[UIColor clearColor] numRound:4 width:0];
    }
    return _whitBG;
}
- (UIImageView *)ivBig{
    if (_ivBig == nil) {
        _ivBig = [UIImageView new];
        _ivBig.contentMode = UIViewContentModeScaleAspectFill;
        _ivBig.clipsToBounds = true;
    }
    return _ivBig;
}
- (UIImageView *)ivSmall{
    if (_ivSmall == nil) {
        _ivSmall = [UIImageView new];
        _ivSmall.contentMode = UIViewContentModeScaleAspectFill;
        _ivSmall.clipsToBounds = true;

    }
    return _ivSmall;
}
- (UIImageView *)refresh{
    if (_refresh == nil) {
        _refresh = [UIImageView new];
        _refresh.image = [UIImage imageNamed:@"slider_refresh"];
        _refresh.widthHeight = XY(W(23),W(23));
    }
    return _refresh;
}
- (UIControl *)refreshControle{
    if (_refreshControle == nil) {
        _refreshControle = [UIControl new];
        _refreshControle.tag = 1;
        [_refreshControle addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
        _refreshControle.backgroundColor = [UIColor clearColor];
        _refreshControle.widthHeight = XY(W(23)+W(10),W(23)+W(5));
    }
    return _refreshControle;
}

- (UIView *)sliderBG{
    if (!_sliderBG) {
        _sliderBG = [UIView new];
        _sliderBG.backgroundColor = [UIColor colorWithHexString:@"#F8FAFE"];
        [GlobalMethod setRoundView:_sliderBG color:[UIColor colorWithHexString:@"#E7E7E7"] numRound:0 width:1];
    }
    return _sliderBG;
}
- (UISlider *)slider{
    if (!_slider) {
        _slider = [UISlider new];
        [_slider addTarget:self action:@selector(buttonAction:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
        
        UIImage *leftTrack = [[UIImage imageNamed:@"SliderTrackLeft"]
        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
         
        [_slider setMinimumTrackImage:leftTrack forState:UIControlStateNormal];
            
        UIImage *rightTrack = [[UIImage imageNamed:@"slider_gray"]
        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        [_slider setMaximumTrackImage:rightTrack forState:UIControlStateNormal];
        
        [_slider setThumbImage:[UIImage imageNamed:@"slider_default"] forState:UIControlStateNormal];
        [_slider setThumbImage:[UIImage imageNamed:@"slider_default"] forState:UIControlStateHighlighted];
    }
    return _slider;
}
- (UILabel *)alert{
    if (_alert == nil) {
        _alert = [UILabel new];
        _alert.textColor = [UIColor colorWithHexString:@"#575770"];
        _alert.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_alert fitTitle:@"向右滑动滑块填充拼图" variable:0];
    }
    return _alert;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_title fitTitle:@"请完成安全验证" variable:0];
    }
    return _title;
}
- (UIImageView *)close{
    if (_close == nil) {
        _close = [UIImageView new];
        _close.image = [UIImage imageNamed:@"inputClose"];
        _close.widthHeight = XY(W(23),W(23));
    }
    return _close;
}
- (UIControl *)closeControle{
    if (_closeControle == nil) {
        _closeControle = [UIControl new];
        _closeControle.tag = 1;
        [_closeControle addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
        _closeControle.backgroundColor = [UIColor clearColor];
        _closeControle.widthHeight = XY(W(23)+W(10),W(23)+W(10));
    }
    return _closeControle;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;

        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.bg];
        [self addSubview:self.whitBG];
    [self addSubview:self.title];
 [self addSubview:self.close];
 [self addSubview:self.closeControle];
 [self addSubview:self.line];
    [self addSubview:self.ivBig];
    [self addSubview:self.ivSmall];
    [self addSubview:self.sliderBG];
    [self addSubview:self.slider];
    [self addSubview:self.alert];
    [self addSubview:self.refresh];
[self addSubview:self.refreshControle];

}

#pragma mark 刷新view
- (void)resetViewWithModel:(NSString *)urlBig urlSmal:(NSString *)urlSmall alert:(NSString *)alert identity:(double)identity{
    self.identity = identity;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat top = SCREEN_HEIGHT/2.0-W(110);
    self.whitBG.width = W(314);
    self.whitBG.centerXTop = XY(SCREEN_WIDTH/2.0,top);

    self.title.leftTop = XY(self.whitBG.left + W(15), self.whitBG.top + W(19));
    
    self.close.rightTop = XY(self.whitBG.right - W(15), self.whitBG.top+W(15));
    self.closeControle.center = self.close.center;
    self.line.widthHeight = XY(self.whitBG.width, 1);
    self.line.leftTop = XY(self.whitBG.left, self.whitBG.top + W(53));
    
    [self.ivBig sd_setImageWithURL:[NSURL URLWithString:UnPackStr(urlBig)] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.ivBig.widthHeight = XY(W(284), W(142));
    self.ivBig.centerXTop = XY(SCREEN_WIDTH/2.0,self.whitBG.top+W(70));
    
    self.refresh.rightTop = XY(self.ivBig.right, self.ivBig.top);
    self.refreshControle.center = self.refresh.center;
//
    [self.ivSmall sd_setImageWithURL:[NSURL URLWithString:UnPackStr(urlSmall)] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.ivSmall.widthHeight = XY(W(142)*91.0/240.0, W(142));
    self.ivSmall.leftTop = XY(W(0),self.ivBig.top);
    
    self.sliderBG.widthHeight = XY(W(284), 37);
    self.sliderBG.leftTop = XY(W(46),self.ivBig.bottom+W(12));

    self.slider.widthHeight = self.sliderBG.widthHeight;
    self.slider.leftTop = self.sliderBG.leftTop;
    
//    [self.alert fitTitle:UnPackStr(alert) variable:0];
    self.alert.centerXCenterY = XY(SCREEN_WIDTH/2.0,self.slider.centerY);

    self.whitBG.height = self.slider.bottom + W(15) - top;
    
    [self reconfigSlider];
}

//图片验证滑块的所有事件
- (void)buttonAction:(UISlider*)slider forEvent:(UIEvent *)event{
    UITouchPhase phase = event.allTouches.anyObject.phase;
    if (phase == UITouchPhaseBegan) {
        self.alert.hidden = true;
    }else if(phase == UITouchPhaseEnded){
        if (self.blockEnd) {
            self.blockEnd(self.slider.value*(self.ivBig.width - self.ivSmall.width),self.identity,self.ivBig.width);
        }
    }else if (phase == UITouchPhaseMoved){
        [self changeSliderWithVlue:slider.value];
    }
}

//设置默认的滑动
- (void)reconfigSlider{
    self.slider.value = 0;
    [self changeSliderWithVlue:self.slider.value];
    self.alert.hidden = false;
}
-(void)refreshClick{
    if (self.blockRefresh) {
        self.blockRefresh();
    }
    [self removeFromSuperview];
}
//图片位置随着Slider滑动改变frame
- (void)changeSliderWithVlue:(CGFloat)value{
    self.ivSmall.x = W(46) + value * (self.ivBig.width-self.ivSmall.width);
}
- (void)hideClick{
    [self removeFromSuperview];
}

-(void)valideSuccess{
    UIImage *leftTrack = [[UIImage imageNamed:@"SliderTrackRight"]
    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
     
    [_slider setMinimumTrackImage:leftTrack forState:UIControlStateNormal];
        
    UIImage *rightTrack = [[UIImage imageNamed:@"slider_gray"]
    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [_slider setMaximumTrackImage:rightTrack forState:UIControlStateNormal];
    
    [_slider setThumbImage:[UIImage imageNamed:@"slider_success"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"slider_success"] forState:UIControlStateHighlighted];

}
-(void)valideFail{
    UIImage *leftTrack = [[UIImage imageNamed:@"SliderTrackRed"]
    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
     
    [_slider setMinimumTrackImage:leftTrack forState:UIControlStateNormal];
        
    UIImage *rightTrack = [[UIImage imageNamed:@"slider_gray"]
    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [_slider setMaximumTrackImage:rightTrack forState:UIControlStateNormal];
    
    [_slider setThumbImage:[UIImage imageNamed:@"slider_red"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"slider_red"] forState:UIControlStateHighlighted];
}

@end
