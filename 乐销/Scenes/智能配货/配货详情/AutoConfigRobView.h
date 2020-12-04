//
//  AutoConfigRobView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/4.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoConfigRobView : UIView
@property (nonatomic, strong) void (^blockConfirm)(double weight,double price);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface AutoConfigOfferPriceView : UIView
@property (nonatomic, strong) void (^blockConfirm)(double weight,double price);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
