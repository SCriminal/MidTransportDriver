//
//  NoticeView.h
//  米兰港
//
//  Created by 隋林栋 on 15/3/5.
//  Copyright (c) 2015年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeView : UIView
@property (strong, nonatomic) UIControl *control;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UILabel *labelNotice;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic) int numTime;

- (void)showNotice:(NSString *)strNotice time:(CGFloat)timeShow frame:(CGRect)frame viewShow:(UIView *)viewShow;

@end
