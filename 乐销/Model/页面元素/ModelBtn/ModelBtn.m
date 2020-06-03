//
//  ModelBtn.m
//中车运
//
//  Created by 隋林栋 on 2016/12/20.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "ModelBtn.h"



@implementation ModelBtn


+ (instancetype)modelWithTitle:(NSString *)title{
    return [ModelBtn modelWithTitle:title  tag:0];
}
+ (instancetype)modelWithTitle:(NSString *)title
                           tag:(int)tag{
    return [ModelBtn modelWithTitle:title imageName:nil tag:tag];
}
+ (instancetype)modelWithTitle:(NSString *)title
                           imageName:(NSString *)imageName
                                 tag:(int)tag{
    return [ModelBtn modelWithTitle:title imageName:imageName highImageName:nil tag:tag];
}
+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag{
    return [ModelBtn modelWithTitle:title imageName:imageName highImageName:highImageName tag:tag color:nil];
}

+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag
                         color:(UIColor *)color{
    return [ModelBtn modelWithTitle:title imageName:imageName highImageName:highImageName tag:tag color:color selectColor:nil];
}

+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag
                         color:(UIColor *)color
                   selectColor:(UIColor *)colorSelect
{
    ModelBtn * model = [ModelBtn new];
    model.title = title;
    model.imageName = imageName;
    model.highImageName = highImageName;
    model.tag = tag;
    model.color = color;
    model.colorSelect = colorSelect;
    return model;
}



@end
