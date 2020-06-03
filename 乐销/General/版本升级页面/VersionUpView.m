//
//  VersionUpView.m
//中车运
//
//  Created by 刘惠萍 on 2017/5/24.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "VersionUpView.h"

@implementation VersionUpView

#pragma mark single synthesize;
SYNTHESIZE_SINGLETONE_FOR_CLASS(VersionUpView)
#pragma mark 懒加载
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_backView color:[UIColor whiteColor] numRound:10 width:0];
    }
    return _backView;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font = [UIFont systemFontOfSize:F(15)];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
        [_labelTitle fitTitle:@"最新版本" variable:0];
    }
    return _labelTitle;
}
- (UILabel *)labelVersion{
    if (!_labelVersion) {
        _labelVersion = [UILabel new];
        _labelVersion.textColor = [UIColor whiteColor];
        _labelVersion.backgroundColor = COLOR_BLUE;
        _labelVersion.font = [UIFont systemFontOfSize:F(11)];
        [GlobalMethod setRoundView:_labelVersion color:[UIColor clearColor] numRound:3 width:0];
        _labelVersion.textAlignment = NSTextAlignmentCenter;
    }
    return _labelVersion;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        [GlobalMethod setLabel:_labelContent widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_TITLE text:@""];
        _labelContent.lineSpace = W(14);
    }
    return _labelContent;
}

- (UILabel *)labelUp{
    if (_labelUp == nil) {
        _labelUp = [UILabel new];
        _labelUp.textColor = [UIColor colorWithHexString:@"#4C86E5"];
        _labelUp.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelUp fitTitle:@"马上升级" variable:0];
    }
    return _labelUp;
}
- (UILabel *)labelCancel{
    if (_labelCancel == nil) {
        _labelCancel = [UILabel new];
        _labelCancel.textColor = COLOR_999;
        _labelCancel.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelCancel fitTitle:@"暂不更新" variable:0];
    }
    return _labelCancel;
}


- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"version_bg"];
    }
    return _imgView;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    [self addSubview:self.backView];
    [self.backView addSubview:self.imgView];
    [self.backView addSubview:self.labelTitle];
    [self.backView addSubview:self.labelVersion];
    [self.backView addSubview:self.labelContent];
    [self.backView addSubview:self.labelUp];
    [self.backView addSubview:self.labelCancel];
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelVersionUp *)model{
    //保存数据
    self.model = model;
    
    [self.backView removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    
    self.imgView.leftTop = XY(0,0);
    self.imgView.widthHeight = XY(self.backView.width,W(140));
    
    self.labelTitle.centerXTop = XY(self.backView.width/2.0,W(165));
    
    [self.labelVersion fitTitle:[NSString stringWithFormat:@"V %@",UnPackStr(model.versionNumber)] variable:0];
    self.labelVersion.widthHeight = XY(self.labelVersion.width+ W(12), self.labelTitle.height);
    self.labelVersion.leftCenterY = XY(self.labelTitle.right+ W(5), self.labelTitle.centerY);
    
    [self.labelContent  fitTitle:[NSString stringWithFormat:@"%@",model.iDPropertyDescription]  variable:self.backView.width-W(70)];
    self.labelContent.leftTop = XY(W(35),self.labelTitle.bottom+W(25));
    
    CGFloat bottom= [self.backView addLineFrame:CGRectMake(W(0),  self.labelContent.bottom+W(5), self.backView.width, 1)];
    
    //强制更新
    if (self.model.versionType == 2) {
        self.labelCancel.hidden = true;
    }else{
        self.labelCancel.centerXTop = XY(self.backView.width/4.0,bottom+ W(20));
        UIView * viewClick = [self.backView addControlFrame:CGRectInset(self.labelCancel.frame, -W(37), -W(20)) belowView:self.labelCancel target:self action:@selector(cancelClick)];
        viewClick.tag = TAG_LINE;
    }
    
    self.labelUp.centerXTop = XY(self.model.versionType == 2?self.backView.width/4.0 * 2.0:self.backView.width/4.0 * 3.0,bottom+ W(20));
    
    [self.backView addControlFrame:CGRectInset(self.labelUp.frame, -W(37), -W(20)) belowView:self.labelUp target:self action:@selector(upClick)];
    
    [self.backView addLineFrame:CGRectMake(self.backView.width/2.0, self.labelUp.top + W(3), 1, self.labelUp.height + W(6))];
    
    self.backView.centerXCenterY = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    self.backView.widthHeight = XY(SCREEN_WIDTH - W(108), self.labelUp.bottom + W(20));
    
    
}
#pragma mark click

- (void)cancelClick{
    if (self.model.versionType == 2) {//不兼容
        return;
    }
    [self removeFromSuperview];
}
- (void)upClick{
    NSURL *appBUrl = [NSURL URLWithString:[self.model.downloadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL:appBUrl]) {
        [[UIApplication sharedApplication] openURL:appBUrl];
    }
    if (self.model.versionType == 2) {//不兼容
        return;
    }
    [self removeFromSuperview];
}


@end
