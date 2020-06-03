//
//  OrderManagementTopView.h
//  Driver
//
//  Created by 隋林栋 on 2019/10/8.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHT_ORDERMANAGEMENTBOTTOMVIEW  (W(49)+iphoneXBottomInterval)

@interface OrderManagementBottomView : UIView
@property (nonatomic, strong) UIView *viewBG;

@property (strong, nonatomic) UILabel *titleLeft;
@property (strong, nonatomic) UIImageView *iconLeft;
@property (strong, nonatomic) UIControl *conLeft;
@property (strong, nonatomic) UILabel *titleRight;
@property (strong, nonatomic) UIImageView *iconRight;
@property (strong, nonatomic) UIControl *conRight;
@property (strong, nonatomic) UILabel *titleMain;
@property (strong, nonatomic) UIImageView *iconMain;
@property (strong, nonatomic) UIControl *conMain;

@property (nonatomic, strong) void (^blockIndexChange)(int);
@property (nonatomic, strong) void (^blockMainClick)(void);



@end
