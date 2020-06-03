//
//  GuideView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideView : UIView
@property (nonatomic, strong) UIScrollView *scView;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end
