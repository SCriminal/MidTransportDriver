//
//  SuggestVC.m
//  Driver
//
//  Created by 隋林栋 on 2021/1/5.
//Copyright © 2021 ping. All rights reserved.
//

#import "SuggestVC.h"
//滑动view
#import "SliderView.h"
//text view
#import "PlaceHolderTextView.h"
//request
//request
#import "RequestDriver2.h"

//图片选择collection
#import "Collection_Image.h"

@interface SuggestVC ()
@property (nonatomic,strong) PlaceHolderTextView *textView;
@property (nonatomic, assign) int  indexSelected;
@end

@implementation SuggestVC


- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
//        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_999 text:@"请详细描写您的建议内容"];
        _textView.placeHolder.leftTop = XY(0, W(4));
        [_textView setTextColor:COLOR_333];
        _textView.font = [UIFont systemFontOfSize:F(14)];
        _textView.widthHeight = XY(W(321), W(100));
        
    }
    return _textView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self configView];
}
- (void)configView{
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(SCREEN_WIDTH, W(288));
        view.leftTop = XY(W(0), W(10));
        [self.view addSubview:view];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"建议类型" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(27));
        [self.view addSubview:l];
    }
    {
        NSArray * aryTitle = @[@"功能优化",@"页面优化",@"用户体验",@"其他"];
        NSArray * aryWidth = @[@82,@82,@82,@53];
        CGFloat left = W(15);
        for (int i = 0; i<aryTitle.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.widthHeight = XY([aryWidth[i] doubleValue], W(34));
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:aryTitle[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
            [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100 +i;
            [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
            [self.view addSubview:btn];
            btn.leftTop = XY(left, W(59));
            left = btn.right + W(12);
        }
        [self btnClick:[self.view viewWithTag:100]];
    }
    [self.view addLineFrame:CGRectMake(W(15), W(110), SCREEN_WIDTH - W(30), 1)];

    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"建议内容" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), W(129));
        [self.view addSubview:l];
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(345), W(120));
        view.centerXTop = XY(SCREEN_WIDTH/2.0, W(161));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        [self.view addSubview:view];
    }
    [self.view addSubview:self.textView];
    self.textView.centerXTop = XY(SCREEN_WIDTH/2.0, W(176));
   
    {
        UIButton * btn = [UIButton createBottomBtn:@"保存"];
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(313));
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(saveClick)];
    }
}



#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    self.indexSelected = sender.tag - 100;
    for (int i = 0; i<4; i++) {
        UIButton * btn = [self.view viewWithTag:i+100];
        if (sender.tag == i+100) {
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.backgroundColor = COLOR_BLUE;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
            }
        }else{
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
                [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
                [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
            }
        }
    }
}
- (void)saveClick{
    [self request];
}
#pragma mark request
- (void)request{
   
    if (self.textView.text.length <5) {
        [GlobalMethod showAlert:@"请输入更多内容"];
        return;
    }
   
    [RequestApi requestProblemWithProblemtype:self.indexSelected +1 type:2 description:self.textView.text submitUrl1:nil submitUrl2:nil submitUrl3:nil waybillNumber:nil delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        [GB_Nav popViewControllerAnimated:true];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];

}


@end
