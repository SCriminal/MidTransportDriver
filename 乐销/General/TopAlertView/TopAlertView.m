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
#import "MyMsgManagementVC.h"
#import "MyMsgVC.h"
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
    [TopAlertView jumpToModel:self.model];
    [self timerStop];
    
}

+ (void)jumpToModel:(ModelApns *)model{
    if ([GlobalMethod isLoginSuccess]) {
        if (model.type >= 30 && model.type<=32) {
            if ([GB_Nav hasClass:@"AuthListVC"]) {
                [GB_Nav popToClass:@"AuthListVC"];
            }else{
                [GB_Nav pushViewController:[NSClassFromString(@"AuthListVC") new] animated:true];
            }
            return;
        }
        if ([GB_Nav hasClass:@"MyMsgVC"]) {
            [GB_Nav popToClass:@"MyMsgVC"];
        }else{
            [GB_Nav pushViewController:[MyMsgVC new] animated:true];
        }
        //        NSString * channel = @"1";
        //        if (model.type >= 11 && model.type<=18) {
        //            channel = @"3";
        //        }else if(model.type >= 19 && model.type <=22){
        //            channel = @"2";
        //        }else if(model.type >= 23 && model.type <=27){
        //            channel = @"4";
        //        }else if(model.type ==28){
        //            channel = @"1";
        //        }
        //        MyMsgManagementVC * vc = [MyMsgManagementVC new];
        //        vc.channel = channel;
        //        if ([GB_Nav hasClass:@"MyMsgManagementVC"]) {
        //            [GB_Nav popLastAndPushVC:vc];
        //        }else{
        //            [GB_Nav pushViewController:vc animated:true];
        //        }
    }
}

@end
