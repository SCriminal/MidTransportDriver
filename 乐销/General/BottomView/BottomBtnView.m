//
//  BottomBtnView.m
//中车运
//
//  Created by 刘京涛 on 2018/7/13.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "BottomBtnView.h"

@interface BottomBtnView ()

@end

@implementation BottomBtnView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)modelArray{
    
    [self removeSubViewWithTag:TAG_LINE];//移除线
    [self removeAllSubViews];
    self.btnArray = modelArray;
    if (!isAry(modelArray)) {
        self.height = iphoneXBottomInterval;
    }
    CGFloat left = W(10);
    CGFloat intervalHorizon = W(5);

    CGFloat btnWidth = (SCREEN_WIDTH - left*2 - (modelArray.count-1)*intervalHorizon)/modelArray.count;
    CGFloat btnHeight = W(37.5);
    //刷新view
    for (int i = 0; i < modelArray.count; i++) {
        ModelBtn *btnModel = modelArray[i];
        UIButton * btnBlue = [UIButton createBottomBtn:UnPackStr(btnModel.title)];
        btnBlue.tag = i;
        [btnBlue addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnBlue.widthHeight = XY(btnWidth, btnHeight);
        btnBlue.leftTop = XY(left, W(10));
        left = btnBlue.right +intervalHorizon;
        [self addSubview:btnBlue];
        //设置总高度
        self.height = btnBlue.bottom + W(10) + iphoneXBottomInterval;
    }
    [self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}

//点击事件
- (void)btnClick:(UIButton *)btn{
    if (self.btnArray.count > btn.tag) {
        ModelBtn *btnModel = self.btnArray[btn.tag];
        if (btnModel.blockClick) {
            btnModel.blockClick();
        }
    }
}

@end
