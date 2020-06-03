//
//  NoResultView.m
//中车运
//
//  Created by mengxi on 17/1/19.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NoResultView.h"

@implementation NoResultView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.fontNum = F(17);
        _labelTitle.textColor = [UIColor colorWithHexString:@"BABABA"];

    }
    return _labelTitle;
}

- (UIImageView *)ivNoResult{
    if (!_ivNoResult) {
        _ivNoResult = [UIImageView new];
        _ivNoResult.backgroundColor = [UIColor clearColor];
        _ivNoResult.widthHeight = XY(W(200), W(200));
    }
    return _ivNoResult;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.labelTitle];
    [self addSubview:self.ivNoResult];
}

#pragma mark show 
- (void)showInView:(UIView *)viewShow frame:(CGRect)frame{
    self.frame = frame;
    [self resetView];
    [viewShow addSubview:self];
}

#pragma mark 创建
+ (instancetype)initWithFrame:(CGRect)frame{
    NoResultView * view = [NoResultView new];
    view.frame = frame;
    [view resetView];
    return view;
}

#pragma mark 刷新view
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.ivNoResult.centerXTop = XY(self.width/2.0, W(122));
    self.labelTitle.centerXTop = XY(self.width / 2,self.ivNoResult.bottom + W(46));
    if (self.verticalModify) {
        [self modifySubViewsY:self.verticalModify];
    }
}

//reset with image
- (void)resetWithImageName:(NSString *)imageName title:(NSString *)title{
    self.ivNoResult.image = [UIImage imageNamed:imageName];
    [self.labelTitle fitTitle:title variable:0];
}
- (void)modifySubViewsY:(double)height{
    self.ivNoResult.top  += height;
    self.labelTitle.top += height;

}
@end
