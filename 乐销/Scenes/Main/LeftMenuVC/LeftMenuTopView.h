//
//  LeftMenuTopView.h
//  Driver
//
//  Created by 隋林栋 on 2018/12/12.
//Copyright © 2018 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuTopView : UIView

//属性
@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *identity;
@property (strong, nonatomic) UIImageView *imgIdentity;

@property (nonatomic, strong) void (^blockClick)();

@end
