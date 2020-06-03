//
//  TopAlertView.h
//  乐销
//
//  Created by mengxi on 17/3/4.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopAlertView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIControl *control;
@property (nonatomic, strong) ModelApns *model;

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic) int numTime;

#pragma mark 刷新view
- (void)showWithModel:(ModelApns *)model;

//单例
DECLARE_SINGLETON(TopAlertView)
@end
