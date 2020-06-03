//
//  CommentStarView.m
//中车运
//
//  Created by 隋林栋 on 2017/9/2.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "CommentStarView.h"

@interface CommentStarView ()

@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, assign) NSInteger indexSelect;
@end

@implementation CommentStarView

#pragma mark lazy init

- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
- (CGFloat)currentScore{
    return (self.indexSelect+1) / 2.0;
}
- (void)setCurrentScore:(CGFloat)currentScore{
    [self resetViewWithIndex:(NSInteger)(currentScore*2-1)];
}
#pragma mark touch
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    //    NSLog(@"beginTrackingWithTouch");
    [self touchPoint:[touch locationInView:self]];
    return YES;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    //    NSLog(@"cancelTrackingWithEvent");
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self touchPoint:[touch locationInView:self]];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self touchPoint:[touch locationInView:self]];
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark deal with touch point
- (void)touchPoint:(CGPoint )point{
    if (!CGRectContainsPoint(self.bounds, point)) return;
    NSInteger index = ceil(point.x/([self fetchItemSize].width * 5) * 10)-1;
    //    NSLog(@"index  %lf  %ld",point.x,index);
    [self resetViewWithIndex:index];
}

/**
 reset star view with index
 
 @param index select index 0~9
 */
- (void)resetViewWithIndex:(NSInteger)index{
    if (self.indexSelect == index && index) {
        return;
    }
    self.indexSelect = index;
    for (int i = 0; i<5; i++) {
        NSString * strImageName = @"star_g";
        if (index >= i*2) {
            strImageName = (index == i*2)?@"star_b":@"star_l";
        }
        CommentStarItemView * itemView =  [self fetchWithIndex:i];
        itemView.ivStar.image = [UIImage imageNamed:strImageName];
    }
    if (!self.isShowGrayStarBg) {
//        NSLog(@"%lf  %lf",ceil(self.currentScore),[self fetchItemSize].width);
        self.width = ceil(self.currentScore) * [self fetchItemSize].width;
    }
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.clipsToBounds = true;
    }
    return self;
}
//添加subview
- (void)configDefaultView{
    self.width = [self fetchItemSize].width * 5;//默认宽度
    self.height = [self fetchItemSize].height*2;

    //初始化页面
    for (int i = 0; i< 5; i++) {
        CommentStarItemView * startDefaultView = [self fetchWithIndex:i];
        startDefaultView.leftCenterY = XY(i * [self fetchItemSize].width, self.height/2.0);
        [self addSubview:startDefaultView];
    }
}

- (CommentStarItemView *)fetchWithIndex:(NSInteger)index{
    while ((self.aryDatas.count < index+1 )&& (self.aryDatas.count < 5)) {
        [self.aryDatas addObject:^(){
            CommentStarItemView * startDefaultView = [CommentStarItemView new];
            return startDefaultView;
        }()];
    }
    return index<5?self.aryDatas[index]:nil;
}
#pragma mark 获取宽高
- (CGSize)fetchItemSize{
    static CGSize size ;
    if (size.width == 0) {
        CommentStarItemView * starView = [CommentStarItemView new];
        size = CGSizeMake(starView.width + self.interval, starView.height);
    }
    return size;
}
@end

@implementation CommentStarItemView

#pragma mark lazy init
- (UIImageView *)ivStar{
    if (!_ivStar) {
        _ivStar = [UIImageView new];
        _ivStar.image = [UIImage imageNamed:@"star_g"];
        _ivStar.widthHeight = XY(W(11), W(11));
        _ivStar.backgroundColor = [UIColor clearColor];
    }
    return _ivStar;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = self.ivStar.width ;//默认宽度
        self.height = self.ivStar.height;
        self.userInteractionEnabled = false;
        [self addSubview:self.ivStar];
    }
    return self;
}

@end

