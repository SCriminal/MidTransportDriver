//
//  OrderFilterView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/14.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderFilterView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, assign) CGRect borderFrame;
@property (nonatomic, strong) UILabel *labelTimeStart;
@property (nonatomic, strong) UILabel *labelTimeEnd;

@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, assign) NSInteger btnTagSelected;
@property (nonatomic, strong) UITextField *tfBillNo;

@property (nonatomic, strong) void (^blockSearchClick)(NSInteger, NSString *,NSDate *,NSDate *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end
