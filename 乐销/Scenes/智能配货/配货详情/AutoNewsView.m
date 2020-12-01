//
//  AutoNewsView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoNewsView.h"

@interface AutoNewsView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scView;
@property (nonatomic, strong) UILabel * notice;

@end

@implementation AutoNewsView

#pragma mark lazy init
- (UILabel *)notice{
    if (!_notice) {
        _notice = ^(){
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(10) weight:UIFontWeightRegular];
            l.textColor = [UIColor colorWithHexString:@"#FF9300"];
            l.backgroundColor = [UIColor colorWithHexString:@"#FFF6E3"];
            [l fitTitle:@"公告" variable:0];
            l.textAlignment = NSTextAlignmentCenter;
            l.widthHeight = XY(W(30), W(16));
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0.5 lineColor:[UIColor colorWithHexString:@"#FF9300"]];
            l.left = W(15);
            return l;
        }();
        
    }
    return _notice;
}
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
- (UIScrollView *)scView{
    if (!_scView) {
        //添加sc
        _scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, W(345), W(28))];
        _scView.delegate = self;
        _scView.pagingEnabled = YES;
        _scView.showsHorizontalScrollIndicator = NO;
        _scView.showsVerticalScrollIndicator = NO;
        _scView.backgroundColor = [UIColor clearColor];
        _scView.bounces = NO;
        _scView.contentSize = CGSizeMake(0, CGRectGetHeight(_scView.frame)*3);
        _scView.userInteractionEnabled = false;
    }
    return _scView;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.widthHeight = XY(self.scView.width, self.scView.height);
        self.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
        [self addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:3 lineWidth:0 lineColor:[UIColor clearColor]];
        [self addSuview];
    }
    return self;
}
- (void)addSuview{    
    self.isClickValid = true;
    [self addTarget:self action:@selector(click)];
    //add subview
    [self addSubview:self.scView];
}

#pragma mark resetView
- (void)resetWithAry:(NSArray *)aryDatas{
    if (!isAry(aryDatas)) {
        return;
    }
    self.scView.scrollEnabled = aryDatas.count>1;
    self.aryDatas = aryDatas.mutableCopy;
    //reset sc
    [self resetImageAnimated:NO];
}

#pragma mark 布置图片
- (void)resetImageAnimated:(BOOL)animated{
    if (!isAry(self.aryDatas))return;
    [self.scView removeAllSubViews];
    self.numNow = self.numNow<0?self.numNow+(int)self.aryDatas.count:self.numNow;
    int numTmp =self.numNow-1<0?(int)self.aryDatas.count-1+self.numNow:self.numNow-1;
    int numFirst = numTmp%self.aryDatas.count;
    int numSec = self.numNow%self.aryDatas.count;
    int numThird = (self.numNow+1)%self.aryDatas.count;
    
    [self addLabel:numFirst index:0];
    [self addLabel:numSec index:1];
    [self addLabel:numThird index:2];
    [self.scView setContentOffset:CGPointMake(0, CGRectGetHeight(self.scView.frame)) animated:animated];
    
}

- (void)addLabel:(NSUInteger)num index:(int)index{
    
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 1;
    if (self.aryDatas.count<=num) {
        return;
    }
    l.text = UnPackStr(self.aryDatas[num]);
    l.widthHeight = XY(self.width - W(39), self.height);
    l.top = index*CGRectGetHeight(self.scView.frame);
    l.left = W(39);
    [self.scView addSubview:l];
    
    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
    iv.widthHeight = XY(W(14),W(14));
    iv.leftCenterY = XY(W(15),l.centerY);
    [iv addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:iv.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
    
    
    [self.scView addSubview:iv];
}


#pragma mark sc代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self countNum];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate ==NO) {
        [self countNum];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.numNow++;
    [self resetImageAnimated:NO];
}

#pragma mark 重新计算
- (void)countNum{
    _numTime = 1;
    if (self.scView.contentOffset.y<=5) {
        self.numNow--;
        [self resetImageAnimated:NO];
    }if (self.scView.contentOffset.y>=(CGRectGetHeight(self.scView.frame)*2-5)) {
        self.numNow++;
        [self resetImageAnimated:NO];
    }
    
}

#pragma mark image click
- (void)click{
    if (!isAry(self.aryDatas)) return;
    if (!self.isClickValid) return;
    int numSec = self.numNow%self.aryDatas.count;
    if (self.blockClick) {
        self.blockClick(numSec);
    }
}

#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
    _numTime = 0;
}

- (void)timerRun{
    //每秒的动作
    if (_numTime >0) {
        //有人触碰 时间重置
        _numTime--;
        return;
    }
    if (!self.scView.scrollEnabled) {
        return;
    }
    [self.scView setContentOffset:CGPointMake(0, CGRectGetHeight(self.scView.frame)*2) animated:YES];
}

- (void)timerStop{
    //停止定时器
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc{
    [self timerStop];
}

@end
