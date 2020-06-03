//
//  AuthorityImageView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "AuthorityImageView.h"
#import "UIView+SelectImageView.h"
#import "AliClient.h"

@interface AuthorityImageView ()

@end

@implementation AuthorityImageView

- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryModels{
    [self removeAllSubViews];
    //重置视图坐标
    [self.aryDatas removeAllObjects];
    CGFloat top = 0;
    CGFloat bottom = 0;
    for (int i = 0;i<aryModels.count;i++) {
        ModelImage * modelItem = aryModels[i];
        [self.aryDatas addObject:modelItem];
        
        AuthorityImageItemView * view = [AuthorityImageItemView new];
        [view resetViewWithModel:modelItem];
        if (i%2==0) {
            view.left = W(14);
        }else{
            view.right = SCREEN_WIDTH - W(14);
        }
        view.top = top + W(15);
        [self addSubview:view];
        if (i%2 != 0) {
            top = view.bottom;
        }
        bottom = view.bottom;
    }
    
    //设置总高度
    self.height = bottom+W(20);}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


@end



@implementation AuthorityImageItemView
#pragma mark 懒加载
- (UIImageView *)ivCamera{
    if (_ivCamera == nil) {
        _ivCamera = [UIImageView new];
        _ivCamera.image = [UIImage imageNamed:@"authority_camera"];
        _ivCamera.widthHeight = XY(W(28),W(24));
    }
    return _ivCamera;
}
- (UIImageView *)ivBG{
    if (_ivBG == nil) {
        _ivBG = [UIImageView new];
        _ivBG.widthHeight = XY(W(167),W(107));
    }
    return _ivBG;
}
- (UIImageView *)ivImage{
    if (_ivImage == nil) {
        _ivImage = [UIImageView new];
        _ivImage.widthHeight = self.ivBG.widthHeight;
        _ivImage.backgroundColor = [UIColor clearColor];
        _ivImage.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage.clipsToBounds = true;
    }
    return _ivImage;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.widthHeight = XY(self.ivBG.width, [UIFont fetchHeight:F(6)]) ;

    }
    return _labelTitle;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = self.ivImage.width;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
//    [self addSubview:self.ivCamera];
    [self addSubview:self.ivBG];
    [self addSubview:self.labelTitle];
    [self addSubview:self.ivImage];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelImage *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.ivCamera.centerXTop = XY(self.width/2.0,W(25));
    self.ivBG.image = model.image;
    if (isStr(model.url)) {
        [self.ivImage sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error == nil && image) {
                [GlobalMethod asynthicBlock:^{
                    BaseImage * baseIV = [BaseImage imageWithImage:image url:imageURL];
                    [GlobalMethod mainQueueBlock:^{
                        [self configBaseImage:baseIV];
                    }];
                }];
              
            }
        }];
    }
    
    NSString * str1 = model.isEssential? @"*":@"";
    NSString * str2 = model.desc;
    NSMutableAttributedString * strAttribute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    [strAttribute setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],        NSFontAttributeName :  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular]} range:NSMakeRange(0, str1.length)];
    [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_666,        NSFontAttributeName :  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular]} range:NSMakeRange(str1.length, str2.length)];
    self.labelTitle.attributedText = strAttribute;
    
    self.labelTitle.centerXTop = XY(self.width/2.0,self.ivImage.bottom+W(6));
    
    self.height = self.labelTitle.bottom;

}

#pragma mark click
- (void)click{
    if (self.model.isChangeInvalid) {
        [GlobalMethod showAlert:@"不可修改"];
        return;
    }
    [self showImageVC:1];
}
- (void)imageSelect:(BaseImage *)image{
    [AliClient sharedInstance].imageType = self.model.imageType?self.model.imageType:ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
    BaseVC * vc = (BaseVC *)[self fetchVC];
    [vc showLoadingView];
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        [self configBaseImage:image];
        [vc.loadingView hideLoading];
    } fail:^{
        [vc.loadingView hideLoading];
    }];
   
}

- (void)configBaseImage:(BaseImage *)image{
    self.model.image = image;
    self.ivImage.image = image;
    self.ivBG.hidden = true;
//    self.labelTitle.hidden = true;
    self.ivCamera.hidden = true;
}
@end
