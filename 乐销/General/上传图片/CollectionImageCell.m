//
//  CollectionImageCell.m
//中车运
//
//  Created by 隋林栋 on 2017/3/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "CollectionImageCell.h"


@implementation CollectionImageCell
#pragma mark 懒加载
- (UIButton *)btnDelete{
    if (_btnDelete == nil) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.tag = 1;
        [_btnDelete addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.backgroundColor = [UIColor redColor];
        _btnDelete.widthHeight = XY(W(20),W(20));
        _btnDelete.hidden = true;
    }
    return _btnDelete;
}
- (UIImageView *)ivImage{
    if (_ivImage == nil) {
        _ivImage = [UIImageView new];
        _ivImage.backgroundColor = [UIColor clearColor];
        _ivImage.image = nil;
        _ivImage.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage.clipsToBounds = true;
        _ivImage.widthHeight = XY(W(75),W(75));
        _ivImage.leftTop = XY(0,W(15));
    }
    return _ivImage;
}

#pragma mark 获取高度
+ (CGSize)fetchHeight{
    static CollectionImageCell * cell;
    if (cell == nil) {
        cell = [self new];
    }
    return [cell resetCellWithModel:nil];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.ivImage];
        [self.contentView addSubview:self.btnDelete];
    }
    return self;
}


#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model{
    //iv
    self.ivImage.leftTop = XY(0,0);
    [self.ivImage sd_setImageWithModel:model placeholderImageName:IMAGE_BIG_DEFAULT];
    //btn delete
    self.btnDelete.centerXCenterY = XY(self.ivImage.right,self.ivImage.top);
    return CGSizeMake(self.ivImage.width+ W(5), self.ivImage.height);
}
//照相机 cell
- (void)resetCellWithCamera{
    [self resetCellWithModel:^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加";
        return model;
    }()];
    self.ivImage.image = [UIImage imageNamed:@"bulkCargo_camera"];
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://删除
        {
            if (self.blockDelete) {
                self.blockDelete(self);
            }
        }
            break;
        default:
            break;
    }
}


@end


@implementation CollectionCustomeImageSizeCell
@synthesize ivImage = _ivImage1;
- (UIImageView *)ivImage{
    if (_ivImage1 == nil) {
        _ivImage1 = [UIImageView new];
        _ivImage1.backgroundColor = [UIColor clearColor];
        _ivImage1.image = nil;
        _ivImage1.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage1.clipsToBounds = true;
        _ivImage1.widthHeight = XY(W(105),W(105));
        _ivImage1.leftTop = XY(0,W(15));
    }
    return _ivImage1;
}
#pragma mark 获取高度
+ (CGSize)fetchHeight{
    static CollectionImageCell * cell;
    if (cell == nil) {
        cell = [self new];
    }
    return [cell resetCellWithModel:nil];
}

@end


@implementation CollectionCustomeImageReplyCell
@synthesize ivImage = _ivImage1;
- (UIImageView *)ivImage{
    if (_ivImage1 == nil) {
        _ivImage1 = [UIImageView new];
        _ivImage1.backgroundColor = [UIColor clearColor];
        _ivImage1.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage1.clipsToBounds = true;
        _ivImage1.widthHeight = XY(W(105),W(105));
        _ivImage1.leftTop = XY(0,0);
    }
    return _ivImage1;
}
#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model{
    //iv
    self.ivImage.leftTop = XY(W(5),0);
    [self.ivImage sd_setImageWithModel:model placeholderImageName:IMAGE_BIG_DEFAULT];
    //btn delete
    self.btnDelete.centerXCenterY = XY(self.ivImage.right,self.ivImage.top);
    return CGSizeMake(self.ivImage.width+W(5), self.ivImage.height);
}

#pragma mark 获取高度
+ (CGSize)fetchHeight{
    static CollectionImageCell * cell;
    if (cell == nil) {
        cell = [self new];
    }
    return [cell resetCellWithModel:nil];
}

@end


