//
//  MarQueueView.h
//中车运
//
//  Created by 隋林栋 on 2018/6/18.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarQueueView : UIView

@property (nonatomic, strong) UILabel *labelTitle;

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title;

@end
