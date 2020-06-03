//
//  ModelBtn.h
//中车运
//
//  Created by 隋林栋 on 2016/12/20.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelBtn : NSObject

@property (nonatomic, strong) NSString * imageName;
@property (nonatomic, strong) NSString * highImageName;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, strong) UIColor * colorSelect;
@property (nonatomic, assign) CGFloat width;//btn 宽度
@property (nonatomic, assign) CGFloat height;//btn 高度
@property (nonatomic, assign) BOOL isHide;//是否隐藏
@property (nonatomic, assign) BOOL isLineHide;//是否隐藏
@property (nonatomic, assign) BOOL isNotShowAnimated;//slider remove animate btn selected是否显示动画
@property int tag;//tag
@property (nonatomic, assign) BOOL isSelected;//isselected
@property (strong, nonatomic) NSString * vcName;

//data
@property (nonatomic, strong) NSString * subTitle;//subtitle
@property (nonatomic, assign) CGFloat num;//num
@property (nonatomic, strong) void (^blockClick)(void);//just transfer block

+ (instancetype)modelWithTitle:(NSString *)title;
+ (instancetype)modelWithTitle:(NSString *)title
                           tag:(int)tag;
+ (instancetype)modelWithTitle:(NSString *)title
                           imageName:(NSString *)imageName
                                 tag:(int)tag;
+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag;
+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag
                         color:(UIColor *)color;
+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag
                         color:(UIColor *)color
                     selectColor:(UIColor *)colorSelect;




@end
