//
//  UpImageView.h
//  乐销
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

//需要判断是否有点击事件
@class Collection_Image;
@class AddFileView;
@interface UpImageView : UIView
@property (nonatomic, strong) UIControl *upImageBG;
@property (nonatomic, strong) UIImageView *upImageHead;
@property (nonatomic, strong) UILabel *upImageLabel;
@property (nonatomic, strong) Collection_Image *collection_Image;

@property (nonatomic, assign) BOOL isNotShowUpImageView;
@property (nonatomic, assign) BOOL isNotShowUpImageTopView;
@property (nonatomic, assign) BOOL isHiddenCollectionNoData;//无数据时隐藏collection
@property (nonatomic, strong) void (^blockResetView)(void);
//创建
- (NSString *)fetchRequestImgString;
- (NSString *)fetchRequestFileString;
//addSubView
- (void)addSubview;
//refresh
- (void)resetView;
//show image
- (void)showImage;
@end
