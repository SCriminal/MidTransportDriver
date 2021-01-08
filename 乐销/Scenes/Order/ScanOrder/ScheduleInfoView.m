//
//  ScheduleInfoView.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "ScheduleInfoView.h"
//detail
#import "ImageDetailBigView.h"
#import "BulkCargoListCell.h"


@interface ScheduleInfoTopView ()

@end

@implementation ScheduleInfoTopView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil ];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)modelCargo  {
    [self removeAllSubViews];//移除线
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"arrow_address"];
        iv.widthHeight = XY(W(25),W(25));
        iv.centerXTop = XY(SCREEN_WIDTH/2.0,W(20));
        [self addSubview:iv];
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"潍坊市 寿光市" variable:W(170)];
        l.centerXCenterY = XY(W(95), iv.centerY);
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"潍坊市 寿光市" variable:W(170)];
        l.centerXCenterY = XY(SCREEN_WIDTH - W(95), iv.centerY);
        [self addSubview:l];
    }
    NSArray * ary = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"配货编号：";
        m.subTitle = @"QD338888882222239";
        m.left = W(90);
        m.isSelected = true;
        m.color = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货量：";
        m.subTitle = @"2000吨";
        m.left = W(90);
        m.isSelected = false;
        m.color = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"运输费用：";
        m.subTitle = @"3500元";
        m.left = W(90);
        m.isSelected = false;
        m.color = COLOR_RED;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"货物名称：";
        m.subTitle = @"设备零配件";
        m.left = W(90);
        m.isSelected = false;
        m.color = nil;
        return m;
    }()];
    self.height = [ScheduleInfoTopView addLabel:ary top:W(62) superView:self];

}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (sender.modelBtn.blockClick) {
        sender.modelBtn.blockClick();
    }
}
+ (CGFloat)addLabel:(NSArray *)ary top:(CGFloat)top superView:(UIView *)s{
    for (ModelBtn * m in ary) {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(15), top);
            [s addSubview:l];
        }
        if (m.isSelected) {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"复制" variable:SCREEN_WIDTH - W(30)];
            l.rightTop = XY(SCREEN_WIDTH - W(15), top);
            [s addSubview:l];
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectInset(l.frame, -W(30), -W(20));
            btn.backgroundColor = [UIColor clearColor];
            [s addSubview:btn];
            btn.modelBtn = m;
            [btn addTarget:s action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = m.color?m.color:COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(5);
            [l fitTitle:m.subTitle variable:SCREEN_WIDTH - m.left - W(15)];
            l.leftTop = XY(m.left, top);
            [s addSubview:l];
            top = l.bottom+W(15);
        }
       
    }
    return top;
}
@end






@implementation ScheduleInfoPathView
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model{
    [self removeAllSubViews];//移除线
    CGFloat top = 0;
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"路线信息" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(15));
        [self addSubview:l];
        
       top = [self addLineFrame:CGRectMake(W(15), l.bottom+ W(15), SCREEN_WIDTH - W(30), 1)] +W(15);
    }
    NSArray * ary = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"发货地：";
        m.subTitle = @"山东省潍坊市寿光市和平路200号";
        m.left = W(77);
        m.color = nil;
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"收货地：";
        m.subTitle = @"山东省潍坊市寿光市和平路200号";
        m.left = W(77);
        m.color = nil;
        return m;
    }()];
    self.height = [ScheduleInfoTopView addLabel:ary top:top superView:self];
}

@end



@implementation ScheduleBottomView
#pragma mark 懒加载

-(UIButton *)btnConfirm{
    if (_btnConfirm == nil) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnConfirm addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = COLOR_BLUE;
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [GlobalMethod setRoundView:_btnConfirm color:[UIColor clearColor] numRound:5 width:0];
        [_btnConfirm setTitle:@"同意" forState:(UIControlStateNormal)];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.widthHeight = XY(W(172),W(40));
    }
    return _btnConfirm;
}
-(UIButton *)btnDismiss{
    if (_btnDismiss == nil) {
        _btnDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDismiss addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        _btnDismiss.backgroundColor = [UIColor whiteColor];
        _btnDismiss.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [GlobalMethod setRoundView:_btnDismiss color:[UIColor colorWithHexString:@"#D7DBDA"] numRound:5 width:1];
        [_btnDismiss setTitle:@"关闭" forState:(UIControlStateNormal)];
        [_btnDismiss setTitleColor:COLOR_666 forState:UIControlStateNormal];
        _btnDismiss.widthHeight = XY(W(172),W(40));
    }
    return _btnDismiss;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = false;
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.btnConfirm];
    [self addSubview:self.btnDismiss];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.btnConfirm.rightTop = XY(SCREEN_WIDTH - W(10), W(10));
    self.btnDismiss.leftTop = XY( W(10), W(10));

    self.height = self.btnConfirm.bottom + W(10) + iphoneXBottomInterval;
}

#pragma mark click
- (void)btnClick{
    if (self.blockClick) {
        self.blockClick();
    }
}
- (void)btnDismissClick{
    if (self.blockDismiss) {
        self.blockDismiss();
    }
}
@end



@implementation ScheConfirmView

- (UITextField *)tfPhone{
    if (_tfPhone == nil) {
        _tfPhone = [UITextField new];
        _tfPhone.font = [UIFont systemFontOfSize:F(15)];
        _tfPhone.textAlignment = NSTextAlignmentLeft;
        _tfPhone.textColor = COLOR_333;
        _tfPhone.borderStyle = UITextBorderStyleNone;
        _tfPhone.backgroundColor = [UIColor clearColor];
        _tfPhone.delegate = self;
        _tfPhone.placeholder = @"输入手机号";
        _tfPhone.text = [GlobalData sharedInstance].GB_UserModel.cellPhone;
    }
    return _tfPhone;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        self.clipsToBounds = false;
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;

        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelScheduleInfo *)model{
    [self removeAllSubViews];//移除线

    UIView * viewBG = [UIView new];
    viewBG.backgroundColor = [UIColor whiteColor];
    viewBG.widthHeight = XY(W(315), W(287));
    viewBG.centerXCenterY = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    [viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
    [self addSubview:viewBG];
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"提示" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(viewBG.width/2.0, W(22));
        [viewBG addSubview:l];
    }
    NSArray *ary = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"车牌号码";
        m.subTitle = @"鲁V38390";
        m.isSelected = false;
        m.top = W(78);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"司机姓名";
        m.subTitle = UnPackStr([GlobalData sharedInstance].GB_UserModel.realName);
        m.isSelected = false;
        m.top = W(129);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"联系方式";
        m.subTitle = @"";
        m.isSelected = true;
        m.top = W(180);
        return m;
    }()];
    for (ModelBtn *m in ary) {
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(25), m.top);
            [viewBG addSubview:l];
            
            UIView * view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view.widthHeight = XY(W(192), W(36));
            view.leftCenterY = XY(W(98),l.centerY );
            [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
            [viewBG addSubview:view];
        }
        if (!m.isSelected) {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:m.subTitle variable:W(172)];
            l.leftTop = XY(W(108), m.top);
            [viewBG addSubview:l];
        }else{
            self.tfPhone.leftTop = XY(W(108), m.top);
            self.tfPhone.widthHeight =XY(W(172), [UIFont fetchHeight:F(15)]);
            [viewBG addSubview:self.tfPhone];
        }
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"取消" variable:SCREEN_WIDTH - W(30)];
        l.centerXBottom = XY(viewBG.width/4.0, viewBG.height - W(20));
        [viewBG addSubview:l];
        
        [viewBG addControlFrame:CGRectInset(l.frame, -W(120), -W(40)) belowView:l target:self action:@selector(btnDismissClick)];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_BLUE;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"确认运输" variable:SCREEN_WIDTH - W(30)];
        l.centerXBottom = XY(viewBG.width/4.0*3.0, viewBG.height - W(20));
        [viewBG addSubview:l];
        
        [viewBG addControlFrame:CGRectInset(l.frame, -W(120), -W(40)) belowView:l target:self action:@selector(btnClick)];
    }
}

#pragma mark click
- (void)btnClick{
    if (self.blockClick) {
        self.blockClick();
    }
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)btnDismissClick{
    [GlobalMethod endEditing];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show{
    [GlobalMethod endEditing];
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}
@end
