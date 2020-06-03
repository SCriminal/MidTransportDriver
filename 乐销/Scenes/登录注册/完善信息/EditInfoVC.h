//
//  EditInfoVC.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface EditInfoVC : BaseTableVC

@end


@interface EditInfoTopView : UIView
//属性
@property (strong, nonatomic) UILabel *labelInfo;
@property (strong, nonatomic) UIImageView *ivHead;
@property (nonatomic, strong) void (^blockClick)();

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
