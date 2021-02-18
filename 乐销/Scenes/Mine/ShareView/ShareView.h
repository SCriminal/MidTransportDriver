//
//  ShareView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/23.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
@property (nonatomic, strong) ModelTransportOrder *modelOrder;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
+ (void)show:(ModelTransportOrder *)modelOrder;

@end
