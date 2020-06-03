//
//  LoginTextField.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "LoginTextField.h"

@interface LoginTextField ()

@end

@implementation LoginTextField
#pragma mark 懒加载
- (UITextField *)tf{
    if (_tf == nil) {
        _tf = [UITextField new];
        _tf.font = [UIFont systemFontOfSize:F(20)];
        _tf.textAlignment = NSTextAlignmentLeft;
        _tf.textColor = [UIColor blackColor];
        _tf.borderStyle = UITextBorderStyleNone;
        _tf.backgroundColor = [UIColor clearColor];
        _tf.delegate = self;
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _tf;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}
- (UILabel *)labelPlaceHolder{
    if (_labelPlaceHolder == nil) {
        _labelPlaceHolder = [UILabel new];
        _labelPlaceHolder.textColor = COLOR_999;
        _labelPlaceHolder.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _labelPlaceHolder.numberOfLines = 0;
        _labelPlaceHolder.lineSpace = 0;
    }
    return _labelPlaceHolder;
}
#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title placeHolder:(NSString *)placeHolderString{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //重置视图坐标
    self.tf.text = title;
    self.labelPlaceHolder.hidden = isStr(self.tf.text);
    self.tf.frame = CGRectMake(W(25), 0, SCREEN_WIDTH - W(50), self.tf.font.lineHeight+2);
    
    [self.labelPlaceHolder fitTitle:placeHolderString variable:0];
    self.labelPlaceHolder.leftCenterY = XY(self.tf.left, self.tf.centerY);
    
    //设置总高度
    self.height = self.labelPlaceHolder.bottom + W(22);
    self.line.left = W(25);
    self.line.widthHeight = XY(SCREEN_WIDTH - W(50), 1);
    self.line.bottom = self.height;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self addSubview:self.tf];
    [self addSubview:self.labelPlaceHolder];
    [self addSubview:self.line];
}


#pragma textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.labelPlaceHolder.hidden = true;
    
    self.line.widthHeight = XY(SCREEN_WIDTH - W(50), 2);
    self.line.backgroundColor = COLOR_BLUE;
    self.line.bottom = self.height;
    return  true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.labelPlaceHolder.hidden = isStr(self.tf.text);
    
    self.line.widthHeight = XY(SCREEN_WIDTH - W(50), 1);
    self.line.backgroundColor = COLOR_LINE;
    self.line.bottom = self.height;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tf resignFirstResponder];
    return  true;
}
#pragma mark click
- (void)click{
    [self.tf becomeFirstResponder];
}
@end
