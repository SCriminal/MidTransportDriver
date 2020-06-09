//
//  TakeAPictureView.m
//  自定义相机
//
//  Created by macbook on 16/9/2.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "TakeAPictureView.h"
#import <AVFoundation/AVFoundation.h>
// 为了导入系统相册
#import <AssetsLibrary/AssetsLibrary.h>

#import <Photos/Photos.h>
#import "UIImage+info.h"

@interface TakeAPictureView ()

@property (nonatomic, strong) AVCaptureSession *session;/**< 输入和输出设备之间的数据传递 */
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;/**< 输入设备 */
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;/**< 照片输出流 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;/**< 预览图片层 */
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect imageRect;
@end

@implementation TakeAPictureView

- (instancetype)initWithFrame:(CGRect)frame cameraType:(ENUM_CAMERA_TYPE)cameraType
{
    if (self = [super initWithFrame:frame]) {
        self.cameraType = cameraType;
        [self initAVCaptureSession];
        [self initCameraOverlayView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)startRunning
{
    if (self.session) {
        [self.session startRunning];
    }
}

- (void)stopRunning
{
    if (self.session) {
        [self.session stopRunning];
    }
}

- (void)initCameraOverlayView
{
    UIView * viewAll = [UIView new];
    viewAll.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    viewAll.backgroundColor = [UIColor lightGrayColor];
    viewAll.alpha = 0.5;
    [self addSubview:viewAll];
    
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT )];
    // - bezierPathByReversingPath ,反方向绘制path
    CGFloat width = W(298);
    CGFloat height = W(466);
    [bpath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH/2.0-width/2.0, SCREEN_HEIGHT/2.0-height/2.0, width, height) cornerRadius:W(20)] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    
    viewAll.layer.mask = shapeLayer;
    //    [viewAll.layer addSublayer:shapeLayer];
    
    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    NSString * imageName = nil;
    switch (self.cameraType) {
        case ENUM_CAMERA_IDENTITY_HEADER:
            imageName = @"camera_identity_head";
            break;
        case ENUM_CAMERA_IDENTITY_EMBLEM:
            imageName = @"camera_identity_emblem";
            break;
        case ENUM_CAMERA_DRIVING:
            imageName = @"camera_driving";
            break;
        case ENUM_CAMERA_ROAD:
            imageName = @"camera_road";
            break;
        default:
            break;
    }
    iv.image = [UIImage imageNamed:imageName];
    iv.widthHeight = XY(width,height);
    iv.centerXCenterY = XY(SCREEN_WIDTH/2.0,SCREEN_HEIGHT/2.0);
    [self addSubview:iv];
    self.imageRect = iv.frame;
    
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    leftBtn.frame = CGRectMake(0, STATUSBAR_HEIGHT, W(50), NAVIGATIONBAR_HEIGHT-STATUSBAR_HEIGHT);
    leftBtn.centerY = STATUSBAR_HEIGHT+(NAVIGATIONBAR_HEIGHT-STATUSBAR_HEIGHT) / 2;
    [leftBtn setImage:[UIImage imageNamed:@"camera_back"] forState:(UIControlStateNormal)];
    [leftBtn addTarget:self action:@selector(btnClickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:leftBtn];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.widthHeight = XY(W(55), W(55));
    btn.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - iphoneXBottomInterval - W(20));
    [btn setImage:[UIImage imageNamed:@"camera_action"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    
    
}

#pragma mark 按钮点击
- (void)btnClick{
    WEAKSELF
    [GlobalMethod fetchCameraAuthorityBlock:^{
        [weakSelf takeAPicture];
    }];
}
- (void)btnClickBack{
    if (self.blockBack) {
        self.blockBack();
    }else{
        [GB_Nav popViewControllerAnimated:true];
    }
}
- (void)initAVCaptureSession {
    self.session = [[AVCaptureSession alloc] init];
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    
    // 设置闪光灯自动
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    // 照片输出流
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    // 设置输出图片格式
    NSDictionary *outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    // 初始化预览层
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.previewLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.layer addSublayer:self.previewLayer];
    
}

// 获取设备方向

- (AVCaptureVideoOrientation)getOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft) {
        return AVCaptureVideoOrientationLandscapeRight;
    } else if ( deviceOrientation == UIDeviceOrientationLandscapeRight){
        return AVCaptureVideoOrientationLandscapeLeft;
    }
    return (AVCaptureVideoOrientation)deviceOrientation;
}

// 拍照
- (void)takeAPicture
{
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avOrientation = [self getOrientationForDeviceOrientation:curDeviceOrientation];
    [stillImageConnection setVideoOrientation:avOrientation];
    WEAKSELF
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage *image = [UIImage imageWithData:jpegData];
        
        image = [UIImage image:image scaleToSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        
        image = [UIImage imageFromImage:image inRect:weakSelf.imageRect];
        image = [self image:image rotation:UIImageOrientationLeft];

        self.getImage(image);
        
        // 写入相册
        if (self.shouldWriteToSavedPhotos) {
            [self writeToSavedPhotos];
        }
        
    }];
    
}

- (void)writeToSavedPhotos
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        NSLog(@"无权限访问相册");
        return;
    }
    
    // 首先判断权限
    if ([self haveAlbumAuthority]) {
        //写入相册
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
        
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"写入相册失败%@", error);
    } else {
        self.image = image;
        // 需要修改相册
        NSLog(@"写入相册成功");
    }
}

- (BOOL)haveAlbumAuthority
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
    
}

- (void)setFrontOrBackFacingCamera:(BOOL)isUsingFrontFacingCamera {
    AVCaptureDevicePosition desiredPosition;
    if (isUsingFrontFacingCamera){
        desiredPosition = AVCaptureDevicePositionBack;
    } else {
        desiredPosition = AVCaptureDevicePositionFront;
    }
    
    for (AVCaptureDevice *d in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if ([d position] == desiredPosition) {
            [self.previewLayer.session beginConfiguration];
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:d error:nil];
            for (AVCaptureInput *oldInput in self.previewLayer.session.inputs) {
                [[self.previewLayer session] removeInput:oldInput];
            }
            [self.previewLayer.session addInput:input];
            [self.previewLayer.session commitConfiguration];
            break;
        }
    }
    
}

-(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate =M_PI_2;
            rect =CGRectMake(0,0,image.size.height, image.size.width);
            translateX=0;
            translateY= -rect.size.width;
            scaleY =rect.size.width/rect.size.height;
            scaleX =rect.size.height/rect.size.width;
            break;
                case UIImageOrientationRight:
            rotate =3 *M_PI_2;
            rect =CGRectMake(0,0,image.size.height, image.size.width);
            translateX= -rect.size.height;
            translateY=0;
            scaleY =rect.size.width/rect.size.height;
            scaleX =rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate =M_PI;
            rect =CGRectMake(0,0,image.size.width, image.size.height);
            translateX= -rect.size.width;
            translateY= -rect.size.height;
            break;
                default:
            rotate =0.0;
            rect =CGRectMake(0,0,image.size.width, image.size.height);
            translateX=0;
            translateY=0;
            break;
            }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX,translateY);
    CGContextScaleCTM(context, scaleX,scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0,0,rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic =UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}
@end
