//
//  AuthTwoVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface AuthTwoVC : BaseTableVC
@property (nonatomic, assign) BOOL isFirst;
- (NSString *)fetchRequestJson;
@end
