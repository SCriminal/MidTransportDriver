//
//  UpImageWithTextCell.h
//中车运
//
//  Created by 宋晨光 on 17/3/13.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"
//base image
#import "BaseImage.h"
//enum_up image type
#import "AliClient.h"

@protocol UpImageWithTextDelegate <NSObject>

-(void)protocolUpImageWithTextButton:(NSInteger)senderTag cell:(UITableViewCell *)cell;

@end

@interface UpImageWithTextCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,strong) UIButton *greenAddButton;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIButton *redDeleteButton;
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UIButton *topButton;
@property (nonatomic,strong) UIButton *downButton;
@property (nonatomic,strong) PlaceHolderTextView *textView;

@property (nonatomic, strong) ModelImage *modelImageInfo;

@property (nonatomic,assign) NSInteger indexRow;

@property (nonatomic,weak) id<UpImageWithTextDelegate>delegate;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelImage *)model;

@end



