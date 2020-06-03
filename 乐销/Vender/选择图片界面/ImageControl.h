//
//  ImageControl.h
//中车运
//
//  Created by 隋林栋 on 2017/1/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageControl : UIControl
@property (strong, nonatomic) UIImageView *imageIcon;

#pragma mark 创建
+ (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName heightImageName:(NSString *)heightImagName imageFrame:(CGRect)imageFrame tag:(NSInteger)tag;
- (void)resetWithFrame:(CGRect)frame imageName:(NSString *)imageName heightImageName:(NSString *)heightImagName imageFrame:(CGRect)imageFrame tag:(NSInteger)tag;

- (void)resetFrame:(CGRect)frame imageFrame:(CGRect)imageFrame;
@end
