//
//  RequestInstance.h
//中车运
//
//  Created by 隋林栋 on 2016/12/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestInstance : AFHTTPSessionManager
DECLARE_SINGLETON(RequestInstance)
//config request header 
- (void)configHeader;
@end
