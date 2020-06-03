//
//  NoticeSectionView.m
//中车运
//
//  Created by 隋林栋 on 2018/4/18.
//Copyright © 2018年 ping. All rights reserved.
//

#import "NoticeSectionView.h"
@implementation NoticeSectionView

#pragma mark 懒加载

- (UILabel *)labelReply{
    if (_labelReply == nil) {
        _labelReply = [UILabel new];
        [GlobalMethod setLabel:_labelReply widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_TITLE text:@""];
    }
    return _labelReply;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = SCREEN_WIDTH;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    [self addSubview:self.labelReply];
    [self resetViewWithNum:0];
}
#pragma mark 刷新view
- (void)resetViewWithNum:(NSInteger)count{
    if (!count) {
        self.height = 0;
        return;
    }
    
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.labelReply  fitTitle:@"评论"  variable:0];
    self.labelReply.leftTop = XY(W(15),W(15));
    
    CGFloat bottom = [self addLineFrame:CGRectMake(W(15), W(15) + self.labelReply.bottom, SCREEN_HEIGHT-W(15), 1)];
    
    self.height = bottom;
}

@end
