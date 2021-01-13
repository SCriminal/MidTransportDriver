//
//  AutoConfigOrderListFilterView.h
//  Driver
//
//  Created by 隋林栋 on 2021/1/13.
//Copyright © 2021 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoConfigOrderListFilterView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, assign) CGRect borderFrame;

@property (nonatomic, assign) NSInteger btnTagSelected;
@property (nonatomic, assign) NSInteger btnSubTagSelected;

@property (nonatomic, strong) void (^blockSearchClick)(NSInteger, NSInteger);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end
