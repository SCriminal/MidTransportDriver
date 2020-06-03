//
//  NSData+transformData.h
//  天下农商
//
//  Created by mengxi on 16/4/28.
//  Copyright © 2016年 mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (transformData)

+(NSData *)dataWithObject:(id)dataObj archiveName:(NSString *)archiveName;

+(id)idWithData:(NSData *)data archiveName:(NSString *)archiveName;




@end
