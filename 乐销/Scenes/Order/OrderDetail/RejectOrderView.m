//
//  RejectOrderView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/9.
//Copyright © 2020 ping. All rights reserved.
//

#import "RejectOrderView.h"
#import "UITextField+Text.h"
#import "PlaceHolderTextView.h"

@interface RejectOrderView ()
@property (nonatomic, strong) PlaceHolderTextView *tfReason;
@property (nonatomic, strong) UIView *viewWhitBG;

@end

@implementation RejectOrderView
- (PlaceHolderTextView *)tfReason{
    if (_tfReason == nil) {
        _tfReason = [PlaceHolderTextView new];
        _tfReason.font = [UIFont systemFontOfSize:F(14)];
        _tfReason.textAlignment = NSTextAlignmentLeft;
        _tfReason.textColor = COLOR_333;

        _tfReason.backgroundColor = [UIColor clearColor];
//        _tfReason.delegate = self;
        _tfReason.placeHolder.fontNum = F(14);
        _tfReason.placeHolder.textColor = COLOR_999;
        [_tfReason.placeHolder fitTitle:@"请填写您的拒绝原因（也可选择下面填入)" variable:W(304)];
    }
    return _tfReason;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    {
        UIView * _viewBlackAlpha = [UIView new];
         _viewBlackAlpha.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
         _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_viewBlackAlpha];
    }
   
      UIView * viewWhiteBG = [UIView new];
    self.viewWhitBG = viewWhiteBG;
          viewWhiteBG.backgroundColor = [UIColor whiteColor];
          viewWhiteBG.widthHeight = XY(SCREEN_WIDTH, W(438)+iphoneXBottomInterval);
          viewWhiteBG.bottom = SCREEN_HEIGHT;
          [viewWhiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:8 lineWidth:0 lineColor:[UIColor clearColor]];
          [self addSubview:viewWhiteBG];
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"拒单" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(20));
        [viewWhiteBG addSubview:l];
    }
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"拒单原因" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(20), W(72));
        [viewWhiteBG addSubview:l];
    }
    
    {
              UIView * viewBorder = [viewWhiteBG generateBorder:CGRectMake(W(20), W(102), W(335), W(120))];
              [viewBorder addTarget:self action:@selector(textViewClick)];
              self.tfReason.widthHeight = XY(viewBorder.width - W(24),viewBorder.height -W(20));
              self.tfReason.leftTop = XY(viewBorder.left + W(12),viewBorder.top + W((12)));
              [self.tfReason removeFromSuperview];
              [viewWhiteBG addSubview:self.tfReason];
          }
    NSArray * aryBtn = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"车辆抛锚了";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"身体不舒服";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"临时调配";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"交通违法";
        return m;
    }()];
    [self addLabelAry:aryBtn superView:viewWhiteBG];
   
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(157), W(39));
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        btn.leftTop = XY(W(20), W(374));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(157), W(39));
        btn.backgroundColor = COLOR_BLUE;
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.rightTop = XY(SCREEN_WIDTH - W(20), W(374));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    
    [viewWhiteBG addLineFrame:CGRectMake(W(20), W(347), SCREEN_WIDTH - W(40), 1)];
    
  
    
}
- (void)addLabelAry:(NSArray *)ary superView:(UIView *)superView{
    CGFloat left = W(20);
    CGFloat top = W(242);
    for (int i = 0; i<ary.count; i++) {
        ModelBtn * m = ary[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(104), W(34));
        btn.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        [btn setTitle:m.title forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(14);
        [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        

        [superView addSubview:btn];
        btn.leftTop = XY(left, top);
        left = btn.right + W(12);
        if ((i+1)%3 == 0) {
            left= W(20);
            top = btn.bottom + W(12);
        }
    }
 
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;
        [self addTarget:self action:@selector(endClick)];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification  object:nil];

    }
    return self;
}
- (void)keyboardShow:(NSNotification *)notice{
    CGRect frame = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    键盘的实时Y
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = frame.origin.y;
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = SCREEN_HEIGHT;
    }];
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    NSString * append= self.tfReason.text.length>0?[NSString stringWithFormat:@"\n%@",sender.titleLabel.text]:sender.titleLabel.text;
    self.tfReason.text = [self.tfReason.text stringByAppendingString:append];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)textViewClick{
    [self.tfReason becomeFirstResponder];
}


- (void)endClick{
    [GlobalMethod endEditing];
}
- (void)btnDismissClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)btnConfirmClick{
    if (self.blockConfirm) {
        self.blockConfirm(self.tfReason.text);
    }
    [self btnDismissClick];
}
@end
