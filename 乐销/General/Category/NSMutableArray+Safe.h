//
//  NSMutableArray+Safe.h
//  KVOTest
//
//  Created by StriEver on 16/8/1.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)
- (id)safe_objectAtIndex:(NSUInteger)index;
@end
