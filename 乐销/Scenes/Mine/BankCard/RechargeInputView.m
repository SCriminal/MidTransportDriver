//
//  RechargeInputView.m
//  Driver
//
//  Created by 隋林栋 on 2020/12/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "RechargeInputView.h"
#import "UITextField+Text.h"
#import <YYKit.h>
#import <NSAttributedString+YYText.h>
#import "WebVC.h"
@interface RechargeInputView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tfPrice;
@property (nonatomic, strong) UIView *viewWhitBG;
@property (nonatomic, strong) UIView *endControl;
@property (nonatomic, strong) UIImageView *iconSelect;
@property (nonatomic, assign) int indexSelected;
@end

@implementation RechargeInputView

- (UITextField *)tfPrice{
    if (_tfPrice == nil) {
        _tfPrice = [UITextField new];
        _tfPrice.font = [UIFont systemFontOfSize:F(35) weight:UIFontWeightMedium];
        _tfPrice.textAlignment = NSTextAlignmentLeft;
        _tfPrice.textColor = COLOR_333;
        _tfPrice.borderStyle = UITextBorderStyleNone;
        _tfPrice.backgroundColor = [UIColor clearColor];
        _tfPrice.delegate = self;
        _tfPrice.contentType = ENUM_TEXT_CONTENT_TYPE_PRICE;
//        _tfPrice.placeholder = @"";
    }
    return _tfPrice;
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
          viewWhiteBG.widthHeight = XY(SCREEN_WIDTH, W(364)+iphoneXBottomInterval);
          viewWhiteBG.bottom = SCREEN_HEIGHT;
          [viewWhiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:8 lineWidth:0 lineColor:[UIColor clearColor]];
          [self addSubview:viewWhiteBG];
    {
        
        self.endControl =  [self addControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - viewWhiteBG.height) belowView:viewWhiteBG target:self action:@selector(endClick)];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"充值" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(20), W(20));
        [viewWhiteBG addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(35) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"¥" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(20), W(67));
        [viewWhiteBG addSubview:l];
        [viewWhiteBG addSubview:self.tfPrice];
        self.tfPrice.widthHeight = XY(W(200), [UIFont fetchHeight:F(35)]);
        self.tfPrice.leftCenterY = XY(l.right + W(11), l.centerY);
        
        [viewWhiteBG addControlFrame:CGRectMake(0, W(60), W(220), W(60)) belowView:self.tfPrice target:self action:@selector(priceClick)];
    }
    {
        [viewWhiteBG addLineFrame:CGRectMake(W(20), W(114), SCREEN_WIDTH - W(40), 1)];
    }
    NSArray * aryBtn = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"¥1000";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"¥3000";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"¥5000";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"¥10000";
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.title = @"¥50000";
        return m;
    }()];
    {
        CGFloat btnLeft = W(20);
        CGFloat btnTop = W(146);
        for (int i = 0; i<aryBtn.count; i++) {
            ModelBtn * m = aryBtn[i];
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY(W(99), W(34));
            btn.leftTop = XY(btnLeft, btnTop);
            [btn setTitle:m.title forState:UIControlStateNormal];
            btn.titleLabel.fontNum = F(14);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.tag = i+ 100;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [viewWhiteBG addSubview:btn];
            btnLeft = btn.right + W(19);
            if ((i+1)%3==0) {
                btnTop = W(199);
                btnLeft = W(20);

            }
        }
            for (int i = 0; i<5; i++) {
               UIButton * btn = [self.viewWhitBG viewWithTag:i+100];
                if ([btn isKindOfClass:[UIButton class]]) {
//                    if (btn.tag == sender.tag) {
//                        btn.backgroundColor = COLOR_BLUE;
//                        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:6 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
//                        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                    }else
                    {
                        btn.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
                        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:6 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
                        [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
                    }
                }
            }
    }
   
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"auth_unselected"];
        iv.highlightedImage = [UIImage imageNamed:@"auth_selected"];
        iv.highlighted = true;
        iv.widthHeight = XY(W(12),W(12));
        iv.leftTop = XY(W(20),W(263));
        self.iconSelect = iv;
        [viewWhiteBG addSubview:iv];
        [viewWhiteBG addControlFrame:CGRectInset(iv.frame, -W(20), -W(20)) belowView:iv target:self action:@selector(ivClick)];
    }
    {
        // 测试文本
           NSString *text = @"同意《中车运平台充值条款》";
           // 转成可变属性字符串
           NSMutableAttributedString * mAttributedString = [NSMutableAttributedString new];
           // 调整行间距段落间距
           NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
           //设置文字两端对齐
           paragraphStyle.alignment = NSTextAlignmentLeft;
//           [paragraphStyle setLineSpacing:W(8)];
           UIFont *font = [UIFont systemFontOfSize:F(12)];
           // 设置文本属性
           NSDictionary *attri = [NSDictionary dictionaryWithObjects:@[font, COLOR_666, paragraphStyle] forKeys:@[NSFontAttributeName, NSForegroundColorAttributeName, NSParagraphStyleAttributeName]];
           [mAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:attri]];
           {
               NSString *substrinsgForMatch2 = @"《中车运平台充值条款》";
               NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:substrinsgForMatch2];
               // 利用YYText设置一些文本属性
               one.font = font;
               one.color = COLOR_BLUE;
               [mAttributedString replaceCharactersInRange:[text rangeOfString:substrinsgForMatch2] withAttributedString:one];
               YYTextHighlight *highlight = [YYTextHighlight new];
               
               [highlight setColor:[UIColor whiteColor]];
               
               highlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                   NSAttributedString * attStrClick = [text attributedSubstringFromRange:range];
                   YYTextHighlight * heightDic = [attStrClick.attributes objectForKey:YYTextHighlightAttributeName];
                   if (heightDic) {
                       WebVC * vc = [WebVC new];
                                         vc.navTitle = @"中车运平台充值条款";
                       vc.url = [NSString stringWithFormat:@"%@/site/app/content-detail?number=%@",URL_SHARE,@"agreement_recharge"];
                                         [GB_Nav pushViewController:vc animated:true];
                   }
               };
               [mAttributedString setTextHighlight:highlight range:[text rangeOfString:substrinsgForMatch2]];
           }
           mAttributedString.lineSpacing = W(8);
           mAttributedString.lineBreakMode = NSLineBreakByCharWrapping;
           // 使用YYLabel显示
           YYLabel *label = [YYLabel new];
           label.userInteractionEnabled = YES;
           label.backgroundColor = [UIColor clearColor];
           label.numberOfLines = 0;
           //具体高度有内容决定，不会按照这里设定的
           label.frame = CGRectMake(0, 100, W(230), 100);
           label.attributedText = mAttributedString;
           [viewWhiteBG addSubview:label];
           // 利用YYTextLayout计算高度
           YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(W(230), MAXFLOAT)];
           YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text: mAttributedString];
           label.height = textLayout.textBoundingSize.height;
           label.leftCenterY = XY(W(44),W(269));
    }
    
   
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(335), W(39));
        btn.backgroundColor = COLOR_BLUE;
        [btn setTitle:@"确认充值" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.rightTop = XY(SCREEN_WIDTH - W(20), W(295));
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:COLOR_BORDER];
        [viewWhiteBG addSubview:btn];
    }
    

    
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;
//        [self addTarget:self action:@selector(endClick)];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification  object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification  object:nil];

    }
    return self;
}
- (void)keyboardShow:(NSNotification *)notice{
    CGRect frame = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self btnClick:^(){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000;
        return btn;
    }()];
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = frame.origin.y;
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewWhitBG.bottom = SCREEN_HEIGHT;
    }];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)priceClick{
    [self.tfPrice becomeFirstResponder];
}
- (void)endClick{
    [self btnDismissClick];
}
- (void)btnDismissClick{
    if ([self.tfPrice isFirstResponder]) {
        [GlobalMethod endEditing];
    }else{
        [self removeFromSuperview];
    }
    
}
- (void)btnConfirmClick{
    [GlobalMethod endEditing];
    if (!self.iconSelect.highlighted) {
        [GlobalMethod showAlert:@"请先阅读并同意条款"];
        return;
    }
    if (self.blockConfirm) {
        self.blockConfirm(self.tfPrice.text.doubleValue, 0);
    }
    [self removeFromSuperview];
}
- (void)ivClick{
    self.iconSelect.highlighted =  !self.iconSelect.highlighted;
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (isStr(sender.titleLabel.text)) {
        self.tfPrice.text = [sender.titleLabel.text substringFromIndex:1];
    }
//    for (int i = 0; i<5; i++) {
//       UIButton * btn = [self.viewWhitBG viewWithTag:i+100];
//        if ([btn isKindOfClass:[UIButton class]]) {
//            if (btn.tag == sender.tag) {
//                btn.backgroundColor = COLOR_BLUE;
//                [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:6 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
//                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            }else{
//                btn.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
//                [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:6 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
//                [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
//
//            }
//        }
//    }
//    self.indexSelected = sender.tag - 100;
}
@end
