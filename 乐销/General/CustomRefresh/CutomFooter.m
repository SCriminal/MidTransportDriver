//
//  CutomFooter.m
//中车运
//
//  Created by 隋林栋 on 2017/1/17.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "CutomFooter.h"

@implementation CutomFooter

#pragma mark lazy init
- (UILabel *)labeTitle{
    if (_labeTitle == nil) {
        _labeTitle = [UILabel new];
        [GlobalMethod setLabel:_labeTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_TITLE text:@""];
        _labeTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labeTitle;
}

- (void)prepare
{
    [super prepare];
    
    // 默认底部控件100%出现时才会自动刷新
//    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    // 设置为默认状态
//    self.automaticallyRefresh = YES;
    [self addSubview:self.labeTitle];
    
}
- (void)placeSubviews{
    [super placeSubviews];
    self.labeTitle.width = SCREEN_WIDTH;
    self.labeTitle.centerXCenterY = XY(self.width/2.0, self.height/2.0);
}
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.labeTitle  fitTitle:@"上拉加载更多"  variable:0];
            break;
        case MJRefreshStatePulling:
            [self.labeTitle  fitTitle:@"释放刷新"  variable:0];

            break;
        case MJRefreshStateRefreshing:
            [self.labeTitle  fitTitle:@"加载数据中"  variable:0];
            break;
        case MJRefreshStateNoMoreData:
            [self.labeTitle  fitTitle:@"没有更多数据"  variable:0];
            break;
        default:
            break;
    }
}


@end
