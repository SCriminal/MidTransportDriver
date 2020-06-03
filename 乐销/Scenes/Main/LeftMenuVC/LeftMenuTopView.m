//
//  LeftMenuTopView.m
//  Driver
//
//  Created by 隋林栋 on 2018/12/12.
//Copyright © 2018 ping. All rights reserved.
//

#import "LeftMenuTopView.h"

@interface LeftMenuTopView ()

@end

@implementation LeftMenuTopView
#pragma mark 懒加载
- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.widthHeight = XY(W(65),W(65));
        [GlobalMethod setRoundView:_head color:[UIColor whiteColor] numRound:_head.width/2.0 width:0];
        _head.userInteractionEnabled = true;
        _head.contentMode = UIViewContentModeScaleAspectFill;
        _head.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
    }
    return _head;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = [UIColor blackColor];
        _name.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
    }
    return _name;
}
- (UILabel *)identity{
    if (_identity == nil) {
        _identity = [UILabel new];
        _identity.textColor = COLOR_666;
        _identity.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _identity;
}
- (UIImageView *)imgIdentity{
    if (!_imgIdentity) {
        _imgIdentity = [UIImageView new];
        _imgIdentity.backgroundColor = [UIColor clearColor];
        _imgIdentity.widthHeight = XY(W(25),W(25));
        _imgIdentity.image = [UIImage imageNamed:@"certification_default"];
    }
    return _imgIdentity;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        //add notice observe
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoChange) name:NOTICE_SELFMODEL_CHANGE object:nil];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.head];
    [self addSubview:self.name];
    
    [self addSubview:self.identity];
    [self addSubview:self.imgIdentity];
    //初始化页面
    [self resetViewWithModel:[GlobalData sharedInstance].GB_UserModel];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBaseInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.head sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.headUrl.smallImage)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.head.centerXTop = XY(W(250)/2.0,W(25)+STATUSBAR_HEIGHT+W(35));
    
    NSString * strName = isStr(model.nickname)?UnPackStr(model.nickname):UnPackStr(model.realName);
    [self.name fitTitle:[GlobalMethod isLoginSuccess]?strName:@"未登录" variable:0];
    self.name.centerXTop = XY(self.head.centerX, self.head.bottom + W(20)) ;
    
    [self.identity fitTitle:model.authStatusShow variable:0];
    self.identity.rightTop = XY(self.head.centerX + (self.imgIdentity.width + self.identity.width+ W(6))/2., self.name.bottom + W(15));
    
    self.imgIdentity.rightCenterY = XY(self.identity.left - W(6), self.identity.centerY);
    self.height = self.imgIdentity.bottom + W(45);
}


#pragma mark notice
- (void)userInfoChange{
    [self resetViewWithModel:[GlobalData sharedInstance].GB_UserModel];
}
#pragma  mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
