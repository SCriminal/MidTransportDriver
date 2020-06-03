//
//  UITableView+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/1/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UITableView+Category.h"
//runtime
#import <objc/runtime.h>
static const char blockReloadDataKey = '\0';

@implementation UITableView (Category)

- (void)setTableHeaderViews:(NSArray *)tableHeaderViews{
    if (isAry(tableHeaderViews)) {
        self.tableHeaderView = [UIView initWithViews:tableHeaderViews];
    }
}

- (NSArray *)tableHeaderViews{
    return self.tableHeaderView.subviews;
}

- (void)setTableFooterViews:(NSArray *)tableFooterViews{
    if (isAry(tableFooterViews)) {
        self.tableFooterView = [UIView initWithViews:tableFooterViews];
    }
}
- (NSArray *)tableFooterViews{
    return self.tableFooterView.subviews;
}


#pragma mark 运行时
-(void)setBlockReloadData:(void (^)(void))blockReloadData
{
    objc_setAssociatedObject(self, &blockReloadDataKey, blockReloadData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(void))blockReloadData
{
    void (^block)(void) = objc_getAssociatedObject(self, &blockReloadDataKey);
    return block;
}


#pragma mark refresh
+ (void)load
{
     method_exchangeImplementations(class_getInstanceMethod(self,@selector(reloadData)), class_getInstanceMethod(self,@selector(sld_reloadData)));
    

}

- (void)sld_reloadData{
    if (self.blockReloadData != nil) {
        self.blockReloadData();
    }
    [self sld_reloadData];
}


#pragma mark refreh cell height
/**
 refreh cell height
 @param heightChange, height should change; if don't transport,subtract string caton
 */
- (void)reloadCellHeight:(CGFloat)heightChange{
    CGPoint contentOffSetOrigin = self.contentOffset;
    CGSize contentSizeOrigin = self.contentSize;
    UIEdgeInsets contentInsetOrigin = self.contentInset;
    if (heightChange>0) {
        if (contentOffSetOrigin.y > contentSizeOrigin.height -  self.height) {
            CGFloat insizeBottom = self.height - ( contentSizeOrigin.height -contentOffSetOrigin.y );
            self.contentInset = UIEdgeInsetsMake(contentInsetOrigin.top, contentInsetOrigin.left,  insizeBottom, contentInsetOrigin.right);
        }
    }else{
        //calculate contentinset after reload
        if (contentOffSetOrigin.y > contentSizeOrigin.height -  self.height) {
            CGFloat insizeBottom = self.height - ( contentSizeOrigin.height -contentOffSetOrigin.y ) - heightChange;
            self.contentInset = UIEdgeInsetsMake(contentInsetOrigin.top, contentInsetOrigin.left,  insizeBottom, contentInsetOrigin.right);
        }
    }
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        self.contentInset = contentInsetOrigin;
        self.contentOffset = contentOffSetOrigin;
    }];
    [self beginUpdates];
    [self endUpdates];
    [CATransaction commit];
}

/**
 should hide line with the index path
 @return hide line
 */
- (BOOL)isLastCellWithoutLastSection:(NSIndexPath *)indexPath{
    // only not last section and the last cell of section
    if (indexPath.section < self.numberOfSections-1 && [self isLastCellInSection:indexPath] ) {
        return true;
    }
    return false;
}
- (BOOL)isLastCellInSection:(NSIndexPath *)indexPath{
    return indexPath.row == [self numberOfRowsInSection:indexPath.section]-1;
}
@end
