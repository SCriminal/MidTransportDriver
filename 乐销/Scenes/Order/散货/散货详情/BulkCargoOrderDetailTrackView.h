//
//  BulkCargoOrderDetailTrackView.h
//  Driver
//
//  Created by 隋林栋 on 2020/7/31.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BulkCargoOrderDetailTrackView : UIView
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) void (^blockReqeustTrack)(NSMutableArray *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTransportOrder *)model;

@end
