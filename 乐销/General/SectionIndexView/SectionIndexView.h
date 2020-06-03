//
//  SectionIndexView.h
//中车运
//
//  Created by 隋林栋 on 2017/4/1.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionIndexView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *aryDatas;
@property (nonatomic, strong) UIColor *sectionIndexColor;

- (void)resetWithAry:(NSArray *)ary tableView:(UITableView *)tableView viewShow:(UIView *)view rightCenterY:(STRUCT_XY)rightCenterY;

@end
