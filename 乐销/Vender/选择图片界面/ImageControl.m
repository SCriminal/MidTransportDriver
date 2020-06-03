//
//  ImageControl.m
//中车运
//
//  Created by 隋林栋 on 2017/1/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "ImageControl.h"

@implementation ImageControl



#pragma mark 懒加载
- (UIImageView *)imageIcon{
    if (_imageIcon == nil) {
        _imageIcon = [UIImageView new];
        _imageIcon.backgroundColor = [UIColor clearColor];
        _imageIcon.image = nil;
        _imageIcon.widthHeight = XY(SCREEN_WIDTH,W(0));
    }
    return _imageIcon;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageIcon];
    }
    return self;
}


-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self.imageIcon setHighlighted:selected];
}
#pragma mark 创建
+ (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName heightImageName:(NSString *)heightImagName imageFrame:(CGRect)imageFrame tag:(NSInteger)tag{
    ImageControl * view = [ImageControl new];
    [view resetWithFrame:frame imageName:imageName heightImageName:heightImagName imageFrame:imageFrame tag:tag];
    return view;
}
#pragma mark 刷新view
- (void)resetWithFrame:(CGRect)frame imageName:(NSString *)imageName heightImageName:(NSString *)heightImagName imageFrame:(CGRect)imageFrame tag:(NSInteger)tag{
    self.imageIcon.image = [UIImage imageNamed:imageName];
    self.imageIcon.highlightedImage = [UIImage imageNamed:heightImagName];
    [self resetFrame:frame imageFrame:imageFrame];
    self.tag = tag;
}

- (void)resetFrame:(CGRect)frame imageFrame:(CGRect)imageFrame{
    self.frame = frame;
    self.imageIcon.frame = imageFrame;
}



@end
