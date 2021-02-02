//
//  SelectOrderVC.h
//  Driver
//
//  Created by 隋林栋 on 2021/2/2.
//  Copyright © 2021 ping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectOrderVC : BaseTableVC
@property (nonatomic, strong) void (^blockSelected)(ModelTransportOrder *);

@end

NS_ASSUME_NONNULL_END
