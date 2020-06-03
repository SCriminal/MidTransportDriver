//
//  AutoScView.m
//  丰生活
//
//  Created by 隋林栋 on 16/1/25.
//  Copyright © 2016年 Sl. All rights reserved.
//

#import "AutoScView.h"
//big image
#import "ImageDetailBigView.h"
//网络加载图片
#import <SDWebImage/UIImageView+WebCache.h>

@interface AutoScView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scView;
@property (nonatomic, strong) UIPageControl * pageControl;
@end

@implementation AutoScView
@synthesize pageCurrentColor = _pageCurrentColor;
@synthesize pageDefaultColor = _pageDefaultColor;

#pragma mark lazy init
- (void)setPageControlToBottom:(CGFloat)pageControlToBottom{
    _pageControlToBottom = pageControlToBottom;
    _pageControl.centerXBottom = XY(self.width/2.0,self.height-pageControlToBottom);
}
- (UIColor *)pageCurrentColor{
    if (!_pageCurrentColor) {
        _pageCurrentColor = COLOR_SUBTITLE;
    }
    return _pageCurrentColor;
}
- (void)setPageCurrentColor:(UIColor *)pageCurrentColor{
    _pageCurrentColor = pageCurrentColor;
    _pageControl.currentPageIndicatorTintColor = pageCurrentColor;
}
- (UIColor *)pageDefaultColor{
    if (!_pageDefaultColor) {
        _pageDefaultColor = COLOR_TITLE;
    }
    return _pageDefaultColor;
}
-(void)setPageDefaultColor:(UIColor *)pageDefaultColor{
    _pageDefaultColor = pageDefaultColor;
    _pageControl.pageIndicatorTintColor = pageDefaultColor;
}
- (NSMutableArray *)aryImage{
    if (!_aryImage) {
        _aryImage = [NSMutableArray new];
    }
    return _aryImage;
}
- (UIScrollView *)scView{
    if (!_scView) {
        //添加sc
        _scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scView.delegate = self;
        _scView.pagingEnabled = YES;
        _scView.showsHorizontalScrollIndicator = NO;
        _scView.showsVerticalScrollIndicator = NO;
        _scView.backgroundColor = [UIColor clearColor];
        _scView.bounces = NO;
        _scView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*3, 0);
    }
    return _scView;
}
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.width, W(30)) ];
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    return _pageControl;
}
#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSuview];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame image:(NSArray *)aryImage{
    self = [super initWithFrame:frame];
    if (self ) {
        [self addSuview];
        //refresh rect
        [self resetWithImageAry:aryImage];
    }
    return self;
}
- (void)addSuview{
    self.backgroundColor = [UIColor whiteColor];
    self.isClickValid = true;
    //add subview
    [self addSubview:self.scView];
    [self addSubview:self.pageControl];
}

#pragma mark resetView
- (void)resetWithImageAry:(NSArray *)aryImage{
    self.aryImage = aryImage.mutableCopy;
    //reset sc
    self.scView.widthHeight = XY(self.width, self.height);
    self.scView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*3, 0);

    //reset control
    self.pageControl.currentPageIndicatorTintColor = self.pageCurrentColor;
    self.pageControl.pageIndicatorTintColor = self.pageDefaultColor;
    self.pageControl.numberOfPages = self.aryImage.count;
    self.pageControl.hidden = _pageControl.numberOfPages <= 1;
    self.pageControl.width = self.width;
    self.pageControl.centerXBottom = XY(self.width/2.0,self.height-self.pageControlToBottom);
    [self resetImageAnimated:NO];
}


#pragma mark 布置图片
- (void)resetImageAnimated:(BOOL)animated{
    if (!isAry(self.aryImage))return;
    [self.scView removeAllSubViews];
    self.numNow = self.numNow<0?self.numNow+(int)self.aryImage.count:self.numNow;
    int numTmp =self.numNow-1<0?(int)self.aryImage.count-1+self.numNow:self.numNow-1;
    int numFirst = numTmp%self.aryImage.count;
    int numSec = self.numNow%self.aryImage.count;
    int numThird = (self.numNow+1)%self.aryImage.count;
    
    [self addImage:numFirst index:0];
    [self addImage:numSec index:1];
    [self addImage:numThird index:2];
    [self.scView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:animated];
    self.pageControl.currentPage = numSec;
    if (self.blockNum) {
        self.blockNum(self.aryImage.count,numSec+1);
    }
}

- (void)addImage:(NSUInteger)num index:(int)index{
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(index*CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    iv.backgroundColor = [UIColor clearColor];
    if (self.aryImage.count<=num) {
        return;
    }
    iv.image = [UIImage imageNamed:self.aryImage[num]];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    if (iv.image == nil) {
        if (self.isShowProductImageStyle) {
            [iv sd_setProductImageWithURL:[NSURL URLWithString:self.aryImage[num]] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        }else{
            [iv sd_setImageWithURL:[NSURL URLWithString:self.aryImage[num]] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        }
    }
    iv.clipsToBounds = true;
    [iv addTarget:self action:@selector(imageClick:)];
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
    if (self.scView.contentOffset.x<=5) {
        self.numNow--;
        [self resetImageAnimated:NO];
    }if (self.scView.contentOffset.x>=(CGRectGetWidth(self.frame)*2-5)) {
        self.numNow++;
        [self resetImageAnimated:NO];
    }
    
}

#pragma mark image click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    if (!isAry(self.aryImage)) return;
    if (!self.isClickValid) return;
    UIImageView * iv = (UIImageView *)tap.view;
    if (iv && [iv isKindOfClass:[UIImageView class]]) {
        ImageDetailBigView * detailView = [ImageDetailBigView new];
        int numSec = self.numNow%self.aryImage.count;
        [detailView resetView:^(){
            NSMutableArray * aryImages = [NSMutableArray new];
            for (NSString * strImage in self.aryImage) {
                ModelImage * model = [ModelImage new];
                model.url = strImage;
                [aryImages addObject:model];
            }
            return aryImages;
        }() isEdit:false index: numSec];
        [detailView showInView:[GB_Nav.lastVC view] imageViewShow:iv];
    }
}

#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
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
    [self.scView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*2, 0) animated:YES];
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
