//
//  BaseNavView.m
//中车运
//
//  Created by 隋林栋 on 2016/12/17.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "BaseNavView.h"

//base alert view
#import "BaseAlertView.h"



@implementation BaseNavView

//初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
    }
    return self;
}

//懒加载
- (UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:SCREEN_WIDTH - W(50) * 2 numLines:1 fontNum:F(16) textColor:[UIColor blackColor] text:@""];
    }
    return _labelTitle;
}
- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT-1, SCREEN_WIDTH, 1);
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}

- (UIControl *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIControl new];
        _backBtn.tag = TAG_KEYBOARD;
        [_backBtn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
        [BaseNavView resetControl:_backBtn imageName:@"back_black" imageSize:CGSizeMake(W(25), W(25)) isLeft:true];
    }
    return _backBtn;
}

#pragma mark 类方法
//刷新页面
+ (instancetype)initNavTitle:(NSString *)title
                    leftView:(UIView *)leftView
                   rightView:(UIView *)rigthView{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavTitle:title leftView:leftView rightView:rigthView];
    return baseNav;
}

//左返回 右view
+ (instancetype)initNavBackTitle:(NSString *)title
                       rightView:(UIView *)rigthView{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavBackTitle:title rightView:rigthView];
    return baseNav;
}


//左图片 右图片
+ (instancetype)initNavTitle:(NSString *)title
               leftImageName:(NSString *)leftImageName
              leftImageSize:(CGSize)leftImageSize
                   leftBlock:(void (^)())leftBlock
              rightImageName:(NSString *)rightImageName
              rightImageSize:(CGSize)rightImageSize
                   righBlock:(void (^)())rightBlock{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavTitle:title leftImageName:leftImageName leftImageSize:leftImageSize leftBlock:leftBlock rightImageName:rightImageName rightImageSize:rightImageSize righBlock:rightBlock];
    return baseNav;
}


//左返回 右图片
+ (instancetype)initNavBackWithTitle:(NSString *)title
                      rightImageName:(NSString *)rightImageName
                      rightImageSize:(CGSize)rightImageSize
                           righBlock:(void (^)())rightBlock{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavBackWithTitle:title rightImageName:rightImageName rightImageSize:rightImageSize righBlock:rightBlock];
    return baseNav;
}
//返回 右文字
+ (instancetype)initNavBackTitle:(NSString *)title
                      rightTitle:(NSString *)rightTitle
                      rightBlock:(void (^)())rightBlock{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavBackTitle:title rightTitle:rightTitle rightBlock:rightBlock];
    
    return baseNav;
    
}

/**
 左图片block 右文字block

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
                   righBlock:(void (^)())rightBlock{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavTitle:title leftImageName:leftImageName leftImageSize:leftImageSize leftBlock:leftBlock rightTitle:rightTitle righBlock:rightBlock];
    return baseNav;
}


//返回 右文字
- (void)resetNavBackTitle:(NSString *)title
              rightTitle:(NSString *)rightTitle
              rightBlock:(void (^)())rightBlock{
    self.rightBlock = rightBlock;
    if (!isStr(rightTitle)){
        [self resetNavTitle:title leftView:self.backBtn rightView:nil];
        return;
    }
    UIControl * con = [UIControl new];
    con.tag = TAG_KEYBOARD;
    [BaseNavView resetControl:con title:rightTitle isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavTitle:title leftView:self.backBtn rightView:con];
    
}

//刷新页面 左view  右view
- (void)resetNavTitle:(NSString *)title
             leftView:(UIView *)leftView
            rightView:(UIView *)rightView{
    
    //set title
    [self.labelTitle  fitTitle:title  variable:0];
    self.labelTitle.centerX = self.width/2.0;
    self.labelTitle.centerY = (NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT)/2.0 + STATUSBAR_HEIGHT;
    [self addSubview:self.labelTitle];
    //reset left view
    [self resetNavLeftView:leftView];
    //reset right view
    [self resetNavRightView:rightView];
    //add line
    [self addSubview:self.line];
}
- (void)resetNavRightView:(UIView *)rightView{
    //right view
    if (self.rightView != nil) {
        [self.rightView removeFromSuperview];
        self.rightView = nil;
    }
    self.rightView = rightView;
    rightView.frame = CGRectMake(SCREEN_WIDTH - rightView.width, (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-rightView.height/2.0, rightView.width, rightView.height);
    if (self.line.superview && !self.line.hidden) {
        [self insertSubview:self.rightView belowSubview:self.line];
    }else{
        [self addSubview:self.rightView];
    }
}
- (void)resetNavLeftView:(UIView *)leftView{
    //left view
    if (self.leftView != nil) {
        [self.leftView removeFromSuperview];
        self.leftView = nil;
    }
    self.leftView = leftView;
    leftView.frame = CGRectMake(0, (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-leftView.height/2.0, leftView.width, leftView.height);
    
    if (self.line.superview && !self.line.hidden) {
        [self insertSubview:self.leftView belowSubview:self.line];
    }else{
        [self addSubview:self.leftView];
    }
}
//左返回 右view
- (void)resetNavBackTitle:(NSString *)title
                rightView:(UIView *)rigthView{
    [self resetNavTitle:title leftView:self.backBtn rightView:rigthView];
}

//左图片 右图片
- (void)resetNavTitle:(NSString *)title
        leftImageName:(NSString *)leftImageName
        leftImageSize:(CGSize)leftImageSize
            leftBlock:(void (^)())leftBlock
       rightImageName:(NSString *)rightImageName
       rightImageSize:(CGSize)rightImageSize
            righBlock:(void (^)())rightBlock{
    UIView * leftView = nil;
    if (leftImageName != nil) {
        self.leftBlock = leftBlock;
        UIControl * con = [UIControl new];
        [BaseNavView resetControl:con imageName:leftImageName imageSize:leftImageSize isLeft:true];
        [con addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
        leftView = con;
    }
    UIView * rightView = nil;
    if (rightImageName != nil) {
        self.rightBlock = rightBlock;
        UIControl * con = [UIControl new];
        [BaseNavView resetControl:con imageName:rightImageName imageSize:rightImageSize isLeft:false];
        [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
        rightView = con;
    }
    [self resetNavTitle:title leftView:leftView rightView:rightView];
}
//返回 右图片
- (void)resetNavBackWithTitle:(NSString *)title
               rightImageName:(NSString *)rightImageName
               rightImageSize:(CGSize)rightImageSize
                    righBlock:(void (^)())rightBlock{
    self.rightBlock = rightBlock;
    UIControl * con = [UIControl new];
    [BaseNavView resetControl:con imageName:rightImageName imageSize:rightImageSize isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavTitle:title leftView:self.backBtn rightView:con];
}


//左图片 右文字
- (void)resetNavTitle:(NSString *)title
        leftImageName:(NSString *)leftImageName
        leftImageSize:(CGSize)leftImageSize
            leftBlock:(void (^)())leftBlock
       rightTitle:(NSString *)rightTitle
            righBlock:(void (^)())rightBlock{
    UIView * leftView = self.backBtn;
    if (leftImageName != nil) {
        self.leftBlock = leftBlock;
        UIControl * con = [UIControl new];
        [BaseNavView resetControl:con imageName:leftImageName imageSize:leftImageSize isLeft:true];
        [con addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
        leftView = con;
    }
    self.rightBlock = rightBlock;
    if (!isStr(rightTitle)){
        [self resetNavTitle:title leftView:leftView rightView:nil];
        return;
    }
    UIControl * con = [UIControl new];
    con.tag = TAG_KEYBOARD;
    [BaseNavView resetControl:con title:rightTitle isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavTitle:title leftView:leftView rightView:con];
}




//更改title
- (void)changeTitle:(NSString *)title{
    [self.labelTitle  fitTitle:title  variable:0];
    self.labelTitle.centerX = self.width/2.0;
}
//更改nav right title
- (void)changeRightTitle:(NSString *)rightTitle{
    [self.rightView removeFromSuperview];
    
    UIControl * con = [UIControl new];
    con.tag = TAG_KEYBOARD;
    [BaseNavView resetControl:con title:rightTitle isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavRightView:con];
}

#pragma mark 点击事件
//back btn click
- (void)btnBackClick{
    if (self.blockBack) {
        self.blockBack();
    }else{
//        if (self.isNotShowEditAlert){
//            [self popVC];
//        }else {
//            [self showEditAlert:[self fetchVC]];
//        }
        [self popVC];
    }
}
- (void)showEditAlert:(UIViewController *)vc{
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    if (!vc || ![vc isKindOfClass:UIViewController.class]) return;
    if (vc.view.isEdited) {
        WEAKSELF
        [GlobalMethod showEditAlertDismiss:nil confirm:^{
            [weakSelf popVC];
        } view:vc.view];
    }else{
        [self popVC];
    }
}
- (void)popVC{
    UIViewController * vcRespond = [self fetchVC];
    if (vcRespond && [vcRespond isKindOfClass:UIViewController.class] && vcRespond.blockWillBack) {
        vcRespond.blockWillBack(vcRespond);
    }else{
        [GB_Nav popViewControllerAnimated:true];
    }
}
- (void)btnRightClick{
    if (self.rightBlock != nil) {
        self.rightBlock();
    }
}
- (void)btnLeftClick{
    if (self.leftBlock != nil) {
        self.leftBlock();
    }
}


#pragma mark 通用方法
+ (void)resetControl:(UIView*) control
           imageName:(NSString *) imageName
           imageSize:(CGSize)size
              isLeft:(BOOL)isLeft{
    control.backgroundColor = [UIColor clearColor];
    [control removeAllSubViews];
    UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    iv.widthHeight = XY(size.width, size.height);
    iv.backgroundColor = [UIColor clearColor];
    if (isLeft) {
        control.frame = CGRectMake(0, STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        iv.left = W(10);
    } else {
        control.frame = CGRectMake(SCREEN_WIDTH - W(100), STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        iv.right = control.width - W(15);
    }
    iv.centerY = control.height/2.0;
    [control addSubview: iv];
    
}

+ (void)resetControl:(UIView*) control
               title:(NSString *) title
              isLeft:(BOOL)isLeft{
    control.backgroundColor = [UIColor clearColor];
    [control removeAllSubViews];
    UILabel * label = [UILabel new];
    label.numLimit = 6;
    label.numberOfLines = 1;
    label.textColor = COLOR_333;
    label.font = [UIFont systemFontOfSize:BASENAVVIEW_LEFT_TITLE_FONT_NUM weight:UIFontWeightLight];
    label.backgroundColor = [UIColor clearColor];
    [label fitTitle:title variable:0];
    if (isLeft) {
        control.frame = CGRectMake(0, STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        label.left = W(20);
    } else {
        control.frame = CGRectMake(SCREEN_WIDTH - W(100), STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        label.right = control.width - W(20);
    }
    label.centerY = control.height/2.0;
    [control addSubview: label];
    
}

@end
