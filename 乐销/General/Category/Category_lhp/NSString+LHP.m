//
//  NSString+LHP.m
//中车运
//
//  Created by 刘惠萍 on 2017/6/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSString+LHP.h"

@implementation NSString (LHP)

//适配html图片宽度
-(NSString *)fitWebImage{
    return [NSString stringWithFormat:@"<html> \n"
    "<head> \n"
    "<style type=\"text/css\"> \n"
    "body {font-size:15px;}\n"
    "</style> \n"
    "</head> \n"
    "<body>"
    "<script type='text/javascript'>"
    "window.onload = function(){\n"
    "var $img = document.getElementsByTagName('img');\n"
    "for(var p in  $img){\n"
    " $img[p].style.width = '100%%';\n"
    "$img[p].style.height ='auto'\n"
    "}\n"
    "}"
    "</script>%@"
    "</body>"
    "</html>", self];
}

//拼接url
-(NSString *)appendUrl:(NSString *)value key:(NSString *)key{
    
    if (!isStr(value)||!isStr(key)) {
        return self;
    }
    if ([self rangeOfString:[NSString stringWithFormat:@"%@=",key]].location != NSNotFound) {
        return self;
    }
    NSMutableString *string = [[NSMutableString alloc]initWithString:self];
    @try {
        NSRange range = [string rangeOfString:@"?"];
        if (range.location != NSNotFound) {//找到了
            //如果?是最后一个直接拼接参数
            if (string.length == (range.location + range.length)) {
                string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{//如果不是最后一个需要加&
                if([string hasSuffix:@"&"]){//如果最后一个是&,直接拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
                }else{//如果最后不是&,需要加&后拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
                }
            }
        }else{//没找到
            if([string hasSuffix:@"&"]){//如果最后一个是&,去掉&后拼接
                string = (NSMutableString *)[string substringToIndex:string.length-1];
            }
            string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"?%@=%@",key,value]];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    return string.copy;
}

- (NSString *)secretPhone{
    if (self.length >= 4) {
        return [NSString stringWithFormat:@"%@****%@",[self substringToIndex:3],[self substringFromIndex:self.length-4]];
    }
    return self;
}

@end
