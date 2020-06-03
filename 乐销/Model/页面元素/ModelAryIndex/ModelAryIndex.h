//
//  ModelAryIndex.h
//中车运
//
//  Created by 隋林栋 on 2016/12/30.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelAryIndex : NSObject
@property (nonatomic, strong) NSString *strFirst;
@property (nonatomic, strong) NSMutableArray *aryMu;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat numAll;
@property (nonatomic, assign) CGFloat priceAll;

#pragma mark 创建
+ (instancetype)initWithStrFirst:(NSString *)strFirst;

- (void)resetWithStrFirst:(NSString *)strFirst;
@end
