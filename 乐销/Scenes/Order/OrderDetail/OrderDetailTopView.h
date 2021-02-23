//
//  OrderDetailTopView.h
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentStarView.h"
#import "PlaceHolderTextView.h"

@interface OrderDetailView : UIView
@property (nonatomic, strong) ModelTransportOrder *model;

- (void)resetViewWithModel:(ModelTransportOrder *)model;
@end




@interface OrderDetailTrackCell : UITableViewCell

@property (strong, nonatomic) UILabel *l;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIView *dot;
@property (strong, nonatomic) UIView *line;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelLocationItem *)model;

@end


@interface OrderDetailCommentView : UIView
@property (nonatomic, strong) CommentStarView *starView;
@property (nonatomic, strong) PlaceHolderTextView *textView;
@property (nonatomic, strong) UILabel *score;
@property (nonatomic, strong) void (^blockConfirm)(float,NSString *);

@property (nonatomic, strong) ModelTransportOrder *model;

- (void)resetViewWithModel:(ModelTransportOrder *)model;
@end

@interface OrderDetailCommentShowView : UIView
@property (nonatomic, strong) CommentStarView *starView;
@property (nonatomic, strong) UILabel *score;

@property (nonatomic, strong) ModelTransportOrder *model;

- (void)resetViewWithModel:(ModelTransportOrder *)model;
@end
