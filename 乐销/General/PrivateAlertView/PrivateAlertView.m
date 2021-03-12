//
//  PrivateAlertView.m
//  Driver
//
//  Created by 隋林栋 on 2020/11/3.
//Copyright © 2020 ping. All rights reserved.
//

#import "PrivateAlertView.h"
#import <YYKit.h>
#import <NSAttributedString+YYText.h>
#import "WebVC.h"
@interface PrivateAlertView ()

@end

@implementation PrivateAlertView

#pragma mark 懒加载
- (UIView *)viewBg{
    if (_viewBg == nil) {
        _viewBg = [UIView new];
        _viewBg.backgroundColor = COLOR_BLACK_ALPHA_PER60;
    }
    return _viewBg;
}
- (UIView *)viewWhite{
    if (_viewWhite == nil) {
        _viewWhite = [UIView new];
        _viewWhite.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_viewWhite color:[UIColor clearColor] numRound:5 width:0];
    }
    return _viewWhite;
}
- (UILabel *)labelAlert{
    if (_labelAlert == nil) {
        _labelAlert = [UILabel new];
        _labelAlert.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightBold];
        _labelAlert.textAlignment = NSTextAlignmentCenter;
    }
    return _labelAlert;
}
- (UILabel *)labeTitle{
    if (_labeTitle == nil) {
        _labeTitle = [UILabel new];
        [GlobalMethod setLabel:_labeTitle widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_TITLE text:@""];
        _labeTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labeTitle;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.viewBg];
        [self addSubview:self.viewWhite];
        [self.viewWhite addSubview:self.labelAlert];
        [self.viewWhite addSubview:self.labeTitle];
    }
    return self;
}

#pragma mark 刷新view
- (void)show{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.viewBg.frame = CGRectMake(W(0), W(0), SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.viewWhite.frame = CGRectMake(W(33), W(0),W(290), W(300));
    
    [self.labelAlert  fitTitle:@"温馨提示"  variable:0];
    self.labelAlert.centerXTop = XY(self.viewWhite.width/2.0,W(25));
    
    self.viewWhite.height = [self testUrl] +W(91);
    self.viewWhite.center = CGPointMake(self.viewBg.width/2.0, self.viewBg.height/2.0);

    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(self.viewWhite.width/2.0, W(55));
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"退出" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:COLOR_999 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        btn.leftBottom = XY(0, self.viewWhite.height);
        [self.viewWhite addSubview:btn];
    }
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(self.viewWhite.width/2.0, W(55));
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"同意并继续" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
        btn.rightBottom = XY(self.viewWhite.width, self.viewWhite.height);
        [self.viewWhite addSubview:btn];
    }
    
    [self.viewWhite addLineFrame:CGRectMake(0, self.viewWhite.height - W(55)-1, self.viewWhite.width, 1)];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (CGFloat)testUrl{
    // 测试文本
    NSString *text = @"感谢您使用中车运司机APP!,在您使用时，需要连接数据网络或WLAN网络，产生的流量费用请咨询当地运营商。我们非常重视您的隐私保护和个人信息保护，在您使用中车运司机APP服务前，请您仔细阅读、充分理解《中车运用户协议》、《隐私政策》的各项条款。您点击“同意并继续”视为您已同意上述协议的全部内容。";
    // 转成可变属性字符串
    NSMutableAttributedString * mAttributedString = [NSMutableAttributedString new];
    // 调整行间距段落间距
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    WEAKSELF
    //设置文字两端对齐
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [paragraphStyle setLineSpacing:W(8)];
    //    [paragraphStyle setParagraphSpacing:4];
    UIFont *font = [UIFont systemFontOfSize:F(15)];
    // 设置文本属性
    NSDictionary *attri = [NSDictionary dictionaryWithObjects:@[font, COLOR_333, paragraphStyle] forKeys:@[NSFontAttributeName, NSForegroundColorAttributeName, NSParagraphStyleAttributeName]];
    [mAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:attri]];
    {
        NSString *substrinsgForMatch2 = @"《中车运用户协议》";
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
                                  vc.navTitle = @"用户协议";
                                  vc.url = [NSString stringWithFormat:@"%@/site/app/content-detail?number=%@",URL_SHARE,@"agreement_user"];
                                  [GB_Nav pushViewController:vc animated:true];
                [weakSelf removeFromSuperview];
                vc.blockBack = ^(UIViewController *vc) {
                    PrivateAlertView * privateView = [PrivateAlertView new];
                          [privateView show];
                };
            }
        };
        [mAttributedString setTextHighlight:highlight range:[text rangeOfString:substrinsgForMatch2]];
    }
    {
        NSString *substrinsgForMatch2 = @"《隐私政策》";
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
                                   vc.navTitle = @"隐私政策";
                vc.url = [NSString stringWithFormat:@"%@/site/app/content-detail?number=%@",URL_SHARE,@"agreement_privacy"];
                                   [GB_Nav pushViewController:vc animated:true];
                [weakSelf removeFromSuperview];
                vc.blockBack = ^(UIViewController *vc) {
                    PrivateAlertView * privateView = [PrivateAlertView new];
                          [privateView show];
                };
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
    [self.viewWhite addSubview:label];
    
    
    // 利用YYTextLayout计算高度
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(W(230), MAXFLOAT)];
    
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text: mAttributedString];
    
    label.height = textLayout.textBoundingSize.height;
    label.centerXTop = XY(self.viewWhite.width/2.0, W(71));
    
    return label.bottom;
    
    
    
}

- (void)closeClick{
    [self removeFromSuperview];
    ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"仍不同意" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
    modelDismiss.blockClick = ^{
        exit(0);
    };
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"查看协议" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    modelConfirm.blockClick = ^(void){
      PrivateAlertView * privateView = [PrivateAlertView new];
            [privateView show];

    };
    [BaseAlertView initWithTitle:@"提示" content:@"若您不同意本隐私政策，很遗憾我们将无法为您提供服务" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
}
- (void)agreeClick{
    [GlobalMethod writeBool:true local:LOCAL_PRIVATE_ALERT exchangeKey:false];
    
    [self removeFromSuperview];
    if (self.blockDismiss) {
        self.blockDismiss();
    }
}

@end
