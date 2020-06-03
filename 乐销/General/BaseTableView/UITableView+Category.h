//
//  UITableView+Category.h
//中车运
//
//  Created by 隋林栋 on 2017/1/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Category)

//添加属性
@property (nonatomic, strong) void (^blockReloadData)(void);
@property (nonatomic, strong) NSArray *tableHeaderViews;
@property (nonatomic, strong) NSArray *tableFooterViews;


/**
 refreh cell height
 @param heightChange, height should change; if don't transport,subtract string will get a bug
 */
- (void)reloadCellHeight:(CGFloat)heightChange;

/**
 should hide line with the index path
 @return hide line
 */
- (BOOL)isLastCellWithoutLastSection:(NSIndexPath *)indexPath;
- (BOOL)isLastCellInSection:(NSIndexPath *)indexPath;
@end
