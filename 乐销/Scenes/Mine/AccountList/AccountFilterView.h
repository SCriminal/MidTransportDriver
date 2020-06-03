//
//  AccountFilterView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountFilterView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UITextField *tfBillNo;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, strong) UILabel *labelCarTeam;
@property (nonatomic, strong) UILabel *labelTimeStart;
@property (nonatomic, strong) UILabel *labelTimeEnd;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) ModelMotrocadeList *modelMotorcade;

@property (nonatomic, strong) void (^blockSearchClick)(NSString *,ModelMotrocadeList* ,NSDate *,NSDate *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end
