//
//  UIView+Size.h
//中车运
//
//  Created by 隋林栋 on 2017/1/13.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Size)
//添加属性
@property (nonatomic, assign) CGFloat topToUpView;//default 0,if view height is 0,topToUpView will not calculate
@property (nonatomic, strong) UIColor *topToUpViewBGColor;
@property (nonatomic, assign) CGFloat bottomToDownView;

//组合
@property (nonatomic,assign) STRUCT_XY leftCenterY;
@property (nonatomic,assign) STRUCT_XY leftTop;
@property (nonatomic,assign) STRUCT_XY leftBottom;
@property (nonatomic,assign) STRUCT_XY centerXTop;
@property (nonatomic,assign) STRUCT_XY centerXCenterY;
@property (nonatomic,assign) STRUCT_XY centerXBottom;
@property (nonatomic,assign) STRUCT_XY rightTop;
@property (nonatomic,assign) STRUCT_XY rightCenterY;
@property (nonatomic,assign) STRUCT_XY rightBottom;
//宽高
@property (nonatomic,assign) STRUCT_XY widthHeight;

#pragma mark 获取高度
+ (CGFloat)fetchHeight:(id)model;
+ (CGFloat)fetchHeight:(id)model selectorName:(NSString *)strSelectorName;
+ (CGFloat)fetchHeight:(id)model par:(id)par className:(NSString *)strClassName selectorName:(NSString *)strSelectorName;
+ (CGFloat)fetchHeight:(id)model className:(NSString *)strClassName selectorName:(NSString *)strSelectorName;
#pragma mark 判断是否显示在屏幕上
- (BOOL)isShowInScreen;
//将views 组合
+ (instancetype)initWithViews:(NSArray *)ary;
// reset views 组合
- (void)resetWithViews:(NSArray *)ary;
//灰色背景
+ (instancetype)initGrayBgWithViews:(NSArray *)ary;
@end
