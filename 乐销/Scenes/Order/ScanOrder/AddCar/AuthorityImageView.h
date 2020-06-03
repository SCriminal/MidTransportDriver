//
//  AuthorityImageView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorityImageView : UIView
@property (nonatomic, strong) NSMutableArray *aryDatas;


#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryModels;
@end


@interface AuthorityImageItemView : UIView
//属性
@property (strong, nonatomic) UIImageView *ivCamera;
@property (strong, nonatomic) UIImageView *ivBG;
@property (strong, nonatomic) UIImageView *ivImage;
@property (strong, nonatomic) UILabel *labelTitle;
@property (nonatomic, strong) ModelImage *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelImage *)model;

@end
