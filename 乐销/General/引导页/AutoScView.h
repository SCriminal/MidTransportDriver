//
//  AutoScView.h
//  丰生活
//
//  Created by 隋林栋 on 16/1/25.
//  Copyright © 2016年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AutoScView : UIView

@property (nonatomic, assign) CGFloat pageControlToBottom;//page control to bottom,default 0
@property (nonatomic, strong) UIColor *pageCurrentColor;//page control current color
@property (nonatomic, strong) UIColor *pageDefaultColor;//page control defalult color
@property (nonatomic, assign) BOOL isClickValid;//is can click show big image
@property (nonatomic, assign) BOOL isShowProductImageStyle;//show product image style
@property (nonatomic, strong) NSMutableArray * aryImage;
@property int numNow;
//定时器
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic) int numTime;
@property (strong, nonatomic) void (^blockNum)(double allNum,double num);

- (instancetype)initWithFrame:(CGRect)frame image:(NSArray *)aryImage;
- (void)resetWithImageAry:(NSArray *)aryImage;

//开启定时器
- (void)timerStart;
//关闭定时器
- (void)timerStop;

@end
