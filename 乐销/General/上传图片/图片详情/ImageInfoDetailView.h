//
//  ImageInfoDetailView.h
//中车运
//
//  Created by 隋林栋 on 2017/3/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageInfoDetailView : UIView
@property (nonatomic, assign) CGFloat topInterval;//top interval default 0;
@property (nonatomic, assign) CGFloat bottomInterval;//top interval default 0;
@property (nonatomic, strong) NSArray  *aryModels;

- (void)resetView:(NSArray *)ary;
@end
