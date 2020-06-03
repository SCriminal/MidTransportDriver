//
//  UIScrollView+Category.h
//中车运
//
//  Created by 隋林栋 on 2017/8/15.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//link sc
#import "LinkScrollView.h"

@interface UIScrollView (Category)

//scroll did scroll block with linkSC
- (void)scrollLink:(LinkScrollView*)linkSC;

//scroll to bottom
- (void)scrollToBottom:(BOOL)animated;
@end
