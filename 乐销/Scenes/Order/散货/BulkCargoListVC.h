//
//  BulkCargoListVC.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"
//order list vc
#import "OrderListVC.h"

@interface BulkCargoListVC : BaseTableVC
@property (nonatomic, assign) ENUM_ORDER_LIST_SORT sortType;
@property (nonatomic, strong) void (^blockTotal)(ENUM_ORDER_LIST_SORT,int);

@end
