//
//  DownListView.m
//中车运
//
//  Created by 隋林栋 on 2016/12/23.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "DownListView.h"

@implementation DownListView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:self color:[UIColor clearColor] numRound:5 width:0];
        self.layer.anchorPoint = CGPointMake(1, 0);
    }
    return self;
}


- (void)resetWithAry:(NSArray *)ary target:(id)target{
    [self removeAllSubViews];
    
    CGFloat width = W(98);
    for ( int i = 0; i<ary.count; i++) {
        ModelBtn * model = ary[i];
        if (isStr(model.imageName)) {
            width = W(138);
        }
        if (model.width) {
            width = model.width;
        }
        DownListViewControl * control = [DownListViewControl initWithModel:model frame:CGRectMake(0, i * W(55), width, W(55)) tag:model.tag];
        if (i == ary.count -1 ) {
            control.viewLine.hidden = true;
        }
        [control addTarget:target action:NSSelectorFromString(@"btnClick:") forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        self.widthHeight = XY(control.width,control.bottom);
    }

}

@end



@implementation DownListViewControl

#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(16) textColor:COLOR_TITLE text:@""];
    }
    return _labelTitle;
}
- (UIImageView *)imageHead{
    if (_imageHead == nil) {
        _imageHead = [UIImageView new];
        _imageHead.backgroundColor = [UIColor clearColor];
        _imageHead.image = nil;
        _imageHead.widthHeight = XY(W(19),W(17));
    }
    return _imageHead;
}
- (UIView *)viewLine{
    if (_viewLine == nil) {
        _viewLine = [UIView new];
        _viewLine.backgroundColor = COLOR_LINE;
    }
    return _viewLine;
}


#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.labelTitle];
        [self addSubview:self.imageHead];
        [self addSubview:self.viewLine];
    }
    return self;
}
#pragma mark 创建
+ (instancetype)initWithModel:(ModelBtn *)model frame:(CGRect)rect tag:(int)tag{
    DownListViewControl * view = [DownListViewControl new];
    [view resetWithModel:model frame:rect tag:tag];
    return view;
}
#pragma mark 刷新view
- (void)resetWithModel:(ModelBtn *)model frame:(CGRect)rect tag:(int)tag{
    self.frame = rect;
    self.tag = tag;
    [self.labelTitle  fitTitle:model.title  variable:0];
    self.labelTitle.centerXCenterY = XY(self.width/2.0,self.height/2.0);

    if (isStr(model.imageName)) {
        self.imageHead.leftCenterY = XY(W(15),self.height/2.0);
        self.imageHead.image = [UIImage imageNamed:model.imageName];
        self.labelTitle.left = self.imageHead.right + W(10);
    }
    self.viewLine.frame = CGRectMake(W(10), self.height - 1, self.width- W(10) * 2, 1);
}

@end

