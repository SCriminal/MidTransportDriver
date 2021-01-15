//
//  GlobalMethod+Logical.m
//中车运
//
//  Created by 隋林栋 on 2018/11/7.
//  Copyright © 2018 ping. All rights reserved.
//

#import "GlobalMethod+Logical.h"

@implementation GlobalMethod (Logical)

//judge login state
+ (void)judgeLoginState:(void(^)(void))blockLoginComplete{
    if([self isLoginSuccess]){
        if(blockLoginComplete){
            blockLoginComplete();
        }
    }else{
        [GB_Nav pushVCName:@"LoginViewController" animated:true];
    }
}

+ (BOOL)isLoginSuccess{
    return isStr( [GlobalData sharedInstance].GB_UserModel.cellPhone);
}
@end
