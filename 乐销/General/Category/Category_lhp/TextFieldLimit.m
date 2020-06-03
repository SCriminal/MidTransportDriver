//
//  TextFieldLimit.m
//中车运
//
//  Created by 刘惠萍 on 2017/8/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "TextFieldLimit.h"

@interface TextFieldLimit ()

@end

@implementation TextFieldLimit


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}
#pragma mark value change
- (void)textChange{
    if (self.numLimit>0) {
        if (self.text.length>=self.numLimit) {
            self.text = [self.text substringToIndex:self.numLimit];
        }
    }
}

@end
