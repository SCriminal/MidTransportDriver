//
//  NSObject+Catrgory.h
//中车运
//
//  Created by 隋林栋 on 2017/2/17.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Catrgory)
/**
 *  交换两个函数实现指针  参数均为NSString类型
 *
 *  @param systemMethodString 系统方法名string
 *  @param systemClassString  系统实现方法类名string
 *  @param safeMethodString   自定义hook方法名string
 *  @param targetClassString  目标实现类名string
 */
+ (void)SwizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString;


/**
 交换实例方法

 @param originalSelector 原始方法
 @param replaceSelector 替换方法
 @return 是否替换
 */
+ (BOOL)swizzingInstanceMethod:(SEL)originalSelector  replaceMethod:(SEL)replaceSelector;
@end
