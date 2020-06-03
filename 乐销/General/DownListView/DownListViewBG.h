//
//  DownListViewBG.h
//中车运
//
//  Created by 隋林栋 on 2016/12/23.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownListView;
@interface DownListViewBG : UIControl
@property (strong, nonatomic) DownListView *viewDown;
@property BOOL isAnimate;
#pragma mark 创建
+ (instancetype)initWithFrame:(CGRect)rect
             downListTopRight:(STRUCT_XY)aryRect
                  downListAry:(NSArray *)ary
                       target:(id)target;
+ (instancetype)initWithFrame:(CGRect)rect
           downListCenterXTop:(STRUCT_XY)aryRect
                  downListAry:(NSArray *)aryModel
                       target:(id)target;
- (void)resetWithFrame:(CGRect)rect
    downListCenterXTop:(STRUCT_XY)aryRect
           downListAry:(NSArray *)aryModel
                target:(id)target;
- (void)resetWithFrame:(CGRect)rect
      downListTopRight:(STRUCT_XY)aryRect
           downListAry:(NSArray *)ary
                target:(id)target;

#pragma mark 显示隐藏 动画
- (void)showAnimation;
- (void)hideAnimation;
@end
