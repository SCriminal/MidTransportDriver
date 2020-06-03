//
//  VersionUpView.h
//中车运
//
//  Created by 刘惠萍 on 2017/5/24.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelVersionUp.h"
@interface VersionUpView : UIView
#pragma mark single
DECLARE_SINGLETON(VersionUpView)

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelContent;
@property (strong, nonatomic) UILabel *labelUp;
@property (strong, nonatomic) UILabel *labelCancel;
@property (strong, nonatomic) UILabel *labelVersion;

@property (nonatomic, strong) ModelVersionUp *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelVersionUp *)model;
@end
