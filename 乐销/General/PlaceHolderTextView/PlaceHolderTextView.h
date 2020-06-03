//
//  PlaceHolderTextView.h
//中车运
//
//  Created by 隋林栋 on 2016/12/24.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView
@property (nonatomic, strong) UILabel *placeHolder;
@property (nonatomic, strong) void (^blockTextChange)(PlaceHolderTextView *);//text change
@property (nonatomic, strong) void (^blockHeightChange)(PlaceHolderTextView *);//text change
@property (nonatomic, assign) CGFloat numTextHeight;//textHeight
@property (nonatomic, assign) CGFloat lineSpace;//lineSpace
@property (nonatomic, strong) NSDictionary *attributes;


/**
 change number of lines

 @param isCall call block change lines
 */
- (void)changeLinesCallBlock:(BOOL)isCall;
@end
