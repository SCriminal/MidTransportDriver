//
//  DriverDetailTopView.m
//  Driver
//
//  Created by 隋林栋 on 2018/12/27.
//Copyright © 2018 ping. All rights reserved.
//

#import "DriverDetailTopView.h"
//request
#import "RequestApi+UserApi.h"

@interface DriverDetailTopView ()

@end

@implementation DriverDetailTopView

#pragma mark 懒加载
- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.widthHeight = XY(W(65),W(65));
        [GlobalMethod setRoundView:_head color:[UIColor clearColor] numRound:_head.width/2.0 width:0];
        _head.userInteractionEnabled = true;
    }
    return _head;
}
- (UIImageView *)bg{
    if (_bg == nil) {
        UIImageView * iv = [UIImageView new];
               iv.backgroundColor = [UIColor clearColor];
               iv.contentMode = UIViewContentModeScaleAspectFill;
               iv.clipsToBounds = true;
               iv.image = [UIImage imageNamed:@"personalCenterBG"];
               iv.widthHeight = XY(SCREEN_WIDTH,W(160)+iphoneXTopInterval);
        _bg = iv;
    }
    return _bg;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        UIImageView * iv = [UIImageView new];
               iv.backgroundColor = [UIColor clearColor];
               iv.contentMode = UIViewContentModeScaleAspectFill;
               iv.clipsToBounds = true;
               iv.image = [UIImage imageNamed:@"arrow_white"];
               iv.widthHeight = XY(W(25),W(25));
        _arrow = iv;
    }
    return _arrow;
}

- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = [UIColor whiteColor];
        _name.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _name;
}
- (UILabel *)brief{
    if (!_brief) {
        _brief = [UILabel new];
        _brief.textColor = [UIColor whiteColor];
        _brief.numberOfLines = 1;
        _brief.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _brief;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = self.bg.height;
        [self addSubView];
        //add notice observe
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoChange) name:NOTICE_SELFMODEL_CHANGE object:nil];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.bg];
    [self addSubview:self.head];
    [self addSubview:self.name];
    [self addSubview:self.brief];
    [self addSubview:self.arrow];
    //初始化页面
    [self userInfoChange];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBaseInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    [self.head sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.headUrl.smallImage)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.head.leftBottom = XY(W(15), self.height - W(40));
    
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(10), self.head.centerY);
    
    NSString * strShow = UnPackStr(model.nickname);

    [self.name fitTitle:strShow variable:0];
    self.name.leftTop = XY(self.head.right + W(15), self.head.top + W(6));

    NSString * strBrief = isStr([GlobalData sharedInstance].GB_UserModel.introduce)?[GlobalData sharedInstance].GB_UserModel.introduce:@"还未填写个性签名，介绍一下自己吧";
    [self.brief fitTitle:strBrief variable:W(240)];
    self.brief.leftBottom = XY(self.name.left, self.head.bottom - W(6));
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


#pragma mark dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end






@implementation DriverDetailCell
#pragma mark 懒加载
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.widthHeight = XY(W(25),W(25));
        _icon.backgroundColor = [UIColor clearColor];
    }
    return _icon;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [UILabel new];
        _subTitle.textColor = COLOR_666;
        _subTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _subTitle.numberOfLines = 0;
        _subTitle.lineSpace = 0;
    }
    return _subTitle;
}
- (UILabel *)labelAlert{
    if (!_labelAlert) {
        _labelAlert = [UILabel new];
        _labelAlert.textColor = COLOR_BLUE;
        _labelAlert.fontNum = F(16);
    }
    return _labelAlert;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"setting_RightArrow"];
        _arrow.widthHeight = XY(W(25),W(25));
    }
    return _arrow;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
        _line.widthHeight = XY(SCREEN_WIDTH - W(60), 1);
        _line.left = W(30);
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.labelAlert];
        [self.contentView addTarget:self action:@selector(cellClick)];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    //设置总高度
    self.height = W(64);
    
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.icon.image = [UIImage imageNamed:model.imageName];
    self.icon.leftCenterY = XY(W(30),self.height/2.0);
    
    [self.labelTitle fitTitle:model.title variable:0];
    self.labelTitle.leftCenterY = XY(self.icon.right + W(10),self.icon.centerY);
    
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(30),self.labelTitle.centerY);
    
    [self.subTitle fitTitle:model.subTitle variable:0];
    self.subTitle.rightCenterY = XY(self.arrow.left - W(3), self.icon.centerY);
    
    self.arrow.hidden = isStr(model.vcName);
    [self.labelAlert fitTitle:UnPackStr(model.vcName) variable:0];
    self.labelAlert.rightCenterY = XY(SCREEN_WIDTH - W(30), self.icon.centerY);
    
    self.line.hidden = model.isLineHide;
    self.line.bottom = self.height;
}

#pragma mark click
- (void)cellClick{
    if (self.model.blockClick) {
        self.model.blockClick();
    }
}
@end
