//
//  SelectBankNameVC.h
//  Driver
//
//  Created by 隋林栋 on 2020/9/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectBankNameVC : BaseTableVC
@property (nonatomic, strong) void (^blockSearch)(NSString *);

@end



@interface SelectBankNavView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);
@property (nonatomic, strong) UIControl *backBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end



@interface SelectBankNameCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
