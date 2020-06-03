//
//  EditVC_Title.h
//中车运
//
//  Created by 隋林栋 on 2018/7/2.
//Copyright © 2018年 ping. All rights reserved.
//

#import "BaseTableVC.h"
//textview
#import "PlaceHolderTextView.h"

@interface EditVC_Title : BaseTableVC
@property (nonatomic, strong) NSString *navTitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) void (^blockComplete)(NSString *);

@end


@interface EditVC_TitleHeaderView : UIView<UITextViewDelegate>
//属性
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) void (^blockTextChange)(NSString *);


#pragma mark 刷新view
- (void)resetView;

@end
