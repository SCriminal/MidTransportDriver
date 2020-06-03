//
//  BaseTableVC.h
//中车运
//
//  Created by 隋林栋 on 2016/12/14.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "BaseVC.h"
//section Index
#import "SectionIndexView.h"
//noresult view
#import "NoResultView.h"

@interface BaseTableVC : BaseVC<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableBackgroundView;//table bg
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong, readonly) NSString *strCellName;//
@property (nonatomic, strong, readonly) NSString *strModelName;//数据缓存
@property (nonatomic, strong, readonly) NSString *strLocalKey;//localKey

@property (nonatomic, assign) BOOL isRemoveAll;//是否移除全部
//分页请求数据
@property (nonatomic, assign) double pageNum;
@property (nonatomic, readonly) NSString *lastRow;
@property (nonatomic, readonly) NSString *lastUpdateTime;
@property (nonatomic, readonly) id requestDelegate;
//索引
@property (nonatomic, strong) SectionIndexView  *sectionIndexView;

#pragma mark 增加上拉 下拉
- (void)addRefresh;
- (void)addRefreshHeader;
- (void)addRefreshFooter;
#pragma mark refresh
- (void)refreshHeaderAll;
#pragma mark request
- (void)requestList;
#pragma mark 无数据
- (void)showNoResult;
#pragma mark 结束上拉 下拉
- (void)endRefreshing;

@end

