//
//  CommentStarView.h
//中车运
//
//  Created by 隋林栋 on 2017/9/2.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentStarView : UIControl

/**
 if show gray star bg, the width is fixed;
 */
@property (nonatomic, assign) BOOL isShowGrayStarBg;

/**
 score current
 */
@property (nonatomic, assign) CGFloat currentScore;
/**
 interval
 */
@property (nonatomic, assign) CGFloat interval;
//添加subview
- (void)configDefaultView;

@end

@interface CommentStarItemView : UIView

@property (nonatomic, strong) UIImageView *ivStar;

@end

