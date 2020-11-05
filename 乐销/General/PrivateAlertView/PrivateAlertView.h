//
//  PrivateAlertView.h
//  Driver
//
//  Created by 隋林栋 on 2020/11/3.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivateAlertView : UIView

@property (nonatomic, strong) UIView *viewBg;
@property (nonatomic, strong) UIView *viewWhite;
@property (nonatomic, strong) UILabel *labelAlert;
@property (nonatomic, strong) UILabel *labeTitle;

- (void)show;
@end
