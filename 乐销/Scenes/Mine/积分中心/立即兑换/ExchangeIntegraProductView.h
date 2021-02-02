//
//  ExchangeIntegraProductView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/28.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeIntegraProductView : UIView
@property (nonatomic, strong) void (^blockNumChange)(int);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelIntegralProduct *)model;

@end


@interface ExchangeIntegraAddressView : UIView
@property (nonatomic, strong) void (^blockClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface ExchangeIntegraView : UIView
//属性
@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) UILabel *all;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelIntegralProduct *)model;

@end
