//
//  NSArray+Safe.h
//  KVOTest
//
//  Created by StriEver on 16/7/29.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSArray (Safe)
//safe object at index
- (id)safe_objectAtIndex:(NSUInteger)index;
@end
