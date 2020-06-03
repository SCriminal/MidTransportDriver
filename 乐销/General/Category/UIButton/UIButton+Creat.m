//
//  UIButton+Creat.m
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/6/21.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "UIButton+Creat.h"
//runtime
#import <objc/runtime.h>
static const char modelBtnKey = '\0';
@implementation UIButton (Creat)

#pragma mark runtime add property
- (void)setModelBtn:(ModelBtn *)modelBtn{
    objc_setAssociatedObject(self, &modelBtnKey, modelBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (ModelBtn *)modelBtn{
    return objc_getAssociatedObject(self, &modelBtnKey);
}


#pragma mark fit width
- (CGFloat)fitWidth{
    UIFont * font = self.titleLabel.font;
    NSAttributedString * attributeString = [[NSAttributedString alloc]initWithString:self.titleLabel.text attributes:@{NSFontAttributeName: font}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return CGRectGetWidth(rect);
}
- (CGFloat)fitHeight{
    return self.titleLabel.font.lineHeight;
}

#pragma mark logic relate
+ (UIButton *)createBottomBtn:(NSString *)title{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = COLOR_BLUE;
    btn.titleLabel.font = [UIFont systemFontOfSize:F(14)];
    [GlobalMethod setRoundView:btn color:[UIColor clearColor] numRound:W(5) width:0];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.widthHeight = XY(SCREEN_WIDTH - W(30), W(75)/2.0);
    return btn;
}
@end
