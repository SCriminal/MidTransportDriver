//
//  FeedbackVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "FeedbackVC.h"
//text view
#import "PlaceHolderTextView.h"
//request
#import "RequestApi+Dictionary.h"

@interface FeedbackVC ()
@property (nonatomic, strong) UILabel *labelOpinion;
@property (nonatomic, strong) UILabel *labelAdvice;
@property (nonatomic,strong) PlaceHolderTextView *textView;
@property (nonatomic,strong) PlaceHolderTextView *textView2;

@end

@implementation FeedbackVC
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
//        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请输入您的具体描述"];
        [_textView setTextColor:COLOR_333];
        _textView.font = [UIFont systemFontOfSize:F(15)];
    }
    return _textView;
}
- (UILabel *)labelOpinion{
    if (_labelOpinion == nil) {
        _labelOpinion = [UILabel new];
        _labelOpinion.textColor = COLOR_666;
        _labelOpinion.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [_labelOpinion fitTitle:@"您觉得哪个功能体验不好？" variable:0];
        
    }
    return _labelOpinion;
}
- (UILabel *)labelAdvice{
    if (_labelAdvice == nil) {
        _labelAdvice = [UILabel new];
        _labelAdvice.textColor = COLOR_666;
        _labelAdvice.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [_labelAdvice fitTitle:@"您希望改进和增加的功能" variable:0];

    }
    return _labelAdvice;
}

- (PlaceHolderTextView *)textView2{
    if (_textView2 == nil) {
        _textView2 = [PlaceHolderTextView new];
        _textView2.backgroundColor = [UIColor clearColor];
//        _textView2.delegate = self;
        [GlobalMethod setLabel:_textView2.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请输入您的具体描述"];
        [_textView2 setTextColor:COLOR_333];
        _textView2.font = [UIFont systemFontOfSize:F(15)];
    }
    return _textView2;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self configView];
}
- (void)configView{
    [self.view addSubview:self.labelAdvice];
    [self.view addSubview:self.labelOpinion];
    [self.view addSubview:self.textView2];
    self.labelOpinion.leftTop = XY(W(15), W(20)+NAVIGATIONBAR_HEIGHT);
    {
        UIView * viewWhite = [UIView new];
        viewWhite.widthHeight = XY(SCREEN_WIDTH, W(160));
        viewWhite.top = self.labelOpinion.bottom + W(10);
        viewWhite.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:viewWhite];
        
        self.textView.widthHeight = XY(viewWhite.width- W(30), viewWhite.height - W(30));
        self.textView.leftTop = XY(W(15), viewWhite.top + W(15));
        [self.view addSubview:self.textView];
        
        self.labelAdvice.leftTop = XY(W(15), W(20)+viewWhite.bottom);
    }
    {
        UIView * viewWhite = [UIView new];
        viewWhite.widthHeight = XY(SCREEN_WIDTH, W(160));
        viewWhite.top = self.labelAdvice.bottom + W(10);
        viewWhite.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:viewWhite];
        
        self.textView2.widthHeight = XY(viewWhite.width- W(30), viewWhite.height - W(30));
        self.textView2.leftTop = XY(W(15), viewWhite.top + W(15));
        [self.view addSubview:self.textView2];
    }
}
#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"意见反馈" rightTitle:@"提交" rightBlock:^{
        [weakSelf request];
    }];
    nav.line.hidden = true;
    [self.view addSubview:nav];
}


#pragma mark request
- (void)request{
    if (self.textView2.text.length <=0&&self.textView.text.length <=0) {
        [GlobalMethod showAlert:@"请输入内容"];
        return;
    }
    if (self.textView2.text.length <5&&self.textView.text.length <=5) {
        [GlobalMethod showAlert:@"请输入更多内容"];
        return;
    }
    [RequestApi requestAddFeedbackWithBetter:self.textView2.text bad:self.textView.text app:@"1" teminalType:1 userId:[GlobalData sharedInstance].GB_UserModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
