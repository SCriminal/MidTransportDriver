//
//  PerfectAddressDetailCell.h
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//textView
#import "PlaceHolderTextView.h"

@interface PerfectAddressDetailCell : UITableViewCell
//属性
@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) PlaceHolderTextView *textView;
@property (strong, nonatomic) ModelBaseData *model;
@property (nonatomic, strong) void (^blockHeightChange)();

#pragma mark 刷新view
- (void)resetCellWithModel:(ModelBaseData *)model;

@end

