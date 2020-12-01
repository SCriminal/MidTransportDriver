//
//  AutoScView.h
//  丰生活
//
//  Created by 隋林栋 on 16/1/25.
//  Copyright © 2016年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AutoNewsView : UIView

@property (nonatomic, assign) BOOL isClickValid;//is can click show big image
@property (nonatomic, strong) NSMutableArray * aryDatas;
@property int numNow;
//定时器
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic) int numTime;
//点击
@property (nonatomic, strong) void (^blockClick)(int index);

- (void)resetWithAry:(NSArray *)aryImage;

//开启定时器
- (void)timerStart;
//关闭定时器
- (void)timerStop;

@end
