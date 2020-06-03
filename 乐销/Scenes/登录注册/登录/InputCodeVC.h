//
//  InputCodeVC.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseVC.h"

typedef NS_ENUM(NSUInteger, ENUM_CODE_TYPE) {
    ENUM_CODE_LOGIN=0,
    ENUM_CODE_PWD,
};

@interface InputCodeVC : BaseVC
@property (nonatomic, strong) NSString *strPhone;
@property (nonatomic, assign) ENUM_CODE_TYPE typeFrom;
//定时器
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double numTime;
@end



@interface CodeView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) void (^blockComplete)(NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)clearCode;
@end
