//
//  DownListView.h
//中车运
//
//  Created by 隋林栋 on 2016/12/23.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownListView : UIView

//- (instancetype)initWithAry:(NSArray *)ary target:(id)traget;
- (void)resetWithAry:(NSArray *)ary target:(id)target;
@end

@interface DownListViewControl : UIControl
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *imageHead;
@property (strong, nonatomic) UIView *viewLine;

#pragma mark 创建
+ (instancetype)initWithModel:(id)model frame:(CGRect)rect tag:(int)tag;
- (void)resetWithModel:(id)model frame:(CGRect)rect tag:(int)tag;

@end
