//
//  IntegralCenterView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralCenterView.h"

@interface IntegralCenterTopView ()

@end

@implementation IntegralCenterTopView

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //重置视图坐标
    <#重置视图坐标#>
    //设置总高度
    self.height = <#高度#>;
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
