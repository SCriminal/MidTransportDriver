//
//  UINavigationController+EndEditing.h
//中车运
//
//  Created by 隋林栋 on 2017/2/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationController (EndEditing)

#pragma mark property
@property (nonatomic,readonly) UIViewController * lastVC;
@property (nonatomic,readonly) UIViewController * lastSecondVC;

#pragma mark login method
//跳转多个vc
- (void)jumpToAry:(NSArray *)aryVCs;
//跳转多个vc
- (void)jumpToAry:(NSArray *)aryVCs animate:(BOOL)animated;
//返回最后一个然后push vc
- (void)popLastAndPushVC:(UIViewController *)vc;
//返回最后一个然后pop vc
- (void)popLastAndPopVC:(UIViewController *)vc;
//往回调很多vc
- (void)popMultiVC:(NSInteger)num;

//是否拥有class
- (BOOL)hasClass:(NSString *)className;
//根据名称跳转
- (void)pushVCName:(NSString *)strClassName animated:(BOOL)animated;
//跳转回root 然后跳转多个vc
- (void)popToRootAry:(NSArray *)aryVCs animate:(BOOL)animated;
//跳转到之前的 vc类型
- (void)popToClass:(NSString *)className;

//- (UIViewController *)childViewControllerForStatusBarStyle;
//- (UIViewController *)childViewControllerForStatusBarHidden;
@end
