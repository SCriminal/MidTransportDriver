//
//  HotLineView.h
//中车运
//
//  Created by 隋林栋 on 2018/10/18.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotLineView : UIView
//属性
@property (strong, nonatomic) UILabel *serviceNumber;
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
