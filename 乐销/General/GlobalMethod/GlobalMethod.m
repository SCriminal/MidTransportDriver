//
//  GlobalMethod.m
//  米兰港
//
//  Created by 隋林栋 on 15/3/3.
//  Copyright (c) 2015年 Sl. All rights reserved.
//

#import "GlobalMethod.h"
#import <sys/utsname.h>
//数学
#import <math.h>
//提示框
#import "NoticeView.h"
//网络请求
#import "AFNetworkReachabilityManager.h"


@implementation GlobalMethod

#pragma mark //解析错误信息
+ (NSString *)returnErrorMessage:(id)error{
    if (error == nil) {
        return @"错误为空";
    }
    if ([error isKindOfClass:[NSString class]]) {
        NSString * strError = (NSString *)error;
        if (strError.length >0) {
            return strError;
        }
        return @"错误为空";
    }
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSString * strError = [error objectForKey:@"Message"];
        return  strError;
    }
    return  @"错误为空";
}


#pragma mark 角标清零
+ (void)zeroIcon{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}


//处理数字
+ (NSString *)exchangeNum:(double)num{
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", num];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

//去掉空格
+ (NSString *)exchangeEmpty:(NSString *)str{
    
    if (str == nil || ![str isKindOfClass:[NSString class]]) {
        return @"";
    }
    NSString * strReturn = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return strReturn;
}

//去掉换行
+ (NSString *)exchangeBlack:(NSString *)str{
    
    if (str == nil || ![str isKindOfClass:[NSString class]]) {
        return @"";
    }
    NSString * strReturn = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return strReturn;
}

//转换为jsong
+ (NSString *)exchangeDicToJson:(id)object{
    if (object == nil) {
        NSLog(@"error json转换错误");
        return @"";
    }
    if ([object isKindOfClass:[NSDictionary class]]||[object isKindOfClass:[NSArray class]]) {
        NSData * dataJson = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
        NSString * strJson = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];

        return strJson;
    }
    return @"";
}
//转换为jsong
+ (NSString *)exchangeModelsToJson:(NSArray *)object{
    if (object == nil) {
        NSLog(@"error json转换错误");
        return @"";
    }
    NSMutableArray * aryMu = [NSMutableArray new];
    if ([object isKindOfClass:[NSArray class]]) {
        for (id model in object) {
            NSDictionary * dic = [GlobalMethod performSelector:@"dictionaryRepresentation" delegate:model object:nil isHasReturn:true];
            if (dic != nil) {
                [aryMu addObject:dic];
            }
        }
    }
    
    return [self exchangeDicToJson:aryMu];
}
//转换json
+ (NSString *)exchangeModelToJson:(id)model{
    if (!model) return @"";
    if (![model respondsToSelector:@selector(dictionaryRepresentation)]) return @"";
    NSDictionary * dicJson = [model dictionaryRepresentation];
    NSData * dataJson = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];
    NSString * strJson = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];
    return strJson!=nil?strJson:@"";
}
+ (NSMutableArray *)exchangeDic:(id)response toAryWithModelName:(NSString *)modelName{
    if (response == nil || !isStr(modelName)) {
        return [NSMutableArray array];
    }
    id class = NSClassFromString(modelName);
    if (class == nil) {
        return [NSMutableArray array];
    }
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        if ([class respondsToSelector:@selector(modelObjectWithDictionary:)]) {
            id model = [class performSelector:@selector(modelObjectWithDictionary:) withObject:response];
            return [NSMutableArray arrayWithObject:model];
        }
    }
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray * aryReturn = [NSMutableArray array];
        for (NSDictionary * dic in (NSArray *)response) {
            if ([class respondsToSelector:@selector(modelObjectWithDictionary:)]) {
                id model = [class performSelector:@selector(modelObjectWithDictionary:) withObject:dic];
                [aryReturn addObject:model];
            }
        }
        return aryReturn;
    }
    return [NSMutableArray array];
}
+ (NSMutableArray *)exchangeAryModelToAryDic:(NSArray *)response{
    if (!isAry(response)) {
        return [NSMutableArray array];
    }
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (NSObject *subArrayObject in response) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [aryReturn addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [aryReturn addObject:subArrayObject];
        }
    }
    return aryReturn;
}
+ (id)exchangeDicToModel:(NSDictionary *)dic modelName:(NSString *)strName{
    if (!isStr(strName)) {
        return nil;
    }
    Class class = NSClassFromString(strName);
    if (class == nil) {
        return nil;
    }
    if ([dic isKindOfClass:[NSArray class]]) {
        return [self performSelector:@"modelObjectWithDictionary:" delegate:class object:[(NSArray *)dic lastObject] isHasReturn:true];
    }
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return [[class alloc]init];
    }
    return [self performSelector:@"modelObjectWithDictionary:" delegate:class object:dic isHasReturn:true];
}
//delegate 执行  selector
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate{
    return [self performSelector:selectorName delegate:delegate object:nil isHasReturn:false];
}
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object isHasReturn:(BOOL)isHasReturn{
    SEL selector = NSSelectorFromString(selectorName);
    if (delegate != nil && [delegate respondsToSelector:selector]) {
        if (isHasReturn) {
            return [delegate performSelector:selector withObject:object];
        }else{
            [delegate performSelector:selector withObject:object];
            return nil;
        }
    }
    return nil;
}
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object object:(id)object2 isHasReturn:(BOOL)isHasReturn{
    SEL selector = NSSelectorFromString(selectorName);
    if (delegate != nil && [delegate respondsToSelector:selector]) {
        if (isHasReturn) {
            return [delegate performSelector:selector withObject:object withObject:object2];
        }else{
            [delegate performSelector:selector withObject:object withObject:object2];
            return nil;
        }
    }
    return nil;
}


//移除空白
+ (void)removeEmpty:(NSMutableArray *)ary key:(NSString *)strKey{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (id model in ary) {
        id key = [model valueForKey:strKey];
        if (key != nil && [key isKindOfClass:[NSString class]]) {
            NSString * strKey = key;
            if (isStr(strKey)) {
                [dic setValue:model forKey:key];
            }
        }
    }
    [ary removeAllObjects];
    [ary addObjectsFromArray:dic.allValues];
}


//转换data to dic
+ (NSDictionary *)exchangeDataToDic:(NSData *)data{
    NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (data == nil || ![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    NSDictionary * dicResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (isDic(dicResponse)) {
        return dicResponse;
    }
    return [NSDictionary dictionary];
}
//转换String to dic
+ (NSDictionary *)exchangeStringToDic:(NSString *)str{
    if (!isStr(str)) {
        return [NSDictionary dictionary];
    }
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dicReturn = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dicReturn;
}
//转换String to ary
+ (NSArray *)exchangeStringToAry:(NSString *)str{
    if (!isStr(str)) {
        return [NSArray array];
    }
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * aryReturn = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return aryReturn;
}
//十六进制转颜色
+ (UIColor *)exchangeColorWith16:(NSString*)hexColor
{
    return [GlobalMethod exchangeColorWith16:hexColor alpha:1.0f];
}

//十六进制转颜色 alpha
+ (UIColor *)exchangeColorWith16:(NSString*)hexColor alpha:(CGFloat)alpha
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
}




//隐藏显示tag视图
+ (void)showHideViewWithTag:(int)tag inView:(UIView *)viewAll isshow:(BOOL)isShow{
    UIView * viewTag = [viewAll viewWithTag:tag];
    if (viewTag != nil) {
        viewTag.hidden = !isShow;
    }
}



//显示提示
+ (void)showAlert:(NSString *)strAlert{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:true];
    [[GlobalData sharedInstance].GB_NoticeView showNotice:strAlert time:1 frame:[UIScreen mainScreen].bounds viewShow:window ];
}

+ (void)showBigAlert:(NSString *)alert{
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    [BaseAlertView initWithTitle:@"提示" content:alert aryBtnModels:@[modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
}

//获取版本号
+ (NSString *)getVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;    
}

//获取APP名字
+ (NSString *)getAppName{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return appName;
    
}

/**
 *获取设备型号
 */
+ (NSString *)LookDeviceName{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    return  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

//适配label字号
+ (CGFloat)adaptLabelFont:(CGFloat)fontNum{
    if (isIphone5) {
        return  fontNum - 1;
    } else if (isIphone6){
        return fontNum;
    } else if (isIphone6p){
        return fontNum + 1;
    }
    return fontNum + 2;
}


#pragma mark 根据推送的消息进行跳转
+ (void)jumpWithPushJson{
  
}


#pragma mark 验证HTML
+(NSString *)removeHTML:(NSString *)html {
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    
    
    theScanner = [NSScanner scannerWithString:html];
    
    
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        
        
        // find end of tag
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
        
        
        
    }
    
    return html;
    
}

#pragma mark 弹出提示
+ (void)showNotiInStatusBar:(NSString *)strMsg  bageNum:(int)msgCount{
    UILocalNotification* noti = [[UILocalNotification alloc]init];
    NSDate* now = [NSDate date];
    noti.fireDate = [now dateByAddingTimeInterval:4];
    noti.timeZone = [NSTimeZone defaultTimeZone];
    noti.alertBody = strMsg;
    noti.soundName = UILocalNotificationDefaultSoundName;
    noti.alertAction = strMsg;
    noti.applicationIconBadgeNumber = msgCount;
    //    [noti setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"notikey", nil]];
    //NSLog(@"您有%d条消息需要处理",msgCount);
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}

#pragma mark 拼写文件名
+ (NSString *)fetchDoumentPath:(NSString *)name{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"sld"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *result = [path stringByAppendingPathComponent:name];
    
    return result;
}

+ (NSString*)fetchDoumentSize{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * strPath = [documentsDirectory stringByAppendingPathComponent:@"default"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    long long num = 0;
    if ([fileManager fileExistsAtPath:strPath]){
        num = [[fileManager attributesOfItemAtPath:strPath error:nil] fileSize];
    }
    return 0;
    //    NSLog(@"%@",[NSString stringWithFormat:@"%l",num/(1024.0*1024.0)]);
    //    return [NSString stringWithFormat:@"%l",num/(1024.0*1024.0)];
}



#pragma mark 判断推送状态
//+ (BOOL)IsEnablePush{
//    if (isIOS8) {// system is iOS8
//        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        if (UIUserNotificationTypeNone != setting.types) {
//            return YES;
//        }
//    } else {//iOS7
//        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//        if(UIRemoteNotificationTypeNone != type)
//            return YES;
//    }
//    return NO;
//}


#pragma mark 判断网络状态
+ (BOOL)IsEnableNetwork{
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
        return NO;
    }
    return YES;
}

+ (BOOL)IsEnableWifi{
    return ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusReachableViaWiFi);
    
}

+ (BOOL)IsENable3G{
    return ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusReachableViaWWAN);
    
}


#pragma mark encode  decode

+(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString*encodedString=(NSString*)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)unencodedString,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
    
}

//URLDEcode

+(NSString*)decodeString:(NSString*)encodedString

{
    
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString*decodedString=(__bridge_transfer  NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                 
                                                                                                                 (__bridge CFStringRef)encodedString,
                                                                                                                 
                                                                                                                 CFSTR(""),
                                                                                                                 
                                                                                                                 CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
    
}


#pragma mark获取某个字符串或者汉字的首字母.
+ (NSString *)fetchFirstCharactorWithString:(NSString *)string
{
    if (!isStr(string)) {
        return @"";
    }
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}

#pragma mark 收键盘
+ (void)hideKeyboard{
    UIViewController * vc = GB_Nav.lastVC;
    [vc.view endEditing:true];
}

#pragma mark - 获取地图Bundle中turnIcon图片
+(UIImage *)getImageFromAMapNaviBundle:(NSString *)imageName{
    NSURL *bundleURL = [[[NSBundle mainBundle] URLForResource:@"AMapNavi" withExtension:@"bundle"] URLByAppendingPathComponent:@"images"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    
    return image;
}

#pragma mark - 将某个时间戳转化成时间格式
// timestamp毫秒，用的时候要除以1000转化成秒
+ (NSString *)exchangeTimeWithStamp:(double)timestamp andFormatter:(NSString *)format{
    
    if (!timestamp) {
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [self exchangeDate:confromTimesp formatter:format];
    return confromTimespStr;
}


+ (NSDate *)exchangeTimeStampToDate:(double)timestamp{
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}
@end

