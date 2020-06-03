//
//  ImageInfoDetailView.m
//中车运
//
//  Created by 隋林栋 on 2017/3/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "ImageInfoDetailView.h"
//model
#import "ModelImage.h"
//detail big image view
#import "ImageDetailBigView.h"

@implementation ImageInfoDetailView

- (NSArray *)aryModels{
    if (!_aryModels) {
        _aryModels = [NSArray new];
    }
    return _aryModels;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.topInterval = 0;
        self.widthHeight = XY(SCREEN_WIDTH, 0);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)resetView:(NSArray *)ary{
    [self removeAllSubViews];
    if (!isAry(ary)) {
        self.height = CGFLOAT_MIN;
        return;
    }
    self.aryModels = ary;
    CGFloat y = self.topInterval;
    CGFloat imageWidth = SCREEN_WIDTH - W(30);
    CGFloat imageLeft = W(15);
    for (int i = 0; i <  ary.count; i++) {
        ModelImage *model = ary[i];
        CGFloat height = model.width == 0? 0 : imageWidth*model.height/model.width;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(imageLeft, y, imageWidth, height)];
        [img sd_setImageWithModel:model placeholderImageName:IMAGE_BIG_DEFAULT];
        img.userInteractionEnabled = true;
        y = img.bottom;
        img.tag = i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [img addGestureRecognizer:tap];
        [self addSubview:img];
        
        if (isStr(model.desc)) {
            UILabel * label = [UILabel new];
            label.leftTop = XY(W(15), y+ W(8));
            label.numberOfLines = 0;
            NSAttributedString *str = [GlobalMethod returnNSAttributedStringWithContentStr:[NSString stringWithFormat:@" %@",model.desc] titleColor:COLOR_TITLE withlineSpacing:W(4) withAlignment:0 withFont:[UIFont systemFontOfSize:F(14)] withImageName:@"dt_tri" withImageRect:CGRectMake( 0,2,W(7), W(6)) withAtIndex:0];
            label.attributedText = str;
            CGRect rect =[str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - W(30), CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            CGFloat num_height_return = CGRectGetHeight(rect);
            label.height = num_height_return;
            if (rect.size.width<SCREEN_WIDTH - W(30)) {
                label.width = rect.size.width;
            }
            [self addSubview:label];
            y = label.bottom;
        }
        if (i < ary.count - 1) {
            y += W(15);
        }
    }
    self.height = y+self.bottomInterval;
}
#pragma mark image Click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView * view = (UIImageView *)tap.view;
    ImageDetailBigView * detailView = [ImageDetailBigView new];
    
    [detailView resetView:self.aryModels.tmpMuAry isEdit:false index: view.tag];
    [detailView showInView:GB_Nav.lastVC.view imageViewShow:view];
    
}


@end

