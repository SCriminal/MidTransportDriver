//
//  ImagePickerCollectionCell.m
//中车运
//
//  Created by 隋林栋 on 2017/4/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "ImagePickerCollectionCell.h"
// imagecontrol
#import "ImageControl.h"

@implementation ImagePickerCollectionCell
#pragma mark 懒加载
- (PHImageRequestOptions *)opt{
    if (!_opt) {
        _opt = [[PHImageRequestOptions alloc]init];
        _opt.resizeMode = PHImageRequestOptionsResizeModeFast;
        _opt.synchronous = YES;
        _opt.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    }
    return _opt;
}
- (PHImageManager *)imageManager{
    if (!_imageManager) {
        _imageManager = [[PHImageManager alloc] init];
    }
    return _imageManager;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        CGFloat width = (SCREEN_WIDTH - W(5)*4)/3.0 - 1;
        _iconImg.widthHeight = XY(width,width);
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        _iconImg.clipsToBounds = true;
    }
    return _iconImg;
}
- (ImageControl *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [ImageControl initWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"pic_wx" heightImageName:@"pic_xz" imageFrame:CGRectMake(0, 0, W(20), W(20)) tag:1];
        [_rightButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.rightButton];
        self.height = SCREEN_WIDTH / 3.0 - 1;
    }
    return self;
}

#pragma mark 刷新cell
- (void)resetCellWithImage:(PHAsset *)asset isSelected:(BOOL)iseSelected{
    WEAKSELF
    if (asset) {
        [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(SCREEN_WIDTH/2.0,SCREEN_WIDTH/2.0) contentMode:PHImageContentModeAspectFill options:self.opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            weakSelf.iconImg.image = result;
        }];
    }
    self.rightButton.selected = iseSelected;
    self.rightButton.hidden = false;
    //刷新view
    self.iconImg.center = CGPointMake(self.width/2.0, self.height/2.0);
    [self.rightButton resetFrame:CGRectMake(0, 0, self.iconImg.width, self.iconImg.width) imageFrame:CGRectMake(self.width - W(30) , W(10), W(20), W(20))];
}



#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            if (self.blockClick) {
                self.blockClick(self);
            }
        }
            break;
        default:
            break;
    }
}
@end

@implementation ImagePickerBottomView
#pragma mark 懒加载
-(UIButton *)btnComplete{
    if (_btnComplete == nil) {
        _btnComplete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComplete.tag = 1;
        [_btnComplete addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnComplete.backgroundColor = [UIColor clearColor];
        [_btnComplete setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnComplete.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnComplete setTitle:@"完成" forState:(UIControlStateNormal)];
        _btnComplete.widthHeight = XY(W(100),W(49));
    }
    return _btnComplete;
}

-(UIButton *)btnSelectAlbum{
    if (_btnSelectAlbum == nil) {
        _btnSelectAlbum = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSelectAlbum.tag = 2;
        _btnSelectAlbum.backgroundColor = [UIColor clearColor];
        _btnSelectAlbum.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSelectAlbum setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
        [_btnSelectAlbum setTitle:@"选择相册" forState:(UIControlStateNormal)];
        _btnSelectAlbum.widthHeight = XY(W(100),W(49));
    }
    return _btnSelectAlbum;
}

- (UIImageView *)iconArrow{
    if (_iconArrow == nil) {
        _iconArrow = [UIImageView new];
        //        _iconArrow.image = [UIImage imageNamed:@"zzrs_qyzz"];
        _iconArrow.widthHeight = XY(W(15),W(15));
    }
    return _iconArrow;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    self.widthHeight = XY(SCREEN_WIDTH, W(49));
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.btnComplete];
    [self addSubview:self.btnSelectAlbum];
    [self addSubview:self.iconArrow];
}

#pragma mark 创建
+ (instancetype)initWithModel:(id)model{
    ImagePickerBottomView * view = [ImagePickerBottomView new];
    [view resetViewWithModel:model];
    return view;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnComplete.rightTop = XY(SCREEN_WIDTH,0);
    self.btnSelectAlbum.leftTop = XY(0,0);
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}


@end
@interface ImagePikcerListBGVIew ()
@end

@implementation ImagePikcerListBGVIew

#pragma mark 懒加载

- (UIView *)listView{
    if (!_listView) {
        _listView = [UIView new];
    }
    return _listView;
}
- (UIControl *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIControl new];
        _viewBG.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        _viewBG.userInteractionEnabled = true;
        [_viewBG addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _viewBG;
}
- (NSArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSArray array];
    }
    return _aryDatas;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.alpha = 0;
    self.isAnimate = false;
    [self addSubview: self.viewBG];
    [self.viewBG addSubview:self.listView];
    [self addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark reset view
- (void)resetViewWithAry:(NSArray *)arydatas height:(CGFloat)height{
    self.viewBG.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    self.aryDatas = arydatas;
    [self resetViewList];
    self.listView.leftBottom = XY(0, self.viewBG.height);
    
}

- (void)resetViewList{
    [self.listView removeAllSubViews];
    CGFloat top = 0;
    for (int i = 0; i< self.aryDatas.count; i++) {
        PHAssetCollection *group = self.aryDatas[i];
        NSString *groupName = UnPackStr(group.localizedTitle);
        
        UIButton * btnTmp = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTmp.tag = i+100;
        [btnTmp addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnTmp.backgroundColor = [UIColor whiteColor];
        btnTmp.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [btnTmp setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
        [btnTmp setTitle:groupName forState:(UIControlStateNormal)];
        btnTmp.widthHeight = XY(W(100),W(49));
        btnTmp.leftTop = XY(0, top);
        [self.listView addSubview:btnTmp];
        top = btnTmp.bottom+1;
    }
    self.listView.widthHeight = XY(W(100), top);
}

#pragma mark 动画显示
- (void)hideAnimation{
    if (!_isAnimate) {
        _isAnimate = true;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            _isAnimate = false;
        }];
    }
}
- (void)showAnimation{
    if (!_isAnimate) {
        _isAnimate = true;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            _isAnimate = false;
        }];
    }
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    NSInteger index = sender.tag - 100;
    PHAssetCollection *group = self.aryDatas[index];
    if (self.blockSelect) {
        self.blockSelect(group);
    }
    [self hideAnimation];

    
}
@end
