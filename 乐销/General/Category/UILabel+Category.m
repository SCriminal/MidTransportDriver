//
//  UILabel+Category.m
//中车运
//
//  Created by 刘惠萍 on 2017/4/29.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UILabel+Category.h"
#import <objc/runtime.h>
#import "NSObject+Catrgory.h"
//YYKit
#import  <YYKit/YYKit.h>
//model
#import "ModelLabel.h"
static const char lineSpaceKey = '\0';
static const char numLimitKey = '\0';

@implementation UILabel (Category)

#pragma mark 运行时 获取line space
- (void)setLineSpace:(CGFloat)lineSpace{
    objc_setAssociatedObject(self, &lineSpaceKey, [NSNumber numberWithFloat:lineSpace], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)lineSpace{
    NSNumber * lineSpace = objc_getAssociatedObject(self, &lineSpaceKey);
    return lineSpace?[lineSpace floatValue]:0;
}
- (void)setNumLimit:(int)numLimit{
    objc_setAssociatedObject(self, &numLimitKey, [NSNumber numberWithInt:numLimit], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (int)numLimit{
    NSNumber * lineSpace = objc_getAssociatedObject(self, &numLimitKey);
    return lineSpace?[lineSpace intValue]:0;
}
//替换方法
+ (void)load{
    static dispatch_once_t onceDispatch;
    dispatch_once(&onceDispatch, ^{
        method_exchangeImplementations(class_getInstanceMethod(self,@selector(setText:)), class_getInstanceMethod(self,@selector(lhpSetText:)));
        
    });
}
#pragma mark set
- (void)setFontNum:(CGFloat)fontNum{
    self.font = [UIFont systemFontOfSize:fontNum weight:UIFontWeightRegular];
}

- (CGFloat)fontNum{
    return self.font.pointSize;
}

-(void)lhpSetText:(NSString *)str{
    if (str&&[str isKindOfClass:[NSString class]]&& self.numLimit) {
        [self lhpSetText:str.length>=self.numLimit?[str substringToIndex:self.numLimit]:str];
    }else{
        [self lhpSetText:str];
    }
}
#pragma mark method
//获取刷新客户标签
-(void)resetCustomerType:(double)type{
    if (type == 1) {
        [self  fitTitle:@" 代理 "  variable:0];
        self.backgroundColor = [UIColor orangeColor];
    }if (type == 2) {
        [self  fitTitle:@" 零售 "  variable:0];
        self.backgroundColor = COLOR_SUBTITLE;
    }
    if (type == 3) {
        [self  fitTitle:@" 种植 "  variable:0];
        self.backgroundColor = COLOR_MAIN;
    }
    
}



/**
 固定宽度
 
 @param width 宽度
 */
- (void)fitFixed:(CGFloat)width{

    [self fitWidth:width isFixed:true];
}
/**
 固定宽度
 @param title 内容
 @param width 宽度
 */
- (void)fitTitle:(NSString *)title fixed:(CGFloat)width{

    self.text = UnPackStr(title);

    [self fitFixed:width];
}

/**
 可变宽度
 @param width 宽度
 */
- (void)fitVariable:(CGFloat)width{
    [self fitWidth:width?:CGFLOAT_MAX isFixed:false];
}
/**
 可变宽度
 @param title 内容
 @param width 宽度
 */
- (void)fitTitle:(NSString *)title variable:(CGFloat)width{
    self.text = UnPackStr(title);
    [self fitVariable:width];
}
/**
 根据行数改变宽高
 
 @param width 宽度
 @param isFiexed 宽度是否固定
 */
- (void)fitWidth:(CGFloat)width isFixed:(BOOL)isFiexed{
    NSString * string = self.text;
    if (!isStr(string) || !width) {
        self.widthHeight = XY(isFiexed?width:0, self.font.lineHeight);
        return;
    }
    //获取高度 会获取行高
    CGSize size = [self fetchRectWithString:string width:width];
    CGFloat num_height_return = size.height;
    
    //如果有行高 并且不是一行
    if (self.lineSpace && num_height_return > self.font.lineHeight) {
        NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
        //段落格式
        NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = self.textAlignment;
        paragraphStyle.lineSpacing = self.lineSpace;
        [attributeString setAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:self.font} range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributeString;
    }
    //限制行数 并且超过一行
    if (self.numberOfLines != 0 && num_height_return > self.font.lineHeight) {
        CGFloat heightLines = self.numberOfLines * self.font.lineHeight + (self.numberOfLines - 1)*self.lineSpace;
        num_height_return = num_height_return >heightLines ?heightLines :num_height_return;
    }
    self.widthHeight = XY(isFiexed?width:size.width, num_height_return);
}


/**
 attribute label 固定宽度
 
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrFixed:(CGFloat)width models:(NSArray *)models{
    [self resetAttributeStrWidth:width isFiexed:true models:models lineSpace:0];
}

/**
 attribute label 固定宽度
 
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrFixed:(CGFloat)width models:(NSArray *)models lineSpace:(CGFloat)lineSpace{
    [self resetAttributeStrWidth:width isFiexed:true models:models lineSpace:lineSpace];
}

/**
 attribute label 可变宽度
 
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrVariable:(CGFloat)width models:(NSArray *)models{
    [self resetAttributeStrWidth:width isFiexed:false models:models lineSpace:self.lineSpace];
}

/**
 attribute label 可变宽度
 @param width 宽度限制
 @param models ModelLabel
 */
-(void)resetAttributeStrVariable:(CGFloat)width models:(NSArray *)models lineSpace:(CGFloat)lineSpace{
    [self resetAttributeStrWidth:width isFiexed:false models:models lineSpace:lineSpace];
}

/**
 富文本文字显示
 
 @param width 宽度限制
 @param models ModelLabel
 @param lineSpace 行高
 */
-(void)resetAttributeStrWidth:(CGFloat)width isFiexed:(BOOL)isFiex models:(NSArray *)models lineSpace:(CGFloat)lineSpace{
    NSString *labelText=@"";
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:models];
    for (int i=0; i<models.tmpAry.count; i++) {
        ModelLabel *model = models[i];
        model.range = NSMakeRange(labelText.length, model.text.length);
        [mutArr addObject:model];
        labelText =  [labelText stringByAppendingString:UnPackStr(model.text)];
    }
    self.text = labelText;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableDictionary *attributes=[NSMutableDictionary dictionary];
    [mutArr enumerateObjectsUsingBlock:^(ModelLabel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange sizeRange = model.range;
        if (sizeRange.length>0) {
            if (model.textColor) {
                [attributes setValue:model.textColor forKey:NSForegroundColorAttributeName];
            }
            if (model.fontAttribute) {
                [attributes setValue:[UIFont fontWithName:model.fontAttribute size:(CGFloat)(model.font>0? model.font:self.font.pointSize)] forKey:NSFontAttributeName];
            }else{
                [attributes setValue:[UIFont systemFontOfSize:(CGFloat)(model.font>0? model.font:self.font.pointSize)] forKey:NSFontAttributeName];
            }
            [str setAttributes:attributes range:sizeRange];
        }
    }];
    if (lineSpace) {
        str.lineSpacing = lineSpace;
    }
    self.attributedText = str;
    
    CGRect rect =[str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGFloat num_height_return = CGRectGetHeight(rect);
    //限制行数
    if (self.numberOfLines != 0) {
        CGFloat lineHeight = [self fetchRectWithString:@"A" width:CGFLOAT_MAX].height;
        num_height_return = num_height_return > (self.numberOfLines*lineHeight + (self.numberOfLines-1)*lineSpace)?self.numberOfLines*lineHeight:num_height_return;
    }
    
    self.widthHeight = XY(isFiex?width:CGRectGetWidth(rect), num_height_return);
}
//计算高度的方法
- (CGSize)fetchRectWithString:(NSString *)string width:(CGFloat)width{
    //如果string 无效 返回
    if (!isStr(string)) {
        return CGSizeMake(0, 0);
    }
    CGRect frame = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.lineSpace?@{NSParagraphStyleAttributeName:[NSMutableParagraphStyle initWithLineSpace:self.lineSpace],NSFontAttributeName:self.font}:@{NSFontAttributeName:self.font} context:nil];
    //如果只有一行
    if (self.lineSpace && CGRectGetHeight(frame) == self.font.lineHeight + self.lineSpace) {
        return  CGSizeMake(CGRectGetWidth(frame), self.font.lineHeight);
    }
    return  CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
}

- (CGRect)boundingRectForCharacterRange:(NSRange)range
{
    NSMutableAttributedString * attributedText;
    if (self.lineSpace) {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }else{
        attributedText = [[NSMutableAttributedString alloc]initWithString:self.text];
        //段落格式
        NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = self.textAlignment;
        [attributedText setAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:self.font} range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributedText;
    }
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedText];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
    textContainer.lineFragmentPadding = 0;
    textContainer.lineBreakMode = self.lineBreakMode;
    
    [layoutManager addTextContainer:textContainer];
    
    NSRange glyphRange = NSMakeRange(0, 0);
//    NSRange characterRange = NSMakeRange(0, 0);
    // Convert the range for glyphs.
    //    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    
    CGRect rectReturn = [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
    
    
    return rectReturn;
}

//limit width then subtract text; line break mode must be NSLineBreakByCharWrapping
- (void)configStringWithLimitWidth{
    self.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString * attributedText;
    if (self.lineSpace) {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }else{
        attributedText = [[NSMutableAttributedString alloc]initWithString:self.text];
        //段落格式
        NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = self.textAlignment;
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        [attributedText setAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:self.font} range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributedText;
    }
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedText];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
    textContainer.lineFragmentPadding = 0;
    textContainer.lineBreakMode = self.lineBreakMode;
    
    [layoutManager addTextContainer:textContainer];
    NSRange rangeText = [layoutManager glyphRangeForBoundingRect:self.bounds  inTextContainer:textContainer];
    
    self.text = [self.text substringWithRange:rangeText];
}

//fetch height
+ (CGFloat)fetchHeightFontNum:(CGFloat)numFont string:(NSString *)title lineSpace:(CGFloat)lineSpace widthLimit:(CGFloat)widthLimit heightLimit:(CGFloat)heightLimit{
    static UILabel * label = nil;
    if (!label) {
        label = [UILabel new];
    }
    label.fontNum = numFont;
    label.lineSpace = lineSpace;
    CGSize size = [label fetchRectWithString:title width:widthLimit];
    return heightLimit?MIN(heightLimit, size.height):size.height;
    
}
//fetch widht
+ (CGFloat)fetchWidthFontNum:(CGFloat)num text:(NSString *)str{
    if (!isStr(str)) {
        return 0;
    }
    static UILabel * label = nil;
    if (!label) {
        label = [UILabel new];
    }
    label.fontNum = num;
     [label fitTitle:str variable:0];
    return label.width;
}
//设置label默认阴影
-(void)setNormalShadow{
    [self setShadowColor:[UIColor blackColor] range:NSMakeRange(0, self.text.length) offsetsize:CGSizeMake(0, 1)];
}
//设置label阴影
-(void)setShadowColor:(UIColor *)shadowColor range:(NSRange)range offsetsize:(CGSize)size{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowBlurRadius = 1.0;
    shadow.shadowOffset = size;
    shadow.shadowColor = shadowColor;
    [str addAttribute:NSShadowAttributeName
                value:shadow
                range:range];
    self.attributedText = str;
    //label自身阴影属性不可设置range
    //    self.shadowColor = shadowColor;
    //    //阴影偏移  x，y为正表示向右下偏移
    //    self.shadowOffset = size;
}
#pragma mark logical
//价格与累积采购之间添加I
-(void)setPriceLabelSpaceMark:(NSString*)attributeStr{
    NSRange range = [attributeStr rangeOfString:@"I"];
    NSValue * value = [NSValue valueWithRange:range];
    NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:value, nil];
    [self setAttributedText:[ReturnAttributeStr returnDifferentTextColorWithText:attributeStr lineSpacing:0 alignment:0 rangArray:array color:[UIColor colorWithHexString:@"#E5E5E5"]]];
    
}
@end
