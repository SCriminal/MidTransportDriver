//
//  AddSubtractView.h
//中车运
//
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TextFieldLimit.h"

@interface AddSubtractView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UIButton *btnSubtract;
@property (nonatomic, strong) UIImageView *ivAdd;//增加
@property (nonatomic, strong) UIImageView *ivSub;//减少
@property (nonatomic, strong) TextFieldLimit *textFieldNum;
@property double num;//当前数量
@property (nonatomic, strong) void (^blockNumChange) (double);

#pragma mark 创建
- (void)resetWithNum:(double)num;

@end
