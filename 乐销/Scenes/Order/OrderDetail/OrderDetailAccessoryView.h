//
//  OrderDetailAccessoryView.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/12.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailAccessoryView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) NSArray *aryDatas;
@property (nonatomic, strong) NSMutableArray *aryImageDatas;

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary modelOrder:(ModelOrderList *)modelOrder;
@end
