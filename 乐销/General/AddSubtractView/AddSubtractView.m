//
//  AddSubtractView.m
//中车运
//
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "AddSubtractView.h"

@implementation AddSubtractView
#pragma mark 懒加载

- (UIImageView *)ivAdd{
    if (!_ivAdd) {
        _ivAdd = [UIImageView new];
        _ivAdd.image = [UIImage imageNamed:@"加"];
        _ivAdd.widthHeight = XY(W(22),W(22));
        _ivAdd.backgroundColor = [UIColor clearColor];
    }
    return _ivAdd;
}
- (UIImageView *)ivSub{
    if (!_ivSub) {
        _ivSub = [UIImageView new];
        _ivSub.image = [UIImage imageNamed:@"减"];
        _ivSub.widthHeight = XY(W(22),W(22));
        _ivSub.backgroundColor = [UIColor clearColor];
    }
    return _ivSub;
}

- (UIButton *)btnAdd{
    if (_btnAdd == nil) {
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAdd.backgroundColor = [UIColor clearColor];
        _btnAdd.tag = 1;
        [_btnAdd addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnAdd.widthHeight = XY(W(44),W(44));
    }
    return _btnAdd;
}
- (UIButton *)btnSubtract{
    if (_btnSubtract == nil) {
        _btnSubtract = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubtract.backgroundColor = [UIColor clearColor];
        _btnSubtract.tag = 2;
        [_btnSubtract addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnSubtract.widthHeight = XY(W(44),W(44));
    }
    return _btnSubtract;
}
- (TextFieldLimit *)textFieldNum{
    if (_textFieldNum == nil) {
        _textFieldNum = [TextFieldLimit new];
        _textFieldNum.numLimit = 10;
        _textFieldNum.font = [UIFont systemFontOfSize:F(14)];
        _textFieldNum.textColor = COLOR_TITLE;
        _textFieldNum.textAlignment = NSTextAlignmentCenter;
        _textFieldNum.borderStyle = UITextBorderStyleNone;
        _textFieldNum.backgroundColor = [UIColor clearColor];
        _textFieldNum.userInteractionEnabled = true;
        _textFieldNum.keyboardType = UIKeyboardTypeDecimalPad;
        _textFieldNum.delegate = self;
        _textFieldNum.widthHeight = XY(W(47),W(22));
        [_textFieldNum addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    }
    return _textFieldNum;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.ivAdd];
        [self addSubview:self.ivSub];
        [self addSubview:self.btnAdd];
        [self addSubview:self.btnSubtract];
        [self addSubview:self.textFieldNum];

        self.ivSub.leftTop = XY(0,0);
        self.btnSubtract.rightCenterY = XY(self.ivSub.right, self.ivSub.centerY);
        self.textFieldNum.leftCenterY = XY(self.ivSub.right,self.ivSub.centerY);
        self.ivAdd.leftTop = XY(self.textFieldNum.right,0);
        self.btnAdd.leftCenterY = XY(self.ivAdd.left, self.ivAdd.centerY);
        self.widthHeight = XY(self.ivAdd.right,self.ivAdd.height);
        self.clipsToBounds = false;
        [self resetWithNum:0];
    }
    return self;
}
#pragma mark value change
- (void)textChange{
    self.num = [self.textFieldNum.text doubleValue];
    [self numChange];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string] ;
        
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            if (toBeString.length>[toBeString rangeOfString:@"."].location+3) {
                return NO;
            }
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        
        BOOL canChange = [string isEqualToString:filtered];
        
        return  canChange;
}
#pragma mark 设置数字
- (void)numChange{
    self.num = self.num<=0?0:self.num;
    
    if (self.num==0) {
        self.btnSubtract.userInteractionEnabled = NO;
        self.btnSubtract.selected = YES;
    }else{
        self.btnSubtract.userInteractionEnabled = YES;
        self.btnSubtract.selected = NO;
    }
    
    if (self.textFieldNum.isEditing && self.textFieldNum.text.length == 0) {
        //不操作
    }else{
        if (![self.textFieldNum isFirstResponder]) {
            self.textFieldNum.text = [NSString stringWithFormat:@"%@",NSNumber.dou(self.num)];
        }
        if (self.blockNumChange) {
            self.blockNumChange(self.num);
        }
    }
}
#pragma mark 刷新view
- (void)resetWithNum:(double)num{
    self.num = num;
    [self numChange];
}


#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://加
        {
            [self endEditing:YES];
            self.num++;
            [self numChange];
        }
            break;
        case 2://减
        {
            [self endEditing:YES];
            self.num--;
            [self numChange];
        }
            break;
        default:
            break;
    }
}

//增加范围外点击事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint newPoint = [self.btnSubtract convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.btnSubtract.bounds, newPoint)) {
            view = self.btnSubtract;
        }
        newPoint = [self.btnAdd convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.btnAdd.bounds, newPoint)) {
            view = self.btnAdd;
        }
    }
    return view;
}

#pragma mark text field delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textFieldNum.text.length == 0) {
        [self numChange];
    }
}
@end
