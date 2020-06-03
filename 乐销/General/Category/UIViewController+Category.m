//
//  UIViewController+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/10/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIViewController+Category.h"
static const char key_blockBack_UIViewController  = '\0';
static const char key_blockWillBack_UIViewController  = '\0';
static const char key_requestState_UIViewController  = '\0';
static const char key_isNotCanSlideLeft_UIViewController  = '\0';

@implementation UIViewController (Category)

#pragma mark property
- (void)setRequestState:(int)requestState{
    objc_setAssociatedObject(self, &key_requestState_UIViewController, [NSNumber numberWithInteger:requestState], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (int)requestState{
    NSNumber * num = objc_getAssociatedObject(self, &key_requestState_UIViewController);
    if (num && [num isKindOfClass:NSNumber.class]) {
        return [num intValue];
    }
    return 0;
}
-(void)setIsNotCanSlideLeft:(BOOL)isNotCanSlideLeft{
     objc_setAssociatedObject(self, &key_isNotCanSlideLeft_UIViewController, [NSNumber numberWithInteger:isNotCanSlideLeft], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isNotCanSlideLeft{
    NSNumber * num = objc_getAssociatedObject(self, &key_isNotCanSlideLeft_UIViewController);
    if (num && [num isKindOfClass:NSNumber.class]) {
        return [num boolValue];
    }
    return false;
}

-(void)setBlockBack:(void (^)(UIViewController *))blockBack{
    objc_setAssociatedObject(self, &key_blockBack_UIViewController, blockBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(UIViewController *))blockBack{
    return objc_getAssociatedObject(self, &key_blockBack_UIViewController);
}
- (void)setBlockWillBack:(void (^)(UIViewController *))blockWillBack{
    objc_setAssociatedObject(self, &key_blockWillBack_UIViewController, blockWillBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(UIViewController *))blockWillBack{
    return objc_getAssociatedObject(self, &key_blockWillBack_UIViewController);
}


#pragma mark method
/**
 remove all child vc
 */
- (void)removeAllChildVC{
    while (self.childViewControllers.count) {
        UIViewController * childVC = self.childViewControllers.lastObject;
        [childVC.view removeFromSuperview];
        [childVC removeFromParentViewController];
    }
}
@end
