//
//  NoticeView.m
//  米兰港
//
//  Created by 隋林栋 on 15/3/5.
//  Copyright (c) 2015年 Sl. All rights reserved.
//

#import "NoticeView.h"

@implementation NoticeView

#pragma mark 懒加载
- (UILabel *)labelNotice{
    if (!_labelNotice) {
        _labelNotice = [UILabel new];
        [GlobalMethod setLabel:_labelNotice widthLimit:SCREEN_WIDTH - W(40) numLines:0 fontNum:F(13) textColor:[UIColor whiteColor] text:@"" ];
    }
    return _labelNotice;
}

- (UIControl *)control{
    if (!_control) {
        _control = [UIControl new];
        _control.backgroundColor = [UIColor clearColor];
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}

- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:5 width:0];
        [_viewBG addSubview:self.labelNotice];
    }
    return _viewBG;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.viewBG];
//        [self addSubview:self.control];
        self.userInteractionEnabled = false;
    }
    return  self;
}

#pragma mark 显示提示框
- (void)showNotice:(NSString *)strNotice time:(CGFloat)timeShow frame:(CGRect)frame viewShow:(UIView *)viewShow {
    //去掉空格
    NSArray * aryStr = [strNotice componentsValidSeparatedByString:@" "];
    strNotice = [aryStr componentsJoinedByString:@""];
    
    //停止定时器
    [self timerStop];

    self.frame = frame;
    self.control.frame = self.bounds;
    
    
    //设置label
    [self.labelNotice  fitTitle:strNotice  variable:SCREEN_WIDTH - W(40)];
    self.viewBG.height = self.labelNotice.height + W(16);
    self.viewBG.width = self.labelNotice.width + W(20);
    self.viewBG.bottom = self.height-W(60);
    
    self.viewBG.centerX = self.width/2.0;
    self.labelNotice.center = CGPointMake(self.viewBG.width/2.0, self.viewBG.height/2.0);
    
    [viewShow addSubview:self];
    
    //启动定时器
    self.numTime = timeShow;
    [self timerStart];
}



#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
    
}

- (void)timerRun{
    //每秒的动作
    if (_numTime <=0) {
        //刷新按钮 开始
        [self timerStop];
        return;
    }
    _numTime --;
    
    
}

- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
    
    [self removeFromSuperview];
    
   
}

- (void)dealloc{
    
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [self timerStop];
}

@end
