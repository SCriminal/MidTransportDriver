//
//  WelcomeVC.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/15.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseVC.h"

@interface WelcomeVC : BaseVC


@end


@interface WelcomeBottomView : UIView
//属性
@property (strong, nonatomic) UIImageView *ivSurround;
@property (strong, nonatomic) UIImageView *ivGift;
@property (strong, nonatomic) UIImageView *ivOrder;
@property (nonatomic, strong) void (^blockClick)();

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
