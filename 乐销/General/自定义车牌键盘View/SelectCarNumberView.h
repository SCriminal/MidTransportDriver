//
//  CustomCharactersKeyBoardView.h
//  乐销
//
//  Created by lirenbo on 2018/5/31.
//  Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectCarNumberView : UIView
//属性
@property (strong, nonatomic) NSString *content;

@property (nonatomic,copy) void (^blockSelected)(NSString * str);

#pragma mark 刷新view
- (void)resetViewWithContent:(NSString *)content;

@end


@interface DistrictAlphaView : UIView

@property (strong, nonatomic) UIButton *deleteBtn;

@property (nonatomic,copy) void (^btnClickBlock)(NSString * str);
@property (nonatomic,copy) void (^deleteClickBlock)(void);

#pragma mark - 刷新view
- (void)resetViewWithModel:(id)model;

@end


#pragma mark - headerView
@interface CharacterView : UIView

@property (strong, nonatomic) NSMutableArray * numAndLettersArr;

@property (strong, nonatomic) NSMutableArray * numAndLettersArrSecond;

@property (strong, nonatomic) NSMutableArray * numAndLettersArrThird;

@property (strong, nonatomic) NSMutableArray * numAndLettersArrFourth;
@property (strong, nonatomic) UIButton *deleteBtn;

@property (nonatomic,copy) void (^byValueBlock)(NSString * str);

@property (nonatomic,copy) void (^delBlack)(void);


#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


