//
//  RequestInstance.m
//中车运
//
//  Created by 隋林栋 on 2016/12/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "RequestInstance.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation RequestInstance

+ (RequestInstance *)sharedInstance
{
    static RequestInstance * _instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RequestInstance alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.requestSerializer.timeoutInterval = TIME_REQUEST_OUT;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configHeader];
        });
        //ignore security
        self.securityPolicy.allowInvalidCertificates=YES;
        //是否在证书域字段中验证域名
        [self.securityPolicy setValidatesDomainName:NO];
    }
    return self;
}




//配置请求头
- (void)configHeader{
    static NSDictionary * dicConstant = nil;
    if (!dicConstant) {
        NSMutableDictionary * dicExt = [NSMutableDictionary dictionary];
        //ext
        CGFloat scale_screen = [UIScreen mainScreen].scale;
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        [dicExt setObject:[[UIDevice currentDevice] systemVersion] forKey:@"deploymentTarget"];
        [dicExt setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"uuid"];
        [dicExt setObject:[[UIDevice currentDevice] name] forKey:@"systemName"];
        [dicExt setObject:[[UIDevice currentDevice] systemVersion] forKey:@"systemVersion"];
        [dicExt setObject:NSNumber.lon(width) forKey:@"boundsWidth"];
        [dicExt setObject:NSNumber.lon(height) forKey:@"boundsHeight"];
        [dicExt setObject:[[CTTelephonyNetworkInfo alloc] init].subscriberCellularProvider.carrierName forKey:@"carrierName"];
        [dicExt setObject:NSNumber.lon(width*scale_screen) forKey:@"scaleWidth"];
        [dicExt setObject:NSNumber.lon(height*scale_screen) forKey:@"scaleHeight"];
        [dicExt setObject:NSNumber.lonFromStr([infoDictionary objectForKey:@"CFBundleVersion"]) forKey:@"build"];
        
        [dicExt setObject:[infoDictionary objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
        [dicExt setObject:[infoDictionary objectForKey:@"CFBundleDisplayName"] forKey:@"displayName"];
        [dicExt setObject:[infoDictionary objectForKey:@"CFBundleIdentifier"] forKey:@"bundleId"];
        [dicExt setObject:[[UIDevice currentDevice] model] forKey:@"iphoneModel"];
        dicConstant = [NSDictionary dictionaryWithDictionary:dicExt];
    }
    
    NSMutableDictionary * dicExt = [NSMutableDictionary dictionaryWithDictionary:dicConstant];
//location
    ModelAddress * modelAddressItem = [ModelAddress lastLocation];
    double lng = modelAddressItem.lng;
    double lat = modelAddressItem.lat;
    if (lng && lat) {
        [dicExt setObject:NSNumber.dou(lat) forKey:@"lat"];
        [dicExt setObject:NSNumber.dou(lng) forKey:@"lng"];
    }
    
    NSString * strExt  = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dicExt options:0 error:nil] encoding:NSUTF8StringEncoding ];
    
    NSString * agent = [NSString stringWithFormat:@"tlanx/%@(%@;iOS %@;Scale/%.2f)",[GlobalMethod getVersion],[GlobalMethod LookDeviceName],[UIDevice currentDevice].systemVersion,[UIScreen mainScreen].scale];
    [self.requestSerializer setValue:agent forHTTPHeaderField:@"User-Agent"];
    [self.requestSerializer setValue:@"4" forHTTPHeaderField:@"Source"];
    [self.requestSerializer setValue:[strExt base64Encode] forHTTPHeaderField:@"Ext"];

}
@end
