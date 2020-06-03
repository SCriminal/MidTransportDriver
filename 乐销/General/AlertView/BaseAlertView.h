//
//  BaseAlertView.h
//中车运
//
//  Created by 隋林栋 on 2017/1/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAlertView : UIView
@property (nonatomic, strong) UIView *viewBg;
@property (nonatomic, strong) UIView *viewWhite;
@property (nonatomic, strong) UILabel *labelAlert;
@property (nonatomic, strong) UILabel *labeTitle;


#pragma mark 创建
+ (instancetype)initWithTitle:(NSString *)title content:(NSString *)content aryBtnModels:(NSArray *)ary viewShow:(UIView *)viewShow;
- (void)resetWithTitle:(NSString *)title content:(NSString *)content aryBtnModels:(NSArray *)ary viewShow:(UIView *)viewShow;
#pragma mark 创建
+ (void)customAlertControllerWithTitle:(NSString *)title  modelBtnArr:(NSArray *)models cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor   selectIndex:(void(^)(int selectIndex))selectIndex;
@end

@interface ConBaseAlertView : UIControl
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) void (^block)(void);
+ (instancetype)initWithTitle:(NSString *)title labelColor:(UIColor *)labelColor tag:(NSInteger)tag frame:(CGRect)frame hasLineVertical:(BOOL)hasLineVertical;
- (void)resetWithTitle:(NSString *)title labelColor:(UIColor *)labelColor tag:(NSInteger)tag frame:(CGRect)framel hasLineVertical:(BOOL)hasLineVertical;
@end
