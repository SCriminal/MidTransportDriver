//
//  AutoConfigTimeView.h
//  Driver
//
//  Created by 隋林栋 on 2020/11/30.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoConfigTimeView : UIView
@property (nonatomic, strong) UIImageView *ivBG;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) void (^blockClick)(void);
@property (nonatomic, strong) NSDate *date;

#pragma mark 刷新view
- (void)resetView;
- (void)resetTime;

@end
