//
//  PlaceHolderTextView.m
//中车运
//
//  Created by 隋林栋 on 2016/12/24.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "PlaceHolderTextView.h"

@interface PlaceHolderTextView()

@end

@implementation PlaceHolderTextView
@synthesize textColor = _textColor;
@synthesize font = _font;
#pragma mark 懒加载
- (void)setTextColor:(UIColor *)textColor{
    if (!CGColorEqualToColor(_textColor.CGColor, textColor.CGColor)) {
        _textColor = textColor;
        self.attributes = nil;
    }
}
- (void)setFont:(UIFont *)font{
    _font = font;
    self.attributes = nil;
}
- (void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    self.attributes = nil;
}
- (NSDictionary *)attributes{
    if (!_attributes) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = self.lineSpace; // 字体的行间距
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        _attributes = @{NSForegroundColorAttributeName : self.textColor,
                        NSFontAttributeName : self.font,NSParagraphStyleAttributeName:paragraphStyle
                        };
    }
    return _attributes;
}
- (UILabel *)placeHolder{
    if (_placeHolder == nil) {
        _placeHolder = [UILabel new];
        _placeHolder.hidden = false;
        [GlobalMethod setLabel:_placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor lightGrayColor] text:@""];
        _placeHolder.leftTop = XY(W(0),W(0));
    }
    return _placeHolder;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    self.attributedText = [[NSAttributedString alloc]initWithString:UnPackStr(text) attributes:self.attributes];
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];

    if (self.isFirstResponder) {
        self.placeHolder.hidden = true;
    }else{
        self.placeHolder.hidden = attributedText&&attributedText.length>0;
    }
}
#pragma mark 初始化
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.clipsToBounds = true;
    }
    return self;
}

- (void)setUp{
    //generate origin
    self.lineSpace = W(5);
    self.textColor = COLOR_SUBTITLE;
    self.font = [UIFont systemFontOfSize:F(15)];
    
    [self addSubview:self.placeHolder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEdit:) name:UITextViewTextDidEndEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange) name:UITextViewTextDidChangeNotification object:self];

}

#pragma mark dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark 监听方法
- (void)beginEditing:(NSNotification *)notice{
    self.placeHolder.hidden = true;
}

- (void)endEdit:(NSNotification *)notice{
    self.placeHolder.hidden = self.text.length > 0;
}

- (void)didChange{
    //保存光标的位置
    if (self.markedTextRange == nil) {
        NSRange rangeSelect = self.selectedRange;

        if (rangeSelect.location == NSNotFound) {
            rangeSelect.location = self.text.length;
        }
        self.attributedText = [[NSAttributedString alloc]initWithString:UnPackStr(self.text) attributes:self.attributes];
        self.selectedRange = rangeSelect;
        if (self.blockTextChange) {
            self.blockTextChange(self);
        }
        [self changeLinesCallBlock:true];
    }else{
        if (self.blockTextChange) {
            self.blockTextChange(self);
        }
        [self changeLinesCallBlock:true];
    }
}

- (void)changeLinesCallBlock:(BOOL)isCall{
    CGFloat heightOrigin = self.numTextHeight;
    self.numTextHeight = [self sizeThatFits:CGSizeMake(self.width, CGFLOAT_MAX)].height;
    if (self.numTextHeight != heightOrigin && self.blockHeightChange && isCall) {
        self.blockHeightChange(self);
    }
}
@end
