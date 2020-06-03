//
//  BaseNavView+Logical.m
//中车运
//
//  Created by 隋林栋 on 2018/10/19.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "BaseNavView+Logical.h"

@implementation BaseNavView (Logical)
//设置蓝色模式
- (void)configBlueStyle{
    self.backgroundColor = COLOR_BLUE;
    for (UIImageView * iv in self.leftView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.image = [UIImage imageNamed:@"back_white"];
        }
    }
    self.labelTitle.textColor = [UIColor whiteColor];
    self.line.hidden = true;
}

//设置红色模式
- (void)configRedStyle{
    for (UIImageView * iv in self.leftView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.image = [UIImage imageNamed:@"back_white"];
        }
    }
    UIImageView * ivRed = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    ivRed.backgroundColor = [UIColor clearColor];
    ivRed.image = [UIImage imageNamed:@"nav_redBG"];
    ivRed.clipsToBounds = true;
    ivRed.contentMode = UIViewContentModeScaleAspectFill;
    [self insertSubview:ivRed atIndex:0];
    self.line.hidden = true;
}

//设置黑色模式
- (void)configBlackBackStyle{
    UILabel * labelBack = [UILabel new];
    labelBack.font = [UIFont systemFontOfSize:BASENAVVIEW_LEFT_TITLE_FONT_NUM+1];
    labelBack.textColor = [UIColor whiteColor];
    [labelBack fitTitle:@"返回" variable:0];
    [self insertSubview:labelBack atIndex:0];
    
    for (UIImageView * iv in self.leftView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.image = [UIImage imageNamed:@"back_white"];
            labelBack.left = iv.right + W(10);
            labelBack.centerY = iv.centerY+self.leftView.top;
        }
    }
    //black style
    [self configBlackStyle];
   
}

//设置黑色模式
- (void)configBlackStyle{
    for (UIImageView * iv in self.leftView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.image = [UIImage imageNamed:@"back_white"];
        }
    }
    
    UIImageView * ivRed = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    ivRed.backgroundColor = [UIColor clearColor];
    ivRed.image = [UIImage imageNamed:@"nav_blackBG"];
    ivRed.clipsToBounds = true;
    ivRed.contentMode = UIViewContentModeScaleAspectFill;
    [self insertSubview:ivRed atIndex:0];
    self.line.hidden = true;
    
    self.labelTitle.textColor = [UIColor whiteColor];
}
@end
