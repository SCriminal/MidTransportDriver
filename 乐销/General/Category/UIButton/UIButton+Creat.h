//
//  UIButton+Creat.h
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/6/21.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>
//model
#import "ModelBtn.h"

@interface UIButton (Creat)

@property (nonatomic, assign, readonly) CGFloat fitWidth;//根据文字获取宽度
@property (nonatomic, assign, readonly) CGFloat fitHeight;//根据文字获取高度
@property (nonatomic, strong) ModelBtn *modelBtn;//model


#pragma mark logic relate
+ (UIButton *)createBottomBtn:(NSString *)title;

@end
