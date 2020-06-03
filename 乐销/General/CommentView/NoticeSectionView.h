//
//  NoticeSectionView.h
//中车运
//
//  Created by 隋林栋 on 2018/4/18.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeSectionView : UIView
//属性
@property (strong, nonatomic) UILabel *labelReply;

#pragma mark 刷新view
- (void)resetViewWithNum:(NSInteger)num;
@end
