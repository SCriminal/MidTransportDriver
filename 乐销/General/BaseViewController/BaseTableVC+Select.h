//
//  BaseTableVC+Select.h
//中车运
//
//  Created by 隋林栋 on 2018/4/10.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC (Select)
@property (nonatomic, strong) void (^blockComplete)(NSMutableArray *);//选择完成回调
@property (nonatomic, strong) NSMutableArray * arySelected;//已选数据
@end
