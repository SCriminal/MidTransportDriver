//
//  SelectCarTypeVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/6/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectCarTypeVC : BaseTableVC
@property (nonatomic, strong) void (^blockSelected)(NSString *type,NSNumber * idNumber);

@end

@interface SelectCarTypeCell : UITableViewCell

@property (strong, nonatomic) UILabel *typeName;

#pragma mark 刷新cell
- (void)resetCellWithModel:(NSString *)model;

@end


@interface SearchShopNavView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);
@property (nonatomic, strong) UIControl *backBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
