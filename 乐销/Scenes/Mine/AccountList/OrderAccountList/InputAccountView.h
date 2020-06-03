//
//  InputAccountView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputAccountView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *labelInput;
@property (nonatomic, strong) UIImageView *ivClose;
@property (nonatomic, strong) UIImageView *ivDown;
@property (nonatomic, strong) UIView *viewBorder;
@property (nonatomic, strong) UILabel *labelIncome;
@property (nonatomic, strong) UIView *viewDesBorder;
@property (nonatomic, strong) UITextField *tfDes;
@property (nonatomic, strong) UIView *viewPriceBorder;
@property (nonatomic, strong) UITextField *tfPrice;
@property (nonatomic, assign) BOOL isReceive;
@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, strong) void (^blockComplete)(NSString *,NSString*,BOOL);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end
