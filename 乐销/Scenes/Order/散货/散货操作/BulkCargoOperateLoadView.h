//
//  BulkCargoOperateLoadView.h
//  Driver
//
//  Created by 隋林栋 on 2019/7/19.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片选择collection
#import "Collection_Image.h"
#import "PlaceHolderTextView.h"

@interface BulkCargoOperateLoadView : UIView
@property (nonatomic, strong) UIView *viewClick;

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *labelInput;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *ivClose;
@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, strong) void (^blockComplete)(NSArray *,NSString *);
@property (nonatomic, strong) Collection_Image *collection_Image;
@property (nonatomic,strong) PlaceHolderTextView *textView;

#pragma mark 刷新view
- (void)show;


@end
