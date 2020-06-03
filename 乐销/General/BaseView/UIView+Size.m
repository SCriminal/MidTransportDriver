//
//  UIView+Size.m
//中车运
//
//  Created by 隋林栋 on 2017/1/13.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIView+Size.h"
//runtime
#import <objc/runtime.h>
static const char topToUpViewKey = '\0';
static const char bottomToDownViewKey = '\0';
static const char topToUpViewBGColorKey = '\0';

@implementation UIView (Size)

@dynamic leftCenterY;
@dynamic leftTop;
@dynamic leftBottom;
@dynamic centerXTop;
@dynamic centerXCenterY;
@dynamic centerXBottom;
@dynamic rightTop;
@dynamic rightCenterY;
@dynamic rightBottom;
@dynamic widthHeight;

#pragma mark 运行时
-(void)setTopToUpView:(CGFloat)topToUpView
{
    objc_setAssociatedObject(self, &topToUpViewKey, [NSNumber numberWithFloat:topToUpView], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGFloat)topToUpView
{
    NSNumber * num = objc_getAssociatedObject(self, &topToUpViewKey);
    if (num == nil || ![num isKindOfClass:[NSNumber class]]) {
        return 0;
    }
    return [num floatValue];
}
- (void)setBottomToDownView:(CGFloat)bottomToDownView{
    objc_setAssociatedObject(self, &bottomToDownViewKey, [NSNumber numberWithFloat:bottomToDownView], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)bottomToDownView{
    NSNumber * num = objc_getAssociatedObject(self, &bottomToDownViewKey);
    if (num == nil || ![num isKindOfClass:[NSNumber class]]) {
        return 0;
    }
    return [num floatValue];
}
- (void)setTopToUpViewBGColor:(UIColor *)topToUpViewBGColor{
    objc_setAssociatedObject(self, &topToUpViewBGColorKey, topToUpViewBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)topToUpViewBGColor{
    UIColor * color = objc_getAssociatedObject(self, &topToUpViewBGColorKey);
    return  color;
}
//将views 组合
+ (instancetype)initWithViews:(NSArray *)ary{
    UIView * viewReturn = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    viewReturn.backgroundColor = [UIColor clearColor];
    if (isAry(ary)) {
        CGFloat top = 0;
        for (UIView * view in ary) {
            if (view && [view isKindOfClass:[UIView class]]) {
                if (view.height) {
                    [viewReturn addSubview:view];
                    if (view.topToUpViewBGColor) {
                        [viewReturn addSubview:[UIView lineWithFrame:CGRectMake(0, top, view.width, view.topToUpView) color:view.topToUpViewBGColor]];
                    }
                    view.top = top + view.topToUpView;
                    top = view.bottom;
                }
            }
        }
        viewReturn.height = top;
    }
    return viewReturn;
}
// reset views 组合
- (void)resetWithViews:(NSArray *)ary{
    [self removeSubViewWithTag:TAG_LINE];
    self.backgroundColor = COLOR_BACKGROUND;
    if (isAry(ary)) {
        CGFloat top = 0;
        for (UIView * view in ary) {
            if (!view.superview) {
                [self addSubview:view];
            }
            if (view && [view isKindOfClass:[UIView class]]) {
                if (view.height) {
                    view.top = top + view.topToUpView;
                    top = view.bottom;
                }
            }
        }
        self.height = top;
    }
}
//灰色背景
+ (instancetype)initGrayBgWithViews:(NSArray *)ary{
    UIView * view = [self initWithViews:ary];
    view.backgroundColor = COLOR_BACKGROUND;
    return view;
}


#pragma mark 组合
- (void)setLeftTop:(STRUCT_XY)leftTop{
    self.left = leftTop.horizonX;
    self.top = leftTop.verticalY;
}
- (STRUCT_XY)leftTop{
    return XY(self.left, self.top);
}
- (void)setLeftCenterY:(STRUCT_XY)leftCenterY{
    self.left =  leftCenterY.horizonX;
    self.centerY =  leftCenterY.verticalY;
}
- (STRUCT_XY)leftCenterY{
    return XY(self.left, self.centerY);
}
- (void)setLeftBottom:(STRUCT_XY)leftBottom{
    self.left =  leftBottom.horizonX;
    self.bottom =  leftBottom.verticalY;
}
- (STRUCT_XY)leftBottom{
    return XY(self.left, self.bottom);
}
- (void)setCenterXTop:(STRUCT_XY)centerXTop{
    self.centerX =  centerXTop.horizonX;
    self.top =  centerXTop.verticalY;
}
- (STRUCT_XY)centerXTop{
    return XY(self.centerX, self.top);
}
- (void)setCenterXCenterY:(STRUCT_XY)centerXCenterY{
    self.centerX =  centerXCenterY.horizonX;
    self.centerY =  centerXCenterY.verticalY;
}
- (STRUCT_XY)centerXCenterY{
    return XY(self.centerX, self.centerY);
}
- (void)setCenterXBottom:(STRUCT_XY)centerXBottom{
    self.centerX =  centerXBottom.horizonX;
    self.bottom =  centerXBottom.verticalY;
}
- (STRUCT_XY)centerXBottom{
    return XY(self.centerX, self.bottom);
}
- (void)setRightTop:(STRUCT_XY)rightTop{
    self.right =  rightTop.horizonX;
    self.top =  rightTop.verticalY;
}
- (STRUCT_XY)rightTop{
    return XY(self.right, self.top);
}
- (void)setRightCenterY:(STRUCT_XY)rightCenterY{
    self.right =  rightCenterY.horizonX;
    self.centerY =  rightCenterY.verticalY;
}
- (STRUCT_XY)rightCenterY{
    return XY(self.right, self.centerY);
}
- (void)setRightBottom:(STRUCT_XY)rightBottom{
    self.right =  rightBottom.horizonX;
    self.bottom =  rightBottom.verticalY;
}
- (STRUCT_XY)rightBottom{
    return XY(self.right, self.bottom);
}


#pragma mark 宽高
- (void)setWidthHeight:(STRUCT_XY)widthHeight{
    self.width =  widthHeight.horizonX;
    self.height =  widthHeight.verticalY;
}
- (STRUCT_XY)widthHeight{
    return XY(self.width, self.height);
}

#pragma mark 获取高度
+ (CGFloat)fetchHeight:(id)model{
    return  [self fetchHeight:model className:NSStringFromClass(self)];
}
+ (CGFloat)fetchHeight:(id)model className:(NSString *)strClassName{
    return  [self fetchHeight:model className:isStr(strClassName)?strClassName:NSStringFromClass(self) selectorName:@"resetCellWithModel:"];
}

+ (CGFloat)fetchHeight:(id)model selectorName:(NSString *)strSelectorName{
    return  [self fetchHeight:model className:NSStringFromClass(self) selectorName:strSelectorName];
}
+ (CGFloat)fetchHeight:(id)model className:(NSString *)strClassName selectorName:(NSString *)strSelectorName{
    static NSMutableDictionary * dic;
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
    if (!isStr(strClassName)) {
        strClassName = NSStringFromClass(self);
    }
    UIView * cell = [dic objectForKey:strClassName];
    if (cell == nil) {
        cell = [NSClassFromString(strClassName) new];
        [dic setObject:cell forKey:strClassName];
    }
    [GlobalMethod performSelector:strSelectorName delegate:cell object:model isHasReturn:false];
    return cell.height;
}
+ (CGFloat)fetchHeight:(id)model par:(id)par className:(NSString *)strClassName selectorName:(NSString *)strSelectorName{
    static NSMutableDictionary * dic;
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
    if (!isStr(strClassName)) {
        strClassName = NSStringFromClass(self);
    }
    UIView * cell = [dic objectForKey:strClassName];
    if (cell == nil) {
        cell = [NSClassFromString(strClassName) new];
        [dic setObject:cell forKey:strClassName];
    }
    [cell performSelector:NSSelectorFromString(strSelectorName) withObject:model withObject:par];
    return cell.height;
}


#pragma mark 判断是否显示在屏幕上
- (BOOL)isShowInScreen;
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    // 转换view对应window的Rect
    CGRect rect = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return false;
    }
    // 若view 隐藏
    if (self.hidden) {
        return false;
    }
    // 若没有superview
    if (self.superview == nil) {
        return false;
    }
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return false;
    }
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return false;
    }
    return true;
}
@end


