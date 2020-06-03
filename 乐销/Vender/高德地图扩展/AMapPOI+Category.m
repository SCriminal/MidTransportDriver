//
//  AMapPOI+Category.m
//中车运
//
//  Created by 隋林栋 on 2017/6/5.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "AMapPOI+Category.h"

@implementation AMapPOI (Category)

- (NSString *)address_sld{
    NSString * detailStr = [NSString stringWithFormat:@"%@%@%@",UnPackStr(self.city),isStr(self.city)&&isStr(self.address)?@"·":@"",UnPackStr(self.address)];
    return detailStr;
}

@end
