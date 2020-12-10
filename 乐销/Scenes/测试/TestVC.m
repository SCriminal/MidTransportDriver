//
//  TestVC.m
//  中车运
//
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "TestVC.h"
#import "BaseNavView+Logical.h"
#import "BaseVC+BaseImageSelectVC.h"
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
#import "ShareView.h"
#import "TopAlertView.h"
#import "PerfectAuthorityInfoVC.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
//
#import "RequestApi+Location.h"
//import request
#import "RequestApi+UserApi.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "WithdrawInputView.h"

@interface TestVC ()<UIWebViewDelegate,NSURLSessionDelegate> 

@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) UILabel *labelShow;

@end

@implementation TestVC

- (UIWebView *)web{
    if (!_web) {
        _web = [UIWebView new];
        _web.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _web.delegate = self;
    }
    return _web;
}
- (UILabel *)labelShow{
    if (!_labelShow) {
        _labelShow = [UILabel new];
        _labelShow.fontNum = F(16);
        _labelShow.textColor = [UIColor blackColor];
        _labelShow.backgroundColor = [UIColor whiteColor];
        _labelShow.numberOfLines = 0;
        _labelShow.backgroundColor = [UIColor redColor];
        [_labelShow fitTitle:@"test" variable:0];
    }
    return _labelShow;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF
    //config nav
    BaseNavView * nav =[BaseNavView initNavBackTitle:@"测试" rightTitle:@"FlashLogin" rightBlock:^{
        [weakSelf.view endEditing:true];
        [weakSelf jump];
    }];
    [self.view addSubview:nav];
    [self.view addSubview:self.labelShow];
    self.labelShow.leftTop = XY(0, NAVIGATIONBAR_HEIGHT);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(datarefresh) name:NOTICE_LOCATION_CHANGE object:nil];
    
    [CLShanYanSDKManager preGetPhonenumber];
    return;
}

- (void)datarefresh{
    NSArray * aryGlobal = [GlobalData sharedInstance].aryLocations.copy;
    NSMutableString * strTest = [NSMutableString new];
    for (ModelAddress * item in aryGlobal) {
        [strTest appendString:[NSString stringWithFormat:@"-%@-",NSNumber.dou(item.spd)]];
    }
    [self.labelShow fitTitle:strTest variable:SCREEN_WIDTH];
}
// 快捷登录
- (void)quickLoginBtnClick {
    
    //耗时开始计时
    CFAbsoluteTime startButtonClick  = CFAbsoluteTimeGetCurrent();
    
//    [sender setEnabled:NO];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [sender setEnabled:YES];
//    });
    
    //电信定制界面
    CLCTCCUIConfigure * ctccUIConfigure = [CLCTCCUIConfigure new];
    ctccUIConfigure.viewController = self;
    
    //移动定制界面
    CLCMCCUIConfigure * cmccUIConfigure = [CLCMCCUIConfigure new];
    cmccUIConfigure.viewController = self;
    
    //联通定制界面
    CLCUCCUIConfigure * cuccUIConfigure = [CLCUCCUIConfigure new];
    cuccUIConfigure.viewController = self;
    
//    [SVProgressHUD setContainerView:self.view];
//    [SVProgressHUD show];
    
    [CLShanYanSDKManager quickAuthLoginWithConfigureCTCC:ctccUIConfigure CMCC:cmccUIConfigure CUCC:cuccUIConfigure timeOut:4 complete:^(CLCompleteResult * _Nonnull completeResult) {
        
//        [SVProgressHUD dismiss];
        
        if (completeResult.error) {
            
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            
            if (completeResult.code == 1011){
                //用户取消登录（点返回）
                //处理建议：如无特殊需求可不做处理，仅作为交互状态回调，此时已经回到当前用户自己的页面
//                [SVProgressHUD showInfoWithStatus: @"用户取消免密登录"];
                [GlobalMethod mainQueueBlock:^{
                    [GlobalMethod showAlert:@"用户取消免密登录"];
                }];
            }else{
                //处理建议：其他错误代码表示闪验通道无法继续，可以统一走开发者自己的其他登录方式，也可以对不同的错误单独处理
                //1003    一键登录获取token失败
                //1008    未开启移动网络
                //1009    未检测到sim卡
                //其他     其他错误//
                
                dispatch_async(dispatch_get_main_queue(), ^{
//                    LoginResultController 1rr*vc = [LoginResultController new];
//                    vc.error = completeResult.error;
//                    [self.navigationController pushViewController:vc animated:YES];
//                    NSLog(@"%@",completeResult.error);
                    [GlobalMethod showAlert:@"登录失败"];

                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"quickAuthLogin Success:%@",completeResult.data);
                [GlobalMethod showAlert:@"登录成功"];
//                LoginResultController *vc = [LoginResultController new];
//                vc.completeResultData = completeResult.data;
//                vc.timesStart = startButtonClick;
//                if(self.navigationController){
//                    [self.navigationController pushViewController:vc animated:YES];
//                } else {
//                    [self presentViewController:vc animated:YES completion:^{
//
//                    }];
//                }
            });
        }
    }];
}
//授权页 点击自定义控件绑定的方法
-(void)otherLoginWayBtnCliced:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        //建议使用授权页面配置对象传入的viewcontroller 调 dismiss
        if (self.navigationController.viewControllers.lastObject.navigationController) {
            [self.navigationController.viewControllers.lastObject dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
            // 在这里加一个这个样式的循环
            while (topRootViewController.presentedViewController) {
                // 这里固定写法
                topRootViewController = topRootViewController.presentedViewController;
            }
            // 然后再进行present操作
            [topRootViewController dismissViewControllerAnimated:YES completion:nil];
        }
    });
    [GlobalMethod showAlert:@"用户使用其他方式进行注册登录"];
}



//选择图片
/**
 

 @param imagee
 */
- (void)imageSelect:(BaseImage *)image{
   
   
}
- (void)orc:(NSString *)imageurl{
//    [GB_Nav pushVCName:@"MainBlackVC" animated:true];
    NSString *appcode = @"255fbb9b4d9742c7ae263c4b2dc42e3b";
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
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       NSDictionary * dic = [GlobalMethod exchangeStringToDic:bodyString];
                                                       NSArray * aryAll = [dic arrayValueForKey:@"prism_wordsInfo"];
                                                       NSMutableString * strReturn = [[NSMutableString alloc]init];
                                                       for (NSDictionary * dic in aryAll) {
                                                           [strReturn appendFormat:@"%@\n",[dic stringValueForKey:@"word"]];
                                                       }
                                                       //打印应答中的body
                                                       NSLog(@"Response body: %@" , bodyString);
                                                       [GlobalMethod mainQueueBlock:^{
                                                           [self.labelShow fitTitle:strReturn variable:SCREEN_WIDTH];
                                                           
                                                       }];
                                                   }];
    [task resume];
    
}
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}
- (void)analyseDate{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"TestDate" ofType:@".json"];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithContentsOfFile:strPath] options:NSJSONReadingMutableContainers error:nil];

}
/*
 [{
 reg: /^(620200|620302|620402|620403|620404|620406|620407|620409|620410|620411|620412|620502|620503|620405|620408|620512|620602|620604|620607|620611|620612|620704|620706|620707|620708|620709|620710|620609|620712|620713|620714|620802|620711|620904|620905|621001|620902|621103|621105|621106|621107|621102|621203|621204|621205|621206|621207|621208|621209|621210|621302|621303|621202|621305|621306|621307|621309|621311|621313|621211|621315|621304|621402|621404|621405|621406|621407|621408|621409|621410|621502|621317|621511|621602|621603|621604|621605|621608|621609|621610|621611|621612|621613|621614|621615|621616|621617|621607|621606|621804|621807|621813|621814|621817|621901|621904|621905|621906|621907|621908|621909|621910|621911|621912|621913|621915|622002|621903|622004|622005|622006|622007|622008|622010|622011|622012|621914|622015|622016|622003|622018|622019|622020|622102|622103|622104|622105|622013|622111|622114|622017|622110|622303|622304|622305|622306|622307|622308|622309|622314|622315|622317|622302|622402|622403|622404|622313|622504|622505|622509|622513|622517|622502|622604|622605|622606|622510|622703|622715|622806|622902|622903|622706|623002|623006|623008|623011|623012|622904|623015|623100|623202|623301|623400|623500|623602|623803|623901|623014|624100|624200|624301|624402|623700|624000)\d{12}$/g,
 cardType: "DC"
 }, {
 reg: /^(622200|622202|622203|622208|621225|620058|621281|900000|621558|621559|621722|621723|620086|621226|621618|620516|621227|621288|621721|900010|623062|621670|621720|621379|621240|621724|621762|621414|621375|622926|622927|622928|622929|622930|622931|621733|621732|621372|621369|621763)\d{13}$/g,
 cardType: "DC"
 }, {
 reg: /^(402791|427028|427038|548259|621376|621423|621428|621434|621761|621749|621300|621378|622944|622949|621371|621730|621734|621433|621370|621764|621464|621765|621750|621377|621367|621374|621731|621781)\d{10}$/g,
 cardType: "DC"
 }, {
 reg: /^(9558)\d{15}$/g,
 cardType: "DC"
 }, {
 reg: /^(370246|370248|370249|370247|370267|374738|374739)\d{9}$/g,
 cardType: "CC"
 }, {
 reg: /^(427010|427018|427019|427020|427029|427030|427039|438125|438126|451804|451810|451811|458071|489734|489735|489736|510529|427062|524091|427064|530970|530990|558360|524047|525498|622230|622231|622232|622233|622234|622235|622237|622239|622240|622245|622238|451804|451810|451811|458071|628288|628286|622206|526836|513685|543098|458441|622246|544210|548943|356879|356880|356881|356882|528856|625330|625331|625332|622236|524374|550213|625929|625927|625939|625987|625930|625114|622159|625021|625022|625932|622889|625900|625915|625916|622171|625931|625113|625928|625914|625986|625925|625921|625926|625942|622158|625917|625922|625934|625933|625920|625924|625017|625018|625019)\d{10}$/g,
 cardType: "CC"
 }, {
 reg: /^(45806|53098|45806|53098)\d{11}$/g,
 cardType: "CC"
 }, {
 reg: /^(622210|622211|622212|622213|622214|622220|622223|622225|622229|622215|622224)\d{10}$/g,
 cardType: "SCC"
 }, {
 reg: /^(620054|620142|620184|620030|620050|620143|620149|620124|620183|620094|620186|620148|620185)\d{10}$/g,
 cardType: "PC"
 }, {
 reg: /^(620114|620187|620046)\d{13}$/g,
 cardType: "PC"
 }]
 */
#pragma mark nav right click
- (void)judgeBank{
        NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"^(622200|622202|622203|622208|621225|620058|621281|900000|621558|621559|621722|621723|620086|621226|621618|620516|621227|621288|621721|900010|623062|621670|621720|621379|621240|621724|621762|621414|621375|622926|622927|622928|622929|622930|622931|621733|621732|621372|621369|621763)\\d{13}$" options:0 error:&error];
    if (error) {
        NSLog(@"error%@",error);
    }
    NSString * contentStr = @"6212261607005709341";
    NSArray *results = [regex matchesInString:contentStr options:0 range:NSMakeRange(0, contentStr.length)];
    NSLog(@"true");
}
- (void)jump{
    WithdrawInputView * view = [WithdrawInputView new];
    [view resetViewWithModel:nil];
    [self.view addSubview:view];
}

- (void)addVersion{
//    [RequestApi requestAddVersionWithForceUpdate:false versionNumber:@"1.53" description:@"1.优化轨迹获取逻辑；\n2.设置中增加版本号显示\n" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        NSLog(@"success");
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//    }];
}

@end



