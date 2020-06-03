//
//  GlobalMethod+UI.m
//中车运
//
//  Created by 隋林栋 on 2016/12/16.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "GlobalMethod+UI.h"
//数据大小
#import <limits.h>



@implementation GlobalMethod (UI)

#pragma mark 计算label size
+ (CGFloat)fetchHeightFromLabel:(UILabel *)label{
    return [self fetchHeightFromLabel:label heightLimit:10000];
}

+ (CGFloat)fetchHeightFromLabel:(UILabel *)label heightLimit:(CGFloat )height{
    if (label == nil) {
        return 0;
    }
    NSAttributedString * attributeString = [[NSAttributedString alloc]initWithString:!isStr(label.text)? @"A":label.text attributes:@{NSFontAttributeName: label.font}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(label.width, height)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat num_height_return = rect.size.height+1;
    //限制行数
    if (label.numberOfLines != 0) {
        attributeString = [[NSAttributedString alloc]initWithString:@"A" attributes:@{NSFontAttributeName: label.font}];
        rect =[attributeString boundingRectWithSize:CGSizeMake(label.width, height)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        num_height_return = num_height_return >label.numberOfLines*rect.size.height?label.numberOfLines*rect.size.height:num_height_return;
    }
    return ceil(num_height_return) ;
}

+ (CGFloat)fetchWidthFromLabel:(UILabel *)label{
    NSString * strContent = label.text == nil ? @"":label.text;
    
    UIFont * font = label.font;
    NSAttributedString * attributeString = [[NSAttributedString alloc]initWithString:strContent attributes:@{NSFontAttributeName: font}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(1000, 1000)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    //    NSLog(@"ceil Before: %lf",rect.size.width);
    return ceil(rect.size.width);
}


+ (CGFloat)fetchWidthFromButton:(UIButton *)btn{
    UILabel * label = [UILabel new];
    label.font = btn.titleLabel.font;
    label.text = btn.titleLabel.text;
    return [self fetchWidthFromLabel:label];
}

//设置label
+ (void)setLabel:(UILabel *)label
      widthLimit:(CGFloat )widthLimit
        numLines:(NSInteger)numLines
         fontNum:(CGFloat)fontNum
       textColor:(UIColor *)textColor
         aligent:(NSTextAlignment )aligent
            text:(NSString *)text
         bgColor:(UIColor *)color{
    label.numberOfLines = numLines;
    label.font = [UIFont systemFontOfSize:fontNum];
    label.textColor = textColor == nil? COLOR_TITLE : textColor;
    label.textAlignment = aligent;
    label.backgroundColor = color == nil?[UIColor clearColor]:color;
    label.text = UnPackStr(text);
    CGFloat widthMAX= [self fetchWidthFromLabel:label];
    //    NSLog(@"widthMAX : %lf",widthMAX);
    if (widthLimit != 0 ) {
        if (widthMAX < widthLimit) {
            label.width = widthMAX;
        }else {
            label.width = widthLimit;
        }
    }else {
        label.width = widthMAX;
    }
    label.height = [self fetchHeightFromLabel:label];
}

+ (void)setLabel:(UILabel *)label
      widthLimit:(CGFloat )widthLimit
        numLines:(NSInteger)numLines
         fontNum:(CGFloat)fontNum
       textColor:(UIColor *)textColor
            text:(NSString *)text{
    [self setLabel:label widthLimit:widthLimit numLines:numLines fontNum:fontNum textColor:textColor aligent:label.textAlignment text:text bgColor:[UIColor clearColor]];
}

+ (void)resetLabel:(UILabel *)label
   attributeString:(NSAttributedString *)text
        widthLimit:(CGFloat )widthLimit{
    label.attributedText = text;
    CGRect rect =[text boundingRectWithSize:CGSizeMake(widthLimit, 1000)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    label.width = MIN(CGRectGetWidth(rect), widthLimit?:CGFLOAT_MAX);
    //限制行数
    label.height = [self fetchHeightFromLabel:label heightLimit:CGFLOAT_MAX];
//    label.height = rect.size.height+1;
}

+ (CGFloat)fetchHeightFromFont:(NSInteger)fontNum{
    NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:@"A" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontNum]}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(INTMAX_MAX, INTMAX_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return  rect.size.height;
}


//设置圆角
+ (void)setRoundView:(UIView *)iv color:(UIColor *)color numRound:(CGFloat)numRound width:(CGFloat)width
{
    iv.layer.cornerRadius = numRound;//圆角设置
    iv.layer.masksToBounds = YES;
    [iv.layer setBorderWidth:width];
    iv.layer.borderColor = color.CGColor;
}

//设置textfield左间距
+ (void)setTextFileLeftPadding:(UITextField *)ut leftPadding:(float)leftPadding{
    CGRect frame = ut.frame;
    frame.size.width = leftPadding;
    UIView *leftV = [[UIView alloc] initWithFrame:frame];
    ut.leftViewMode = UITextFieldViewModeAlways;
    ut.leftView = leftV;
}

//设置日期格式
+ (NSString *)exchangeDate:(NSDate *)date formatter:(NSString *)formate{
    if (date == nil || formate == nil) {
        return @"";
    }
    
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"myDateFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setAMSymbol:@"上午"];
                [dateFormatter setPMSymbol:@"下午"];
                threadDictionary[@"myDateFormatter"] = dateFormatter;
            }
        }
    }
    // 必填字段
    //    static NSDateFormatter *dateFormatter = nil;
    //    if (dateFormatter == nil) {
    //        dateFormatter = [[NSDateFormatter alloc] init];
    //        [dateFormatter setAMSymbol:@"上午"];
    //        [dateFormatter setPMSymbol:@"下午"];
    //    }
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formate];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}
//设置日期格式
+ (NSDate *)exchangeStringToDate:(NSString *)string formatter:(NSString *)formate{
    if (!isStr(string) || !isStr(formate)) {
        return nil;
    }
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"myStrToDateformatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                threadDictionary[@"myStrToDateformatter"] = dateFormatter;
            }
        }
    }
    //    // 必填字段
    //    static NSDateFormatter *dateFormatter = nil;
    //    if (dateFormatter == nil) {
    //        dateFormatter = [[NSDateFormatter alloc] init];
    //    }
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formate];
    //用[NSDate date]可以获取系统当前时间
    return [dateFormatter dateFromString:string];
}
//转换日期格式
+ (NSString *)exchangeString:(NSString *)string fromFormatter:(NSString *)formateFrom toFormatter:(NSString *)formateTo{
    if (!isStr(string)) {
        return @"";
    }
    NSDate * date= [self exchangeStringToDate:string formatter:formateFrom];
    if (date) {
        return [self exchangeDate:date formatter:formateTo];
    }
    return @"";
}
+ (NSDate *)exchangeString:(NSString *)str formatter:(NSString *)formate{
    if (str == nil || formate == nil) {
        return [NSDate date];
    }
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"myStrDateFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                threadDictionary[@"myStrDateFormatter"] = dateFormatter;
            }
        }
    }
    // 必填字段
    //    static NSDateFormatter *dateFormatter = nil;
    //
    //    if (dateFormatter == nil) {
    //        dateFormatter = [[NSDateFormatter alloc] init];
    //    }
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formate];
    //用[NSDate date]可以获取系统当前时间
    NSDate *currentDate = [dateFormatter dateFromString:str];
    return currentDate;
}
+ (NSString *)exchangeDateStringResponse:(NSString *)str formatter:(NSString *)formate{
    if (!isStr(str)) {
        return @"";
    }
    NSRange range = [str rangeOfString:@"0001"];
    if (range.location != NSNotFound) {
        return @"";
    }
     range = [str rangeOfString:@"."];
    if (range.length > 0) {
        str = [str substringToIndex:range.location];
    }
//    NSArray * aryDate = [str componentsValidSeparatedByString:@"T"];
//    NSDate * dateYear = [self exchangeString:aryDate.firstObject formatter:@"yyyy-MM-dd"];
//    NSDate * dateHour = [self exchangeString:aryDate.lastObject formatter:@"HH-mm-ss"];
//    NSString * strDate = [NSString stringWithFormat:@"%@ %@",[self exchangeDate:dateYear formatter:@"yyyy-MM-dd"],[self exchangeDate:dateHour formatter:@"HH-mm-ss"]];
    NSDate * dateRight = [self exchangeString:str formatter:@"yyyy-MM-dd HH-mm-ss"];
    NSString * strReturn = [self exchangeDate:dateRight formatter:formate];
    
    return isStr(strReturn)?strReturn:str;
}

//获取时间戳
+ (NSString *)fetchTimeStamp{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}
//获取时间戳
+ (NSString *)fetchTimeStampFromDate:(NSDate *)date{
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}
// exhcnage status bar
+ (void)exchangeStatusBar:(UIStatusBarStyle) statusBarStyle{
    [GlobalData sharedInstance].statusBarStyle = statusBarStyle;
    UIViewController * lastVC = GB_Nav.lastVC;
    [lastVC setNeedsStatusBarAppearanceUpdate];
}
+ (void)exchangeStatusBarHidden:(BOOL)hidden{
    [GlobalData sharedInstance].statusHidden = hidden;
    UIViewController * lastVC = GB_Nav.lastVC;
    [lastVC setNeedsStatusBarAppearanceUpdate];
}
//红色的数字
+ (void)exchangeLabel:(UILabel *)label positiveCount:(int)count {
    label.hidden = count <=0;
    if (!label ) return;
    count = count>99?99:count;
    NSString * strNum = count < 10? @"AAA": @"AAAA";
    [GlobalMethod setLabel:label widthLimit:0 numLines:0 fontNum:F(12) textColor:[UIColor whiteColor] text:strNum];
    label.backgroundColor = [UIColor redColor];
    [GlobalMethod setRoundView:label color:[UIColor clearColor] numRound:label.height / 2.0- W(2) width:0];
    label.text = [NSString stringWithFormat:@"+%d",count];
    label.textAlignment = NSTextAlignmentCenter;
    
}
+ (void)exchangeLabel:(UILabel *)label count:(int)count {
    label.hidden = count <=0;
    if (!label ) return;
    count = count>99?99:count;
    NSString * strNum = count < 10? @"AA": @"AAA";
    [GlobalMethod setLabel:label widthLimit:0 numLines:0 fontNum:F(13) textColor:[UIColor whiteColor] text:strNum];
    label.backgroundColor = [UIColor colorWithHexString:@"FF3880"];
    [GlobalMethod setRoundView:label color:[UIColor clearColor] numRound:label.height / 2.0 width:0];
    label.text = [NSString stringWithFormat:@"%d",count];
    label.textAlignment = NSTextAlignmentCenter;
}
//设置行间距
+(void )setAttributeLabel:(UILabel *)label content:(NSString *)content width:(CGFloat)width
{
    [self setAttributeLabel:label content:content width:width lineSpace:F(7)];
}
+(void)setAttributeLabel:(UILabel *)label content:(NSString *)content width:(CGFloat)width lineSpace:(CGFloat)line{
    label.width = width;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:line];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    [label setAttributedText:attributedString];
    [label sizeToFit];
}


//sectionHeaderView
+(UIView *)resetTitle:(NSString *)title{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = COLOR_BACKGROUND;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 0)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = COLOR_TITLE;
    label.fontNum = F(14);
    [label fitTitle:title variable:0];
    [contentView addSubview:label];
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, label.height + W(30));
    label.centerY = contentView.height/2.0;
    [contentView addLineFrame:CGRectMake(0, contentView.height -1, SCREEN_WIDTH, 1)];
    return contentView;
}
+(CGFloat)fetchTitleHeight:(ModelAryIndex *)modelSection{
    static UIView *view ;
    if (!view) {
        view = [self resetTitle:@"A"];
    }
    if (modelSection && isStr(modelSection.strFirst)) {
        return view.height;
    }
    return 0;
}

//复制内容到剪切板
+ (void)copyToPlte:(NSString *)str{
    if (!isStr(str)) {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = str;
}

//显示编辑提示
+ (void)showEditAlert:(void (^)(void))block view:(UIView *)view{
    ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
    modelDismiss.blockClick = block;
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    modelConfirm.blockClick = ^(void){
        [GB_Nav popViewControllerAnimated:true];
    };
    [BaseAlertView initWithTitle:@"确认取消编辑？" content:@"返回将清除编辑的内容" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:view];
}
//显示编辑提示dismissBlock与ConfirmBlock
+ (void)showEditAlertDismiss:(void (^)(void))dismissblock confirm:(void (^)())confirmblock view:(UIView *)view{
    [self showEditAlertWithTitle:@"确认取消编辑？" content:@"返回将清除编辑的内容" dismiss:dismissblock confirm:confirmblock view:view];
}
+ (void)showEditAlertWithTitle:(NSString *)title content:(NSString *)content dismiss:(void (^)(void))dismissblock confirm:(void (^)())confirmblock view:(UIView *)view{
    ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
    modelDismiss.blockClick = dismissblock;
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_SUBTITLE];
    modelConfirm.blockClick = confirmblock;
    [BaseAlertView initWithTitle:title content:content aryBtnModels:@[modelDismiss,modelConfirm] viewShow:view];
}


//收键盘
+ (void)endEditing{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:true];
}


//图片格式检查
+ (NSString *)imageFormatFromImageData:(NSData *)imageData{
    
    uint8_t first_byte;
    [imageData getBytes:&first_byte length:1];
    switch (first_byte) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            if ([imageData length] < 12) {
                return nil;
            }
            
            NSString *dataString = [[NSString alloc] initWithData:[imageData subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([dataString hasPrefix:@"RIFF"] && [dataString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return nil;
    }
    return nil;
}
@end
