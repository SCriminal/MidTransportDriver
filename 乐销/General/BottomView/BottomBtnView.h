//
//  BottomBtnView.h
//中车运
//
//  Created by 刘京涛 on 2018/7/13.
//  Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomBtnView : UIView

@property (nonatomic, strong) NSArray *btnArray;
#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)modelArray;

@end
