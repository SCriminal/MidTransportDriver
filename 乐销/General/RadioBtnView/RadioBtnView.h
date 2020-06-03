//
//  RadioBtnView.h
//中车运
//
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RadioBtnView : UIView
@property (nonatomic, strong) NSArray * aryModels;
@property (nonatomic, strong) void (^blockSelectIndex)(NSInteger index);
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger  lineNum;
@property (nonatomic, assign) CGFloat widthLimit;//default screenwidth
//创建
- (void)resetWithAry:(NSArray *)ary;

@end

@interface RadioBtnViewControl : UIControl

@property (nonatomic, strong) UIImageView *imageViewDiot;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImage *imageDefault;
@property (nonatomic, strong) UIImage *imageSelect;
//创建
+ (instancetype)initWithTitle:(NSString *)title
                          tag:(int)tag;
- (void)resetWithTitle:(NSString *)title
                   tag:(int)tag;

@end

