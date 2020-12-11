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
- (void)configBackBlueStyle{
 
    [BaseNavView resetControl:self.backBtn imageName:@"back_white" imageSize:CGSizeMake(W(25), W(25)) isLeft:true];

    [self configBlueStyle];
}
//设置蓝色模式
- (void)configBlueStyle{
    self.backgroundColor = COLOR_BLUE;
   
    self.labelTitle.textColor = [UIColor whiteColor];
    for (UILabel * l in self.rightView.subviews) {
        if ([l isKindOfClass:[UILabel class]]) {
            l.textColor = [UIColor whiteColor];
        }
    }
    self.line.hidden = true;
}

@end
