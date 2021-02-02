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
#import "UIButton+Creat.h"
#import "AuthOneVC.h"
@interface DriverDetailTopView ()

@end

@implementation DriverDetailTopView

#pragma mark 懒加载

- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
        _head.widthHeight = XY(W(65),W(65));
        [GlobalMethod setRoundView:_head color:[UIColor clearColor] numRound:_head.width/2.0 width:0];
        _head.userInteractionEnabled = true;
    }
    return _head;
}
- (UIImageView *)authImage{
    if (!_authImage) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"认证"];
        iv.widthHeight = XY(W(18),W(18));
        _authImage = iv;
    }
    return _authImage;
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
               iv.widthHeight = XY(W(12),W(12));
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
- (UILabel *)loginTime{
    if (!_loginTime) {
        _loginTime = [UILabel new];
        _loginTime.textColor = [UIColor whiteColor];
        _loginTime.numberOfLines = 1;
        _loginTime.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    }
    return _loginTime;
}
- (UILabel *)sign{
    if (!_sign) {
        _sign = [UILabel new];
        _sign.textColor = [UIColor whiteColor];
        _sign.numberOfLines = 1;
        _sign.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightMedium];
        [_sign fitTitle:@"签到领积分" variable:0];
    }
    return _sign;
}
- (UILabel *)auth{
    if (!_auth) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = [UIColor whiteColor];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"去认证赚钱" variable:SCREEN_WIDTH - W(30)];
        _auth = l;
    }
    return _auth;
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
    [self addSubview:self.loginTime];
    [self addSubview:self.arrow];
    [self addSubview:self.sign];
    [self addSubview:self.auth];
    [self addSubview:self.authImage];

    self.head.leftBottom = XY(W(20), self.height - W(47));


    self.sign.rightCenterY = XY(SCREEN_WIDTH - W(15), self.head.centerY);
    [self addControlFrame:CGRectInset(self.sign.frame, -W(20), -W(20)) belowView:self.sign target:self action:@selector(signClick)];
    [self addControlFrame:CGRectMake(self.head.right+W(10), self.head.bottom - W(30), W(150), W(50)) belowView:self.sign target:self action:@selector(authClick)];

    self.authImage.leftBottom = XY(self.head.right + W(12),self.head.bottom - W(5));

    //初始化页面
    [self userInfoChange];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelBaseInfo *)model{
    
    //刷新view
    [self.head sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.headUrl)] placeholderImage:self.head.image];
    
    
    NSString * strShow = UnPackStr(model.nickname);

    [self.name fitTitle:strShow variable:W(190)];
    self.name.leftTop = XY(self.head.right + W(10), self.head.top + W(8));

    NSString * strloginTime = [GlobalMethod readStrFromUser:LOCAL_LOGIN_TIME];
    [self.loginTime fitTitle:[NSString stringWithFormat:@"上次登录时间：%@",strloginTime] variable:0];
    self.loginTime.leftBottom = XY(W(20), self.height - W(16));
    
//    [self.auth fitTitle:@"" variable:0];
    self.auth.leftCenterY = XY(self.head.right + W(36), self.authImage.centerY);
    self.arrow.rightCenterY = XY(self.auth.right + W(16), self.auth.centerY);
}
-(void)resetAuth:(BOOL)authed{
    [self.auth fitTitle:authed?@"查看认证信息":@"去认证赚钱" variable:0];
        self.auth.leftCenterY = XY(self.head.right + W(36), self.authImage.centerY);
        self.arrow.rightCenterY = XY(self.auth.right + W(16), self.auth.centerY);

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
- (void)signClick{
    if (self.blockSignClick) {
        self.blockSignClick();
    }
}
- (void)authClick{
    if (self.blockAuthClick) {
        self.blockAuthClick();
    }
}
#pragma mark dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end


@implementation DriverDetailModelView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
    }
    return self;
}

#pragma mark 刷新view
- (void)resetWithAry:(NSArray *)aryModels{
    [self removeAllSubViews];//移除线
    //刷新view
    CGFloat top = 0;
    for (ModelBaseData *m in aryModels) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:m.string variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(20) + top);
        [self addSubview:l];
        CGFloat left= W(27);
        CGFloat btnTop = top + W(52);
        for (int i = 0; i<m.aryDatas.count; i++) {
            ModelBtn * mBtn = m.aryDatas[i];
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:mBtn.imageName];
            iv.widthHeight = XY(W(45),W(45));
            iv.leftTop = XY(left,btnTop);
            [self addSubview:iv];

            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = [UIColor colorWithHexString:@"#717273"];
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:mBtn.title variable:SCREEN_WIDTH - W(30)];
            l.centerXTop = XY(iv.centerX, iv.bottom + W(6));
            [self addSubview:l];

            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(iv.left - W(20), iv.top - W(5), iv.width + W(40), l.bottom + W(10) - iv.top);
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.modelBtn = mBtn;
            left = iv.right + W(47);
            [self addSubview:btn];

            if ((i+1)%4==0) {
                left = W(27);
                btnTop = iv.bottom + W(35);
            }
            top = iv.bottom + W(38);

        }
        [self addSubview:^(){
            UIView * v = [UIView new];
            v.frame = CGRectMake(0, top, SCREEN_WIDTH, W(12));
            v.backgroundColor = COLOR_BACKGROUND;
            return v;
        }()];
        top = top +W(12);
        
    }
    //设置总高度
    self.height = top;
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (sender.modelBtn.blockClick) {
        sender.modelBtn.blockClick();
    }
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
