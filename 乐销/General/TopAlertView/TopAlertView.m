//
//  TopAlertView.m
//  乐销
//
//  Created by mengxi on 17/3/4.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "TopAlertView.h"
//order detail view
#import "OrderDetailVC.h"
@implementation TopAlertView

SYNTHESIZE_SINGLETONE_FOR_CLASS(TopAlertView)

#pragma mark 懒加载

- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.fontNum = F(15) ;
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.lineSpace = W(8);
        _labelTitle.numberOfLines = 0;
    }
    return _labelTitle;
}
- (UIControl *)control{
    if (_control == nil) {
        _control = [UIControl new];
        _control.tag = 1;
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor = [UIColor clearColor];
    }
    return _control;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_DARK;
        self.left = W(3);
        self.width = SCREEN_WIDTH- W(6);
        [GlobalMethod setRoundView:self color:[UIColor clearColor] numRound:10 width:0];
        [self addSubView];
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
        [self addGestureRecognizer:swipeGesture];
    }
    return self;
}

//添加subview
- (void)addSubView{
    [self addSubview:self.labelTitle];
    [self addSubview:self.control];
    
}
//轻扫取消alertView
-(void)swipeGestureAction:(UISwipeGestureRecognizer *)sender
{
    [self timerStop];
}

#pragma mark 刷新view
- (void)showWithModel:(ModelApns *)model{
    self.model = model;
    if (self.model.isSilent) {
        return;
    }
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle  fitTitle:UnPackStr(model.desc)  variable:SCREEN_WIDTH - W(30)];
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH / 2,W(15));
    
    self.height = self.labelTitle.bottom + W(15);
    
    self.control.widthHeight = XY(SCREEN_WIDTH, self.height);
    self.control.leftTop = XY(W(0),W(0));
    //播放声音
    AudioServicesPlaySystemSound(1012);
    [self show];
}


#pragma mark 动态显示
- (void)show{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    if (self.isShow) {
        [self timerStart];
    }else{
        self.top = -self.height;
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.frame = CGRectMake(W(3), STATUSBAR_HEIGHT, SCREEN_WIDTH-W(6), self.height);
        } completion:^(BOOL finished) {
            weakSelf.isShow = true;
            [weakSelf timerStart];
        }];
    }
    

}

#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
    self.numTime = 5;
    
}

- (void)timerRun{
    //每秒的动作
    if (_numTime <=0) {
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
    //收回
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(W(3), -weakSelf.height, SCREEN_WIDTH- W(6), weakSelf.height);
    } completion:^(BOOL finished) {
        weakSelf.isShow = false;
        [weakSelf removeFromSuperview];
        
    }];

    
}
#pragma mark click
- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1://数据解析  跳转页面
        {
            if (self.model.type == 1) {
                [GlobalMethod jumpToOrderList];
            }
            [self timerStop];
        }
            break;
            
        default:
            break;
    }
}

@end
