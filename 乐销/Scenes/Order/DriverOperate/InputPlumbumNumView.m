//
//  InputPlumbumNumView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "InputPlumbumNumView.h"

@interface InputPlumbumNumView ()

@end

@implementation InputPlumbumNumView
@synthesize labelInput = _labelInput;

- (UILabel *)labelInput{
    if (_labelInput == nil) {
        _labelInput = [UILabel new];
        _labelInput.textColor = COLOR_333;
        _labelInput.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        [_labelInput fitTitle:@"录入铅封号" variable:0];
        
    }
    return _labelInput;
}

- (NSString *)title{
    return self.packageSelect.sealNumber;
}
- (void)setTitle:(NSString *)title{
    self.packageSelect.sealNumber = title;
}
@end
