//
//  UIViewController+Category.h
//中车运
//
//  Created by 隋林栋 on 2017/10/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)
@property (nonatomic, strong) void (^blockBack)(UIViewController *);//返回之后调用
@property (nonatomic, strong) void (^blockWillBack)(UIViewController *);//返回之前调用
@property (nonatomic, assign) int requestState;//请求结果，默认0，其余标示成功
@property (nonatomic, assign) BOOL isNotCanSlideLeft;
/**
 remove all child vc
 */
- (void)removeAllChildVC;
@end
