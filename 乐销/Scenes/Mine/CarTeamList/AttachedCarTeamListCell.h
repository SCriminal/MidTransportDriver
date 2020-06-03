//
//  AttachedCarTeamListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachedCarTeamListCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelAddress;
@property (nonatomic, strong) UIButton *btnApply;
@property (nonatomic, strong) ModelAttachCompany *model;
@property (nonatomic, strong) void (^blockClick)(ModelAttachCompany *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAttachCompany *)model;

@end

@interface AttachedCarTeamSearchView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIImageView *iconSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
