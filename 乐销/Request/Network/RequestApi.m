//
//  RequestApi.m
//中车运
//
//  Created by 隋林栋 on 2016/12/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "RequestApi.h"
//全局方法
#import "GlobalMethod.h"
#import "GlobalMethod+Version.h"
//请求单例
#import "RequestInstance.h"
//登陆页面
#import "LoginViewController.h"


@implementation RequestApi

+ (void)postUrl:(NSString *)URL
       delegate:(_Nullable id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure

{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:false requestType:ENUM_REQUEST_POST constructingBodyWithBlock:nil success:success failure:failure];
}

//delete
+ (void)deleteUrl:(NSString *)URL
         delegate:(_Nullable id <RequestDelegate>)delegate
       parameters:(NSDictionary *)parameters
          success:(void (^)(NSDictionary * response, id mark))success
          failure:(void (^)(NSString * errorStr, id mark))failure{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:false requestType:ENUM_REQUEST_DELETE constructingBodyWithBlock:nil success:success failure:failure];
    
}
//patch
+ (void)patchUrl:(NSString *)URL
        delegate:(_Nullable id <RequestDelegate>)delegate
      parameters:(NSDictionary *)parameters
         success:(void (^)(NSDictionary * response, id mark))success
         failure:(void (^)(NSString * errorStr, id mark))failure{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:false requestType:ENUM_REQUEST_PATCH constructingBodyWithBlock:nil success:success failure:failure];
    
}
+ (void)getUrl:(NSString *)URL
      delegate:(_Nullable id <RequestDelegate>)delegate
    parameters:(NSDictionary *)parameters
       success:(void (^)(NSDictionary * response, id mark))success
       failure:(void (^)(NSString * errorStr, id mark))failure

{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:false requestType:ENUM_REQUEST_GET constructingBodyWithBlock:nil success:success failure:failure];
}


//上传图片
+ (void)postUrl:(NSString *)URL
       delegate:(_Nullable id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure
{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:true requestType:ENUM_REQUEST_POST constructingBodyWithBlock:block success:success failure:failure];
}

#pragma mark 网络请求 返回全部
// post
+ (void)postUrl:(NSString *)URL
       delegate:(_Nullable id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
      returnALL:(BOOL)returnAll
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:returnAll requestType:ENUM_REQUEST_POST constructingBodyWithBlock:nil success:success failure:failure];
}

//get
+ (void)getUrl:(NSString *)URL
      delegate:(_Nullable id <RequestDelegate>)delegate
    parameters:(NSDictionary *)parameters
     returnALL:(BOOL)returnAll
       success:(void (^)(NSDictionary * response, id mark))success
       failure:(void (^)(NSString * errorStr, id mark))failure{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:returnAll requestType:ENUM_REQUEST_GET constructingBodyWithBlock:nil success:success failure:failure];
}

//上传图片
+ (void)postUrl:(NSString *)URL
       delegate:(_Nullable id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
      returnALL:(BOOL)returnAll
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure{
    [self postUrl:URL delegate:delegate parameters:parameters returnALL:returnAll requestType:ENUM_REQUEST_POST constructingBodyWithBlock:block success:success failure:failure];
}

+ (void)postUrl:(NSString *)URL
       delegate:(_Nullable id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
      returnALL:(BOOL)returnAll
    requestType:(ENUM_REQUEST_TYPE)requestType
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure
{
    //设置请求头
    parameters = [self setInitHead:parameters];
    
    //拼接参数
    NSString * urlNew = [self replaceParameter:parameters url:URL];
    //走回调 隐藏progress
    [GlobalMethod performSelector:@"protocolWillRequest" delegate:delegate];
    
    //选择请求方式
    [self switchRequest:urlNew parameters:parameters requestType:requestType  constructingBodyWithBlock:block   success:^(NSURLSessionDataTask *task, id responseObject) {
        //上拉 下拉 刷新
        [self endRefresh:delegate];
        //返回数据
        NSDictionary * dicResponse =  [GlobalMethod exchangeDataToDic:responseObject];
        if (dicResponse == nil ) {
            //走回调 隐藏progress
            [self requestFailDelegate:delegate errorStr:@"数据请求失败" errorCode:@"0" failure:failure];
            return ;
        }
        //判断请求状态
        int codeResponse = [dicResponse intValueForKey:RESPONSE_CODE];
        if(codeResponse == RESPONSE_CODE_SUCCESS||codeResponse == RESPONSE_CODE_SCHEDULE){
            [self requestSuccessDelegate:delegate responseDic:returnAll?dicResponse:dicResponse[RESPONSE_DATA] success:success];
            return;
        }
        
        if(codeResponse ==RESPONSE_CODE_RELOGIN){
            //重新登陆
            [GlobalMethod performSelector:@"protocolDidRequestSuccess" delegate:delegate];
            [GlobalMethod relogin];
            return;
        }
        {
            //走回调 请求失败
            [self requestFailDelegate:delegate errorStr:dicResponse[RESPONSE_MESSAGE] errorCode:isNum(dicResponse[RESPONSE_CODE])?[NSString stringWithFormat:@"%@",dicResponse[RESPONSE_CODE]]:@"0"  failure:failure];
            return;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        //上拉 下拉 刷新
        [self endRefresh:delegate];
        NSLog(@"%@",error.userInfo);
        //走回调 网络连接失败
        [self requestFailDelegate:delegate errorStr:@"网络连接失败" errorCode:@"0" failure:failure];
    }];
}

#pragma mark success
+ (void)requestSuccessDelegate:(id<RequestDelegate>)delegate responseDic:(NSDictionary *)responseDic success:(void (^)(NSDictionary * response, id mark))success{
    //走回调 请求成功
    [GlobalMethod performSelector:@"protocolDidRequestSuccess" delegate:delegate];
    if (success != nil) {
        success(responseDic,nil);
    }
    [self showNoResult:delegate];
}
#pragma mark fail
+ (void)requestFailDelegate:(id<RequestDelegate>)delegate errorStr:(NSString *)strError errorCode:(NSString *)errorCode failure:(void (^)(NSString * errorStr, id mark))failure{
    [GlobalMethod performSelector:@"protocolDidRequestFailure:" delegate:delegate object:strError isHasReturn:false];
    if (failure != nil) {
        failure(strError,errorCode);
    }
    [self showNoResult:delegate];
}

#pragma mark 上拉 下拉刷新
+ (void)endRefresh:(id)delegate{
    if (delegate != nil && [delegate respondsToSelector:@selector(endRefreshing)]) {
        [delegate performSelector:@selector(endRefreshing)];
    }
}

#pragma mark 展示无数据
+ (void)showNoResult:(id)delegate{
    [GlobalMethod performSelector:@"showNoResult" delegate:delegate];
}

#pragma mark 选择请求
+ (void)switchRequest:(NSString *)URLString
           parameters:(id)parameters
          requestType:(ENUM_REQUEST_TYPE)requestType
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSURLSessionDataTask * task;
    switch (requestType) {
        case ENUM_REQUEST_GET:
            task = [[RequestInstance sharedInstance] GET:URLString parameters:parameters progress:nil success:success failure:failure];
            break;
        case ENUM_REQUEST_POST:
            task = [[RequestInstance sharedInstance] POST:URLString parameters:parameters progress:nil success:success failure:failure];
            break;
        case ENUM_REQUEST_PATCH:
            task = [[RequestInstance sharedInstance] PATCH:URLString parameters:parameters  success:success failure:failure];
            break;
        case ENUM_REQUEST_DELETE:
            task = [[RequestInstance sharedInstance] DELETE:URLString parameters:parameters  success:success failure:failure];
            break;
        default:
            break;
    }
    
}


#pragma mark 拼接基础头字符串
+ (NSMutableDictionary *)setInitHead:(NSDictionary *)dicParameters  {
    if (dicParameters == nil){
        dicParameters = [NSDictionary dictionary];
    }
    NSMutableDictionary * muDic = [NSMutableDictionary dictionaryWithDictionary:dicParameters];
    for (NSString *strKey in dicParameters.allKeys) {
        if ([[dicParameters objectForKey:strKey] isEqual:[NSNull null]]) {
            [muDic removeObjectForKey: strKey];
        }
    }
    [muDic setObject:[GlobalData sharedInstance].GB_Key forKey:@"token"];
    [self fetchSystem:muDic];
    return muDic;
}

//转化参数
+ (NSString *)replaceParameter:(NSDictionary *)dicParameter url:(NSString *)URL{
    NSString * strReturn = [URL hasPrefix:@"http"]?URL:[NSString stringWithFormat:@"%@%@",URL_HEAD,URL];
    strReturn = [strReturn appendUrl:[GlobalData sharedInstance].GB_Key key:@"token"];
    for (NSString * strKey in dicParameter.allKeys) {
        if ([strReturn rangeOfString:[NSString stringWithFormat:@"{%@}",strKey]].location != NSNotFound) {
           strReturn = [strReturn stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}",strKey] withString:[NSString stringWithFormat:@"%@",dicParameter[strKey]]];
        }
    }
    return strReturn;
}



#pragma mark 拼接头数据
//拼接苹果系统数据
+ (void)fetchSystem:(NSMutableDictionary *)muDic{
    [[RequestInstance sharedInstance]configHeader];
}








@end

