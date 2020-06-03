//
//  UINavigationController+EndEditing.m
//中车运
//
//  Created by 隋林栋 on 2017/2/20.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UINavigationController+EndEditing.h"


@implementation UINavigationController (EndEditing)

#pragma mark run time
+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self,@selector(pushViewController: animated:)), class_getInstanceMethod(self,@selector(sldPushViewController: animated:)));
    method_exchangeImplementations(class_getInstanceMethod(self,@selector(popViewControllerAnimated:)), class_getInstanceMethod(self,@selector(sldPopViewControllerAnimated:)));
    method_exchangeImplementations(class_getInstanceMethod(self,@selector(popToRootViewControllerAnimated:)), class_getInstanceMethod(self,@selector(sldPopToRootViewControllerAnimated:)));
}


- (void)sldPushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.view endEditing:true];
    [self sldPushViewController:viewController animated:animated];
}
- (void)sldPopViewControllerAnimated:(BOOL)animated{
    [self.view endEditing:true];
    //    UIViewController * lastVC = self.viewControllers.lastObject;
    if (self.viewControllers.lastObject && [self.viewControllers.lastObject isKindOfClass:UIViewController.class]) {
        UIViewController * lastVC = self.viewControllers.lastObject;
        if (lastVC.blockBack) {
            lastVC.blockBack(lastVC);
        }
    }
    [self sldPopViewControllerAnimated:animated];
}
- (void)sldPopToRootViewControllerAnimated:(BOOL)animated{
    [self.view endEditing:true];
    [self sldPopToRootViewControllerAnimated:animated];
}

#pragma mark property
- (UIViewController *)lastVC{
    return self.viewControllers.lastObject;
}
- (UIViewController *)lastSecondVC{
    NSArray * ary = GB_Nav.viewControllers;
    if (ary.count >= 2) {
        return ary[ary.count - 2];
    }
    return self.viewControllers.lastObject;
}

//跳转回root 然后跳转多个vc
- (void)popToRootAry:(NSArray *)aryVCs animate:(BOOL)animated
{
    
    if (aryVCs && ![aryVCs isKindOfClass:NSArray.class]) {
        return;
    }
    NSMutableArray * ary = [NSMutableArray arrayWithObject:GB_Nav.viewControllers.firstObject];
    if (aryVCs) {
        [ary addObjectsFromArray:aryVCs];
    }
    [self setViewControllers:ary animated:animated];
}
#pragma mark logic
//跳转多个vc
- (void)jumpToAry:(NSArray *)aryVCs{
    [self jumpToAry:aryVCs animate:true];
}
//跳转多个vc
- (void)jumpToAry:(NSArray *)aryVCs animate:(BOOL)animated{
    if (!isAry(aryVCs)) {
        return;
    }
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    [ary addObjectsFromArray:aryVCs];
    [self setViewControllers:ary animated:animated];
}

//返回最后一个然后push vc
- (void)popLastAndPushVC:(UIViewController *)vc{
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    [ary removeLastObject];
    [ary addObject:vc];
    [self setViewControllers:ary animated:true];
}
//返回最后一个然后pop vc
- (void)popLastAndPopVC:(UIViewController *)vc{
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    if (vc) {
        [ary insertObject:vc atIndex:MAX(0,  ary.count-1)];
    }
    self.viewControllers = ary;
    [ary removeLastObject];
    [self setViewControllers:ary animated:true];
}
//往回调很多vc
- (void)popMultiVC:(NSInteger)num{
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    if (ary.count > 0) {
        UIViewController * vc = [ary objectAtIndex:MAX(0, ary.count - 1 - num)];
        [self popToViewController:vc animated:true];
    }
    
}
//跳转到之前的 vc类型
- (void)popToClass:(NSString *)className{
    if ([self.lastVC isKindOfClass:NSClassFromString(className)]) {
        return;
    }
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    for (UIViewController * vc in ary) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            if (self.lastVC.blockBack) {
                self.lastVC.blockBack(self.lastVC);
            }
            [self popToViewController:vc animated:true];
            return;
        }
    }
    [self pushVCName:className animated:true];
}
//是否拥有class
- (BOOL)hasClass:(NSString *)className{
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    for (UIViewController * vc in ary) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            return true;
        }
    }
    return false;
}

//根据名称跳转
- (void)pushVCName:(NSString *)strClassName animated:(BOOL)animated{
    id vc = [[NSClassFromString(strClassName) alloc]init];
    [self pushViewController:vc animated:animated];
}


//- (UIViewController *)childViewControllerForStatusBarStyle{
//    return self.topViewController;
//}
//- (UIViewController *)childViewControllerForStatusBarHidden{
//    return self.topViewController;
//}
@end
