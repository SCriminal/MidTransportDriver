//
//  BaseAlertView.m
//中车运
//
//  Created by 隋林栋 on 2017/1/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseAlertView.h"

@implementation BaseAlertView

#pragma mark 懒加载
- (UIView *)viewBg{
    if (_viewBg == nil) {
        _viewBg = [UIView new];
        _viewBg.backgroundColor = COLOR_BLACK_ALPHA_PER60;
    }
    return _viewBg;
}
- (UIView *)viewWhite{
    if (_viewWhite == nil) {
        _viewWhite = [UIView new];
        _viewWhite.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_viewWhite color:[UIColor clearColor] numRound:5 width:0];
    }
    return _viewWhite;
}
- (UILabel *)labelAlert{
    if (_labelAlert == nil) {
        _labelAlert = [UILabel new];
        [GlobalMethod setLabel:_labelAlert widthLimit:0 numLines:0 fontNum:F(19) textColor:COLOR_TITLE text:@""];
        _labelAlert.textAlignment = NSTextAlignmentCenter;
    }
    return _labelAlert;
}
- (UILabel *)labeTitle{
    if (_labeTitle == nil) {
        _labeTitle = [UILabel new];
        [GlobalMethod setLabel:_labeTitle widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_TITLE text:@""];
        _labeTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labeTitle;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.viewBg];
        [self addSubview:self.viewWhite];
        [self.viewWhite addSubview:self.labelAlert];
        [self.viewWhite addSubview:self.labeTitle];
    }
    return self;
}

#pragma mark 创建
+ (instancetype)initWithTitle:(NSString *)title content:(NSString *)content aryBtnModels:(NSArray *)ary viewShow:(UIView *)viewShow{
    BaseAlertView * view = [BaseAlertView new];
    [view resetWithTitle:title content:content aryBtnModels:ary viewShow:viewShow];
    return view;
}
#pragma mark 刷新view
- (void)resetWithTitle:(NSString *)title content:(NSString *)content aryBtnModels:(NSArray *)ary viewShow:(UIView *)viewShow{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.viewBg.frame = CGRectMake(W(0), W(0), SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.viewWhite.frame = CGRectMake(W(33), W(0),SCREEN_WIDTH - W(66), W(171));
    self.viewWhite.center = CGPointMake(self.viewBg.width/2.0, self.viewBg.height/2.0);
    
    [self.labelAlert  fitTitle:title  variable:0];
    self.labelAlert.centerXTop = XY(self.viewWhite.width/2.0,W(18));
    if (!isStr(content)) {
        self.labelAlert.centerY = (self.viewWhite.height  - W(55))/2;
    }
    
    [self.labeTitle  fitTitle:content  variable:self.viewWhite.width - W(30)];
    self.labeTitle.center = CGPointMake(self.viewWhite.width/2.0, (self.viewWhite.height - self.labelAlert.bottom - W(55))/2.0 + self.labelAlert.bottom);
    
    [self.viewWhite addLineFrame:CGRectMake(0, self.viewWhite.height - W(55)-1, self.viewWhite.width, 1)];
    CGFloat widthItem = self.viewWhite.width/ary.count;
    for (int i = 0 ; i< ary.count; i++) {
        ModelBtn * model = ary[i];
        ConBaseAlertView * con = [ConBaseAlertView initWithTitle:model.title labelColor:model.color tag:model.tag frame:CGRectMake(i*widthItem, self.viewWhite.height - W(55), widthItem, W(55)) hasLineVertical:i != ary.count-1];
        con.block = model.blockClick;
        [con addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewWhite addSubview:con];
    }
    [viewShow addSubview:self];
}
#pragma mark 创建
+ (void)customAlertControllerWithTitle:(NSString *)title  modelBtnArr:(NSArray *)models cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor   selectIndex:(void(^)(int selectIndex))selectIndex{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:isStr(title)?title:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for ( ModelBtn * model in models) {
            [self addActionTarget:alert title:UnPackStr(model.title) color:model.color?model.color: [UIColor blackColor] action:^(UIAlertAction *action) {
                if (selectIndex) {
                    selectIndex(model.tag);
                }
            }];
        }
        if (isStr(cancelTitle)) {
            [self addCancelActionTarget:alert title:cancelTitle titleColor:cancelColor?cancelColor: [UIColor blackColor]];
        }
//    NSLog(@"%@",GB_Nav.lastVC);
//    NSLog(@"%@",GB_Nav.lastVC.presentedViewController);
//    UIViewController * hostVC = GB_Nav.lastVC;
//    UIViewController * next = hostVC.presentedViewController;
//    while (next) {
//        hostVC = next;
//        next = hostVC.presentedViewController;
//    }
    [GB_Nav.lastVC presentViewController:alert animated:YES completion:nil];
    
}





+(void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(UIColor *)color action:(void(^)(UIAlertAction *action))actionTarget
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        actionTarget(action);
    }];
    [action setValue:color forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

// 取消按钮
+(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title  titleColor:(UIColor*)titleColor
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:titleColor forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

#pragma mark 点击事件
- (void)btnClick:(ConBaseAlertView *)sender{
    if (sender.block) {
        sender.block();
    }
    [self removeFromSuperview];
}

@end

@implementation ConBaseAlertView

#pragma mark 懒加载
- (UILabel *)label{
    if (_label == nil) {
        _label = [UILabel new];
        [GlobalMethod setLabel:_label widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_TITLE text:@""];
    }
    return _label;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.label];
    }
    return self;
}

#pragma mark 创建
+ (instancetype)initWithTitle:(NSString *)title labelColor:(UIColor *)labelColor tag:(NSInteger)tag frame:(CGRect)frame hasLineVertical:(BOOL)hasLineVertical{
    ConBaseAlertView * view = [ConBaseAlertView new];
    [view resetWithTitle:title labelColor:labelColor tag:tag frame:frame hasLineVertical:hasLineVertical];
    return view;
}
#pragma mark 刷新view
- (void)resetWithTitle:(NSString *)title labelColor:(UIColor *)labelColor tag:(NSInteger)tag frame:(CGRect)frame hasLineVertical:(BOOL)hasLineVertical{
    self.frame = frame;
    self.tag = tag;
    [self.label  fitTitle:title  variable:0];
    self.label.textColor = labelColor;
    self.label.centerXCenterY = XY(self.width/2.0,self.height/2.0);
    
    if (hasLineVertical) {
        [self addLineFrame:CGRectMake(self.width - 1, 0, 1, self.height)];
    }
}


@end
