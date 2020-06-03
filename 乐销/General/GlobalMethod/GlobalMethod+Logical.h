//
//  GlobalMethod+Logical.h
//中车运
//
//  Created by 隋林栋 on 2018/11/7.
//  Copyright © 2018 ping. All rights reserved.
//

#import "GlobalMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalMethod (Logical)

//judge login state
+ (void)judgeLoginState:(void(^)(void))blockLoginComplete;
+ (BOOL)isLoginSuccess;
@end

NS_ASSUME_NONNULL_END
