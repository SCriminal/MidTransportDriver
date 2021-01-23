//
//  OrderDetailTopView.h
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailView : UIView
@property (nonatomic, strong) ModelTransportOrder *model;

- (void)resetViewWithModel:(ModelTransportOrder *)model;
@end


@interface OrderDetailTrailView : UIView
@property (nonatomic, strong) ModelTransportOrder *model;

- (void)resetViewWithModel:(ModelTransportOrder *)model;
@end

