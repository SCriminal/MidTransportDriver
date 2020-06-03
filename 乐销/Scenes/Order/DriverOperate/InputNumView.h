//
//  InputNumView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputNumView : UIView
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *labelInput;
@property (nonatomic, strong) UIImageView *ivClose;
@property (nonatomic, strong) UIView *viewBorder;
@property (nonatomic, strong) UITextField *tfNum;
@property (nonatomic, strong) UIImageView *ivCamera;
@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, strong) void (^blockComplete)(ModelPackageInfo *);
@property (nonatomic, strong) void (^blockORCClick)();

@property (nonatomic, strong) UIImageView *ivDown;
@property (nonatomic, strong) UIView *viewDownBorder;
@property (nonatomic, strong) UILabel *labelTitle;

@property (nonatomic, strong) NSArray *aryDatas;
@property (nonatomic, strong) ModelPackageInfo *packageSelect;
@property (nonatomic, strong) NSString *title;

#pragma mark 刷新view
- (void)showWithAry:(NSArray *)ary;
@end


//@interface InputPlumbumNumView : InputNumView
//
//@end
