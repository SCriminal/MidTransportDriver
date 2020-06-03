//
//  ListAlertView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/19.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListAlertView : UIView<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *ivBG;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) void (^blockSelected)(NSInteger);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)showWithPoint:(CGPoint)point width:(CGFloat)width ary:(NSArray *)ary;

@end



@interface ListAlertCell : UITableViewCell

@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIView *line;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
