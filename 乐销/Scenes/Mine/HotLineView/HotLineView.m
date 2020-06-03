//
//  HotLineView.m
//中车运
//
//  Created by 隋林栋 on 2018/10/18.
//Copyright © 2018年 ping. All rights reserved.
//

#import "HotLineView.h"

@interface HotLineView ()

@end

@implementation HotLineView
#pragma mark 懒加载
- (UILabel *)serviceNumber{
    if (_serviceNumber == nil) {
        _serviceNumber = [UILabel new];
        _serviceNumber.textColor = COLOR_999;
        _serviceNumber.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _serviceNumber.numberOfLines = 0;
        _serviceNumber.lineSpace = 0;
    }
    return _serviceNumber;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.serviceNumber];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.serviceNumber fitTitle:@"客服电话:4000-778-006" variable:0];
    self.serviceNumber.centerXTop = XY(SCREEN_WIDTH/2.0,W(68));
    
    
    //设置总高度
    self.height = self.serviceNumber.bottom + W(45);
}

@end
