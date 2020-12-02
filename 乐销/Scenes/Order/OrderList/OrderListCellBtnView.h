//
//  OrderListCellBtnView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/2.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ENUM_ORDER_LIST_BTN) {
    ENUM_ORDER_LIST_BTN_RECEIVE,
    ENUM_ORDER_LIST_BTN_DISMISS,
    ENUM_ORDER_LIST_BTN_REJECT,
    ENUM_ORDER_LIST_BTN_NAVIGATION,
    ENUM_ORDER_LIST_BTN_ARRIVE,
    ENUM_ORDER_LIST_BTN_LOAD_CAR,
};


@interface OrderListCellBtnView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model;

@end
