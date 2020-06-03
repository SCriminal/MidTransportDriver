//
//  QRCoderVC.h
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/6/20.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "BaseVC.h"
#import <AVFoundation/AVFoundation.h>

@class QRCoderVC;
@protocol CustomViewControllerDelegate <NSObject>

@optional
- (void)customViewController:(QRCoderVC *)controller didScanResult:(NSString *)result;

- (void)customViewControllerDidCancel:(QRCoderVC *)controller;

@end

@interface QRCoderVC : BaseVC<UIAlertViewDelegate, AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) id<CustomViewControllerDelegate> delegate;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, assign) BOOL isScanning;

/**
 *  开始二维码扫描
 */
- (void)startScan;
@end
