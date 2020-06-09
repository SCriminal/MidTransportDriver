//
//  TakeAPictureView.h
//  自定义相机
//
//  Created by macbook on 16/9/2.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ENUM_CAMERA_TYPE) {
    ENUM_CAMERA_DEFAULT,
    ENUM_CAMERA_IDENTITY_HEADER,
    ENUM_CAMERA_IDENTITY_EMBLEM,
    ENUM_CAMERA_DRIVING,
    ENUM_CAMERA_ROAD
};

@interface TakeAPictureView : UIView
@property (nonatomic, assign) ENUM_CAMERA_TYPE cameraType;
@property (nonatomic, strong) void (^blockBack)();

- (void)startRunning;
- (void)stopRunning;

// 拍照
- (void)takeAPicture;

// 切换前后镜头
- (void)setFrontOrBackFacingCamera:(BOOL)isUsingFrontFacingCamera;

// 写入本地
- (void)writeToSavedPhotos;

// 获取拍照后的图片
@property (nonatomic, copy) void (^getImage)(UIImage *image);

// 是否写入本地
@property (nonatomic, assign) BOOL shouldWriteToSavedPhotos;
- (instancetype)initWithFrame:(CGRect)frame cameraType:(ENUM_CAMERA_TYPE)cameraType;

@end
