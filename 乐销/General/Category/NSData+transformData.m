//
//  NSData+transformData.m
//  天下农商
//
//  Created by mengxi on 16/4/28.
//  Copyright © 2016年 mirror. All rights reserved.
//

#import "NSData+transformData.h"


@implementation NSData (transformData)

+(NSData *)dataWithObject:(id)dataObj archiveName:(NSString *)archiveName
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dataObj forKey:archiveName];
    [archiver finishEncoding];
    return data;
}

+(id)idWithData:(NSData *)data archiveName:(NSString *)archiveName
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id adData = [unarchiver decodeObjectForKey:archiveName];
    [unarchiver finishDecoding];
    return adData;
}



@end
