//
//  UIPickerView+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/10/16.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "UIPickerView+Category.h"

@implementation UIPickerView (Category)
#pragma mark refresh
+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self,@selector(selectedRowInComponent:)), class_getInstanceMethod(self,@selector(safe_selectedRowInComponent:)));
    
}
- (NSInteger)safe_selectedRowInComponent:(NSInteger)component{
    if (component<0 || component >= self.numberOfComponents) {
        return -1;
    }
    return [self safe_selectedRowInComponent:component];
}
@end
