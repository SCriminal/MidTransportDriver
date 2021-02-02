//
//  IntegralCenterView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/22.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralCenterTopView : UIView
@property (nonatomic, strong) void (^blockSign)(void);
@property (nonatomic, assign) double  point;
#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)ary;

@end
