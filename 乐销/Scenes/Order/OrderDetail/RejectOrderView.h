//
//  RejectOrderView.h
//  Driver
//
//  Created by 隋林栋 on 2020/12/9.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RejectOrderView : UIView
@property (nonatomic, strong) void (^blockConfirm)(NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTransportOrder *)model;

@end
