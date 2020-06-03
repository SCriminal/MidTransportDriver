//
//  BaseTableVC+Authority.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//  Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"
//cell
#import "PerfectSelectCell.h"
#import "PerfectTextCell.h"
#import "PerfectAddressDetailCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ENUM_PERFECT_CELL_TYPE) {
    ENUM_PERFECT_CELL_TEXT,
    ENUM_PERFECT_CELL_SELECT,
    ENUM_PERFECT_CELL_ADDRESS,
    ENUM_PERFECT_CELL_EMPTY
};

@interface BaseTableVC (Authority)

- (void)registAuthorityCell;
- (UITableViewCell *)dequeueAuthorityCell:(NSIndexPath *)indexPath;
- (CGFloat)fetchAuthorityCellHeight:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
