//
//  BaseNavView.h
//中车运
//
//  Created by 隋林栋 on 2016/12/17.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BASENAVVIEW_LEFT_TITLE_FONT_NUM F(15)

@interface BaseNavView : UIView

@property (nonatomic, strong) UILabel * labelTitle;
@property (nonatomic, strong) UIControl * backBtn;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) void (^leftBlock)();
@property (nonatomic, strong) void (^rightBlock)();
@property (nonatomic, strong) void (^blockBack)();
@property (nonatomic, assign) BOOL isNotShowEditAlert;
@property (nonatomic, strong) UIView *line;

//刷新页面
+ (instancetype)initNavTitle:(NSString *)title
             leftView:(UIView *)leftView
            rightView:(UIView *)rigthView;
- (void)resetNavTitle:(NSString *)title
             leftView:(UIView *)leftView
            rightView:(UIView *)rightView;

//左返回 右view
+ (instancetype)initNavBackTitle:(NSString *)title
                rightView:(UIView *)rigthView;


//左图片 右图片
+ (instancetype)initNavTitle:(NSString *)title
        leftImageName:(NSString *)leftImageName
               leftImageSize:(CGSize)leftImageSize
            leftBlock:(void (^)())leftBlock
       rightImageName:(NSString *)rightImageName
              rightImageSize:(CGSize)rightImageSize
            righBlock:(void (^)())rightBlock;

//返回 右图片
+ (instancetype)initNavBackWithTitle:(NSString *)title
               rightImageName:(NSString *)rightImageName
                      rightImageSize:(CGSize)rightImageSize
                    righBlock:(void (^)())rightBlock;
//返回 右文字
+ (instancetype)initNavBackTitle:(NSString *)title
                       rightTitle:(NSString *)rightTitle
                       rightBlock:(void (^)())rightBlock;

/**
 左图片 右文字
 
 @param title 标题
 @param leftImageName 返回按钮图片名称
 @param leftBlock 返回按钮block方法
 @param rightTitle 右侧文字
 @param rightBlock 右侧文字block方法
 @return 返回自定义导航视图
 */
+ (instancetype)initNavTitle:(NSString *)title
               leftImageName:(NSString *)leftImageName
               leftImageSize:(CGSize)leftImageSize
                   leftBlock:(void (^)())leftBlock
                  rightTitle:(NSString *)rightTitle
                   righBlock:(void (^)())rightBlock;

//更改title
- (void)changeTitle:(NSString *)title;
//更改nav right title
- (void)changeRightTitle:(NSString *)title;





//设置图片
+ (void)resetControl:(UIView*) control
           imageName:(NSString *) imageName
            imageSize:(CGSize)size
              isLeft:(BOOL)isLeft;
+ (void)resetControl:(UIView*) control
               title:(NSString *) title
              isLeft:(BOOL)isLeft;

//返回 右文字
- (void)resetNavBackTitle:(NSString *)title
              rightTitle:(NSString *)rightTitle
              rightBlock:(void (^)())rightBlock;

//重置左右view
- (void)resetNavRightView:(UIView *)rightView;
- (void)resetNavLeftView:(UIView *)leftView;


#pragma mark 点击事件
- (void)btnBackClick;
@end
