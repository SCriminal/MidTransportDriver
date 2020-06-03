//
//  NSObject+Catrgory.m
//中车运
//
//  Created by 隋林栋 on 2017/2/17.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSObject+Catrgory.h"
#import <objc/runtime.h>

@implementation NSObject (Catrgory)
+ (void)SwizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString{
    //获取系统方法IMP
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    //自定义方法的IMP
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(safeMethodString));
    //IMP相互交换，方法的实现也就互相交换了
    method_exchangeImplementations(safeMethod,sysMethod);
}

+ (BOOL)swizzingInstanceMethod:(SEL)originalSelector  replaceMethod:(SEL)replaceSelector
{
    Method original = class_getInstanceMethod(self, originalSelector);
    Method replace = class_getInstanceMethod(self, replaceSelector);
    if (!original || !replace) {
        return NO;
    }
    class_addMethod(self, originalSelector, class_getMethodImplementation(self, originalSelector), method_getTypeEncoding(original));
    class_addMethod(self, replaceSelector, class_getMethodImplementation(self, replaceSelector), method_getTypeEncoding(replace));
    
    method_exchangeImplementations(original, replace);
    return YES;
}
@end
