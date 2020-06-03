//
//  GlobalMethod+Authority.m
//中车运
//
//  Created by 隋林栋 on 2017/6/16.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod+Authority.h"
//照相机权限
#import <Photos/Photos.h>
//通讯录
#import <AddressBook/AddressBook.h>
//获取运营商
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//短息功能
#import <MessageUI/MessageUI.h>

@implementation GlobalMethod (Authority)

//获取照相机权限
+ (void)fetchCameraAuthorityBlock:(void (^)(void))block{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //设备没有照相机
        return;
    }
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized://agree
        {
            if (block) {
                block();
            }
        }
            break;
        case AVAuthorizationStatusDenied://disagree
        {
            //弹窗提示
            [GlobalMethod showAlertOpenAuthority:AUTHORITY_CAMERA];
        }
            break;
        case AVAuthorizationStatusNotDetermined://undetermined
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
                [GlobalMethod mainQueueBlock:^{
                    if (granted) {
                        if (block) {
                            block();
                        }
                    }else{
                        //弹窗提示
                        [GlobalMethod showAlertOpenAuthority:AUTHORITY_CAMERA];
                    }
                }];
            }];
        }
            break;
        default:
            break;
    }

}

//获取相册权限
+ (void)fetchPhotoAuthorityBlock:(void (^)(void))block{
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //设备没有相册
        return;
    }
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    switch (authStatus) {
        case PHAuthorizationStatusAuthorized://agree
        {
            if (block) {
                block();
            }
        }
            break;
        case PHAuthorizationStatusDenied://disagree
        {
            //弹窗提示
            [GlobalMethod showAlertOpenAuthority:AUTHORITY_PHOTO];
        }
            break;
        case PHAuthorizationStatusNotDetermined://undetermined
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [GlobalMethod mainQueueBlock:^{
                    if (status == PHAuthorizationStatusAuthorized) {
                        if (block) {
                            block();
                        }
                    }else {
                        //弹窗提示
                        [GlobalMethod showAlertOpenAuthority:AUTHORITY_PHOTO];
                    }
                }];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 通讯录
+ (void)fetchAddressBookAuthorityBlock:(void (^)(void))block {
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus == kABAuthorizationStatusNotDetermined) {
        __block ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        if (addressBook == NULL) {
            //设备没有通讯录功能
            return;
        }
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            [GlobalMethod mainQueueBlock:^{
                if (granted) {//允许
                    if (block) {
                        block();
                    }
                } else {
                    [self showAlertOpenAuthority:AUTHORITY_ADDRESSBOOK];
                }
                if (addressBook) {
                    CFRelease(addressBook);
                    addressBook = NULL;
                }
            }];
        });
        return;
    } else if (authStatus == kABAuthorizationStatusAuthorized) {
        if (block) {
            block();
        }
    } else if (authStatus == kABAuthorizationStatusDenied) {
        [self showAlertOpenAuthority:AUTHORITY_ADDRESSBOOK];
    } else if (authStatus == kABAuthorizationStatusRestricted) {
        [self showAlertOpenAuthority:AUTHORITY_ADDRESSBOOK];
    }
}


#pragma mark - 麦克风
+ (void)fetchMicAuthorityBlock:(void (^)(void))block{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启麦克风
        {
            AVAudioSession *avSession = [AVAudioSession sharedInstance];
            
            if ([avSession respondsToSelector:@selector(requestRecordPermission:)]) {
                
                [avSession requestRecordPermission:^(BOOL available) {
                    [GlobalMethod mainQueueBlock:^{
                        if (available) {
                            if (block) {
                                block();
                            }
                        }else {
                            //弹窗提示
                            [GlobalMethod showAlertOpenAuthority:AUTHORITY_MIC];
                        }
                    }];
                }];
                
            }
            
        }
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
        case AVAuthorizationStatusDenied:
            //玩家未授权
        {
            
            [GlobalMethod showAlertOpenAuthority:AUTHORITY_MIC];
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            //玩家授权
            if (block) {
                block();
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - 定位
+ (BOOL)fetchLocalAuthorityBlock:(void (^)(void))block{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        [GlobalMethod showAlertOpenAuthority:AUTHORITY_LOCAL];
        return false;
    }else//开启的
    {
        if (block) {
            block();
        }
        return true;
    }
    
}


+ (void)showAlertOpenAuthority:(AUTHORITY_TYPE)type{
    ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
    modelDismiss.blockClick = ^(void){
        
    };
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    modelConfirm.blockClick = ^(void){
        NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:settingUrl]) {
            [[UIApplication sharedApplication] openURL:settingUrl];
        }
    };
    NSString * strTitle = @"";
    switch (type) {
        case AUTHORITY_PHOTO:
        {
            strTitle = @"相册功能";
        }
            break;
        case AUTHORITY_CAMERA:
        {
            strTitle = @"照相机功能";
        }
            break;
        case AUTHORITY_LOCAL:
        {
            strTitle = @"定位功能";
        }
            break;
        case AUTHORITY_ADDRESSBOOK:
        {
            strTitle = @"通讯录功能";
        }
            break;
        default:
            break;
    }
    [GlobalMethod mainQueueBlock:^{
        [BaseAlertView initWithTitle:[NSString stringWithFormat:@"请前往设置打开%@",UnPackStr(strTitle)] content:[NSString stringWithFormat:@"不打开将无法使用%@",UnPackStr(strTitle)] aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
    }];
    
    
}

/**
 调用电话功能
 
 @param ViewController 调用类
 @param phoneStr 电话号码
 */
+(void)gotoCallPhoneClick:(UIViewController *)ViewController  phone:(NSString *)phoneStr{
    if (!isStr(phoneStr)) {
        return;
    }
    NSDictionary * sourceDic = @{@"VC":ViewController,
                                 @"phone":phoneStr};
    [self cancelTapGestureAction:sourceDic];
}

+(void)gotoMessageClick:(UIViewController *)ViewController  phone:(NSString *)phoneStr{
    if (!isStr(phoneStr)) {
        return;
    }
    NSDictionary * sourceDic = @{@"VC":ViewController,
                                 @"phone":phoneStr};
    [self cancelMesTapGestureAction:sourceDic];
}

+(void)cancelTapGestureAction:(id)sourceDic{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(gotoTelClick:) object:sourceDic];
    [self performSelector:@selector(gotoTelClick:) withObject:sourceDic afterDelay:0.5f];
    
}

+(void)cancelMesTapGestureAction:(id)sourceDic{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(gotoMessageClick:) object:sourceDic];
    [self performSelector:@selector(gotoMessageClick:) withObject:sourceDic afterDelay:0.5f];
    
}
//调用系统电话功能
+(void)gotoTelClick:(id)sourceDic{
    NSString *callPhone = [NSString stringWithFormat:@"tel://%@" ,sourceDic[@"phone"]];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    UIApplication * application = [UIApplication sharedApplication];
    if ([application canOpenURL:[NSURL URLWithString:callPhone]]) {
        if (compare == NSOrderedAscending || compare == NSOrderedSame) {
            /// 大于等于10.0系统使用此openURL方法
            [application openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [application openURL:[NSURL URLWithString:callPhone]];
        }
    }
}

+(void)gotoMessageClick:(id)sourceDic{
     NSString *callPhone = [NSString stringWithFormat:@"sms://%@" ,sourceDic[@"phone"]];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    UIApplication * application = [UIApplication sharedApplication];
    if ([application canOpenURL:[NSURL URLWithString:callPhone]]) {
        if (compare == NSOrderedAscending || compare == NSOrderedSame) {
            /// 大于等于10.0系统使用此openURL方法
            [application openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [application openURL:[NSURL URLWithString:callPhone]];
        }
    }
    
}

////发短信
//-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
//{
//    if( [MFMessageComposeViewController canSendText] )
//    {
//        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
//        controller.recipients = phones;
//        controller.navigationBar.tintColor = [UIColor redColor];
//        controller.body = body;
//        controller.messageComposeDelegate = self;
//        [self presentViewController:controller animated:YES completion:nil];
//        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
//                                                        message:@"该设备不支持短信功能"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}



/**
 获取设备唯一信息 包括 UUID系统(逻辑)  运营商 版本号  系统名
 */
+ (NSString *)fetchDeviceID{
    ///UUID
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSString * strUUID = (NSString *)[self load:bundleID];
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        NSString * UUID = [[UIDevice currentDevice] identifierForVendor].UUIDString;
        //将该uuid保存到keychain
        [self save:bundleID data:UUID];
    }
    
    ///获取运营商
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [info subscriberCellularProvider];
//    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
//    NSLog(@"运营商：%@",mCarrier);
    
    // 获取设备所有者的名称——"My iPhone"
//    NSString * Devicename = [[UIDevice currentDevice] name];
//    NSLog(@"获取设备所有者的名称：%@",Devicename);



    // 获取当前运行的系统名称——@"iOS"
//    NSString * systemName = [[UIDevice currentDevice] systemName];
//    NSLog(@"获取当前运行的系统名称：%@",systemName);

    // 获取当前系统的版本——@"10.0"、@"11.3.1"
//    NSString * systemVersion = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"获取当前系统的版本：%@",systemVersion);

    return strUUID;
}
+ (NSString *)deviceName{
    // 获取设备的型号——@"iPhone"
    NSString * version = [[UIDevice currentDevice] model];
    NSLog(@"获取设备的型号：%@",version);
    return version;
}
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,service, (id)kSecAttrService,service, (id)kSecAttrAccount,(id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,nil];
}
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}
@end

