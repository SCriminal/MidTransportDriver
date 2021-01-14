//
//  OrcHelper.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/14.
//Copyright © 2021 ping. All rights reserved.
//

#import "OrcHelper.h"

@implementation OrcHelper

#pragma mark =======Code Here
+ (void)orc:(NSString *)imageurl delegate:(nullable id <NSURLSessionDelegate>)delegate block:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    //    [GB_Nav pushVCName:@"MainBlackVC" animated:true];
    NSString *appcode = @"e5125b82866442b8ab5ecaa2a6caa89f";
    NSString *host = @"https://ocrapi-advanced.taobao.com";
    NSString *path = @"/ocrservice/advanced";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = [NSString stringWithFormat:@"{\"url\":\"%@\",\"prob\":false,\"charInfo\":false,\"rotate\":false,\"table\":false}",imageurl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:delegate delegateQueue:[[NSOperationQueue alloc] init]];

    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:completionHandler];
    [task resume];
    
}
@end
