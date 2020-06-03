//
//  UIScrollView+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/8/15.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIScrollView+Category.h"


@implementation UIScrollView (Category)

//scroll did scroll block with linkSC
- (void)scrollLink:(LinkScrollView*)linkSC{
    if (self.contentOffset.y <= 0) {
        if ([linkSC isKindOfClass:[LinkScrollView class]]) {
            if (linkSC.contentOffset.y > 0) {
                linkSC.contentOffset = CGPointMake(linkSC.contentOffset.x, linkSC.contentOffset.y + self.contentOffset.y);
                self.contentOffset = CGPointMake(self.contentOffset.x, 0);
            }else{
                linkSC.contentOffset = CGPointMake(linkSC.contentOffset.x, 0);
            }
        }
    } else {
        //shang
        if ([linkSC isKindOfClass:[LinkScrollView class]]) {
            if (linkSC.contentOffset.y < linkSC.sizeHeight) {
                linkSC.contentOffset = CGPointMake(linkSC.contentOffset.x, linkSC.contentOffset.y + self.contentOffset.y);
                self.contentOffset = CGPointMake(self.contentOffset.x, 0);
                if (linkSC.contentOffset.y > linkSC.sizeHeight) {
                    linkSC.contentOffset = CGPointMake(linkSC.contentOffset.x, ceilf(linkSC.sizeHeight));
                }
            }
        }
    }
}

//scroll to bottom
- (void)scrollToBottom:(BOOL)animated
{
    if (self.contentSize.height + self.contentInset.bottom > self.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
        [self setContentOffset:offset animated:animated];
    }
}
@end
