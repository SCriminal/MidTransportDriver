//
//  AliClient.h
//中车运
//
//  Created by 隋林栋 on 2016/12/26.
//  Copyright © 2016年 ping. All rights reserved.
//


#import <Foundation/Foundation.h>
//ali
#import <AliyunOSSiOS/OSSService.h>


typedef NS_ENUM(NSUInteger, ENUM_UP_IMAGE_TYPE) {
    ENUM_UP_IMAGE_TYPE_USER_LOGO,
    ENUM_UP_IMAGE_TYPE_USER_AUTHORITY,
    ENUM_UP_IMAGE_TYPE_COMPANY_LOGO,
    ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY,
    ENUM_UP_IMAGE_TYPE_COMPANY_CAR,
    ENUM_UP_IMAGE_TYPE_ORDER,
    ENUM_UP_IMAGE_TYPE_DOWNLOAD
};

@interface AliClient : NSObject

DECLARE_SINGLETON(AliClient)

@property (nonatomic, assign) ENUM_UP_IMAGE_TYPE imageType;
@property (nonatomic, readonly) NSString *imagePath;

#pragma mark 上传多张
- (void)updateImageAry:(NSArray *)aryDatas
        storageSuccess:(void(^)(void))storageSuccess
             upSuccess:(void(^)(void))upSuccess
                  fail:(void(^)(void))fail;



@end
