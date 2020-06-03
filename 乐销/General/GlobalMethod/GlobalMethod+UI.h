//
//  GlobalMethod+UI.h
//中车运
//
//  Created by 隋林栋 on 2016/12/16.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "GlobalMethod.h"
//model
#import "ModelAryIndex.h"

@interface GlobalMethod (UI)
//计算高度 宽度
+ (CGFloat)fetchHeightFromLabel:(UILabel *)label;
+ (CGFloat)fetchHeightFromLabel:(UILabel *)label heightLimit:(CGFloat )height;
+ (CGFloat)fetchWidthFromLabel:(UILabel *)label;
+ (CGFloat)fetchWidthFromButton:(UIButton *)btn;
+ (CGFloat)fetchHeightFromFont:(NSInteger)fontNum;
//设置label
+ (void)setLabel:(UILabel *)label
      widthLimit:(CGFloat )widthLimit
        numLines:(NSInteger)numLines
         fontNum:(CGFloat)fontNum
       textColor:(UIColor *)textColor
         aligent:(NSTextAlignment )aligent
            text:(NSString *)text
         bgColor:(UIColor *)color;
+ (void)setLabel:(UILabel *)label
      widthLimit:(CGFloat )widthLimit
        numLines:(NSInteger)numLines
         fontNum:(CGFloat)fontNum
       textColor:(UIColor *)textColor
            text:(NSString *)text;

+ (void)resetLabel:(UILabel *)label
   attributeString:(NSAttributedString *)text
        widthLimit:(CGFloat )widthLimit;

//设置圆角
+ (void)setRoundView:(UIView *)iv color:(UIColor *)color numRound:(CGFloat)numRound width:(CGFloat)width;

//textfield添加左边距
+ (void)setTextFileLeftPadding:(UITextField *)ut leftPadding:(float)leftPadding;

//设置日期格式
+ (NSString *)exchangeDate:(NSDate *)date formatter:(NSString *)formate;
+ (NSDate *)exchangeStringToDate:(NSString *)string formatter:(NSString *)formate;
+ (NSString *)exchangeString:(NSString *)string fromFormatter:(NSString *)formateFrom toFormatter:(NSString *)formateTo;
+ (NSDate *)exchangeString:(NSString *)str formatter:(NSString *)formate;
+ (NSString *)exchangeDateStringResponse:(NSString *)str formatter:(NSString *)formate;
//获取时间戳
+ (NSString *)fetchTimeStamp;
//获取时间戳
+ (NSString *)fetchTimeStampFromDate:(NSDate *)date;
// exhcnage status bar
+ (void)exchangeStatusBar:(UIStatusBarStyle) statusBarStyle;
+ (void)exchangeStatusBarHidden:(BOOL)hidden;
//红色的数字
+ (void)exchangeLabel:(UILabel *)label count:(int)count;
+ (void)exchangeLabel:(UILabel *)label positiveCount:(int)count;
//设置行间距
+(void)setAttributeLabel:(UILabel *)label content:(NSString *)content width:(CGFloat)width;
+(void)setAttributeLabel:(UILabel *)label content:(NSString *)content width:(CGFloat)width lineSpace:(CGFloat)line;
//sectionHeaderView
+(UIView *)resetTitle:(NSString *)title;
+(CGFloat)fetchTitleHeight:(ModelAryIndex *)modelSection;

//复制内容到剪切板
+ (void)copyToPlte:(NSString *)str;
//显示编辑提示dismissBlock与ConfirmBlock
+ (void)showEditAlertDismiss:(void (^)())dismissblock confirm:(void (^)())confirmblock view:(UIView *)view;
+ (void)showEditAlertWithTitle:(NSString *)title content:(NSString *)content dismiss:(void (^)())dismissblock confirm:(void (^)())confirmblock view:(UIView *)view;

//收键盘
+ (void)endEditing;
//图片格式检查
+ (NSString *)imageFormatFromImageData:(NSData *)imageData;
@end
