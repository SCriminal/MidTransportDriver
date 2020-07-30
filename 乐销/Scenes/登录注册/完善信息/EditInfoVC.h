//
//  EditInfoVC.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"
//text view
#import "PlaceHolderTextView.h"

@interface EditInfoVC : BaseTableVC

@end


@interface EditInfoTopView : UIView
//属性
@property (strong, nonatomic) UILabel *baseInfo;
@property (strong, nonatomic) UIView *BG;
@property (strong, nonatomic) UILabel *labelInfo;
@property (strong, nonatomic) UIImageView *ivHead;
@property (nonatomic, strong) void (^blockClick)();

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface EditInfoBottomView : UIView
//属性
@property (nonatomic, strong) UILabel *labelOpinion;
@property (nonatomic,strong) PlaceHolderTextView *textView;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
