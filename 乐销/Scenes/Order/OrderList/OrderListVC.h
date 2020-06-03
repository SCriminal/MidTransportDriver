//
//  OrderListVC.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "BaseTableVC.h"

typedef NS_ENUM(NSUInteger, ENUM_ORDER_LIST_SORT) {
    ENUM_ORDER_LIST_SORT_WAIT_RECEIVE,
    ENUM_ORDER_LIST_SORT_GOING,
    ENUM_ORDER_LIST_SORT_ARRIVE,
    ENUM_ORDER_LIST_SORT_COMPLETE,
};

@interface OrderListVC : BaseTableVC
@property (nonatomic, assign) ENUM_ORDER_LIST_SORT sortType;
@property (nonatomic, strong) void (^blockTotal)(ENUM_ORDER_LIST_SORT,int);

@end
