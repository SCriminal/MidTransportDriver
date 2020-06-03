//
//  GlobalMethod+Data.m
//中车运
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "GlobalMethod+Data.h"
//ary category
#import "NSMutableArray+Insert.h"


//yykit
#import <YYKit/YYKit.h>


@implementation GlobalMethod (Data)
//验证手机号码
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    //正则表达式
    NSString *mobile = @"(^0[0-9]{2,3}-[0-9]{7,8}$)|(^(1)\\d{10}$)";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    if ([regextestMobile evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else {
        return NO;
    }
}



//从本地读取数据
+(NSDictionary *)readDataFromeLocal{
    static NSDictionary * dicLocal;
    if (dicLocal == nil) {
        NSString * strPath = [[NSBundle mainBundle]pathForResource:@"LocalData" ofType:@"json"];
        NSString* str = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:0];
        if(str){
            dicLocal = [GlobalMethod exchangeStringToDic:str];
        }
    }
    return dicLocal;


}

#pragma mark - 返回NSAttributedString并且带图片
+ (NSAttributedString *)returnNSAttributedStringWithContentStr:(NSString *)labelStr titleColor:(UIColor *)titleColor withlineSpacing:(CGFloat)lineSpacing withAlignment:(NSInteger)alignment withFont:(UIFont *)font withImageName:(NSString *)imageName withImageRect:(CGRect)rect withAtIndex:(NSUInteger)index
{
    NSString * detailStr = labelStr;
    
    if (detailStr.length > 0 && ![detailStr isEqualToString:@"<null>"] && ![detailStr isEqualToString:@"(null)"])
    {
        NSMutableAttributedString * detailAttrString = [[NSMutableAttributedString alloc]initWithString:detailStr];
        
        
        
        NSMutableParagraphStyle * detailParagtaphStyle = [[NSMutableParagraphStyle alloc]init];
        detailParagtaphStyle.alignment = alignment;      //设置两端对齐(3)
        NSDictionary * detaiDic = @{NSFontAttributeName : font,
                                    //NSKernAttributeName : [NSNumber numberWithInteger:W(0)],
                                    NSForegroundColorAttributeName:titleColor,
                                    NSParagraphStyleAttributeName : detailParagtaphStyle
                                    };
        
        [detailAttrString setAttributes:detaiDic range:NSMakeRange(0, detailAttrString.length)];
        
        //设置图片
        NSTextAttachment * attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:imageName];
        attch.bounds = rect;
        NSAttributedString * string1 = [NSAttributedString attributedStringWithAttachment:attch];
        [detailAttrString insertAttributedString:string1 atIndex:index];
        
        detailAttrString.lineSpacing = lineSpacing;
        
        return detailAttrString;
    }
    else
    {
        return nil;
    }
}

//ary to section ary
+ (NSMutableArray *)exchangeAryToSectionWithAlpha:(NSArray *)aryResponse keyPath:(NSString *)keyPath{
    
    //init ary all
    NSMutableArray * aryAll = [NSMutableArray array];
    NSString * str = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for (int i = 0; i< str.length; i++) {
        ModelAryIndex * modelAddress = [ModelAryIndex initWithStrFirst:[str substringWithRange:NSMakeRange(i, 1)]];
        [aryAll addObject:modelAddress];
    }
    //switch aryResponse
    ModelAryIndex * modelCollect = [ModelAryIndex initWithStrFirst:@"⭐️"];
    ModelAryIndex * modelOther = [ModelAryIndex initWithStrFirst:@"#"];
    for (id model in aryResponse) {
        //判断是否收藏
        if ([model respondsToSelector:NSSelectorFromString(@"isCollt")]) {
            NSNumber * num = [model valueForKeyPath:@"isCollt"];
            if ([num isKindOfClass:[NSNumber class]] && [num doubleValue]) {
                [modelCollect.aryMu addObject:model];
                continue;
            }
        }
        //首字母逻辑
        if ([model respondsToSelector:NSSelectorFromString(keyPath)]) {
            NSString * strFirst = [self fetchFirstCharactorWithString:[model valueForKeyPath:keyPath]];
            BOOL isNormal = false;
            for (ModelAryIndex * modelAddress in aryAll) {
                if ([modelAddress.strFirst isEqualToString:strFirst]) {
                    [modelAddress.aryMu addObject:model];
                    isNormal = true;
                    break;
                }
            }
            if (!isNormal) {
                [modelOther.aryMu addObject:model];
            }
        }
    }
    NSArray * arytmp = [NSArray arrayWithArray:aryAll];
    for (ModelAryIndex * model in arytmp) {
        if (model.aryMu.count == 0) {
            [aryAll removeObject:model];
        }
    }
    if (isAry(modelCollect.aryMu)) {
        [aryAll insertObject:modelCollect atIndex:0];
    }
    if (isAry(modelOther.aryMu)) {
        [aryAll insertObject:modelOther atIndex:aryAll.count];
    }
    return aryAll;
}


//转化车辆类型
+ (NSString *)exchangeCarType:(double)typeId{
    NSArray * aryDateTypes = @[@"普通货车",@"厢式货车",@"罐式货车",@"牵引车",@"普通挂车",@"罐式挂车",@"集装箱挂车",@"仓栅式货车",@"封闭货车",@"平板货车",@"集装箱车",@"自卸货车",@"特殊结构货车",@"专项作业车",@"厢式挂车",@"仓栅式挂车",@"平板挂车",@"自卸挂车",@"专项作业挂车",@"车辆运输车",@"车辆运输车（单排）"];
    NSArray * aryDateId = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21];
    for (int i = 0; i<aryDateId.count; i++) {
        NSNumber * num = aryDateId[i];
        if (num.doubleValue == typeId) {
            return aryDateTypes[i];
        }
    }
    return @"";
}
@end
