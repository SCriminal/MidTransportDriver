//
//  UpImageView.m
//  乐销
//
//  Created by 隋林栋 on 2016/12/28.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "UpImageView.h"

//图片选择collection
#import "Collection_Image.h"
//collection cell
#import "CollectionImageCell.h"
//上传的图片
#import "BaseImage.h"



@interface UpImageView()

@end
@implementation UpImageView

#pragma mark lazy init
- (UIView *)upImageBG{
    if (_upImageBG == nil) {
        _upImageBG = [UIControl new];
        _upImageBG.tag = 1;
        _upImageBG.width = SCREEN_WIDTH;
        _upImageBG.clipsToBounds = true;
        [_upImageBG addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
        _upImageBG.widthHeight = XY(SCREEN_WIDTH,W(0));
        _upImageBG.backgroundColor = [UIColor whiteColor];
    }
    return _upImageBG;
}
- (UIImageView *)upImageHead{
    if (_upImageHead == nil) {
        _upImageHead = [UIImageView new];
        _upImageHead.backgroundColor = [UIColor clearColor];
        _upImageHead.image = [UIImage imageNamed:@"spgl_tp"];
        _upImageHead.widthHeight = XY(W(17),W(17));
    }
    return _upImageHead;
}
- (UILabel *)upImageLabel{
    if (_upImageLabel == nil) {
        _upImageLabel = [UILabel new];
        [GlobalMethod setLabel:_upImageLabel widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_TITLE text:@"上传图片"];
    }
    return _upImageLabel;
}
- (Collection_Image *)collection_Image{
    if (!_collection_Image) {
        _collection_Image = [Collection_Image new];
        WEAKSELF
        _collection_Image.blockUpComplete = ^(void){
            if (weakSelf.blockResetView != nil) {
                [weakSelf resetView];
                if (weakSelf.blockResetView != nil) {
                    weakSelf.blockResetView();
                }
            }
        };
    }
    return _collection_Image;
}


#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.isHiddenCollectionNoData = true;
        [self addSubview];
    }
    return self;
}

#pragma mark addSubView
- (void)addSubview{
    [self addSubview:self.upImageBG];
    [self.upImageBG addSubview:self.upImageHead];
    [self.upImageBG addSubview:self.upImageLabel];
    [self addSubview:self.collection_Image];
    [self resetView];
}
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];
    //see up image
    self.upImageBG.hidden = self.isNotShowUpImageView;
    self.collection_Image.hidden = self.isNotShowUpImageView;
    //up image top view
    self.upImageHead.leftTop = XY(W(15),W(15));
    self.upImageLabel.leftCenterY = XY(self.upImageHead.right +W(10),self.upImageHead.centerY);
    self.upImageBG.height = self.isNotShowUpImageTopView ? 0 : self.upImageHead.bottom + W(15);
    
    self.collection_Image.top = self.upImageBG.bottom;
    self.collection_Image.hidden = self.collection_Image.aryDatas.count <= 0 && self.isHiddenCollectionNoData;
    //set add file
   
    CGFloat top = self.isNotShowUpImageView ? 0 : [self  addLineFrame:CGRectMake(0, self.collection_Image.aryDatas.count == 0  && self.isHiddenCollectionNoData?self.upImageBG.bottom:self.collection_Image.bottom, SCREEN_WIDTH, W(10)) color:COLOR_BACKGROUND];

    
    self.height = top;
}

#pragma mark 显示图片
- (void)showImage{
    [self.collection_Image showSelectImage];
}


#pragma mark 销毁
- (void)dealloc{
    NSLog(@"%s  %@",__func__,self.class);
}

@end
