//
//  BulkCargoOperateLoadView.m
//  Driver
//
//  Created by 隋林栋 on 2019/7/19.
//Copyright © 2019 ping. All rights reserved.
//

#import "BulkCargoOperateLoadView.h"


@interface BulkCargoOperateLoadView ()

@end

@implementation BulkCargoOperateLoadView

#pragma mark 懒加载
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
//        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_999 text:@"其他装车信息 (非必填)"];
        _textView.placeHolder.leftTop = XY(0, W(4));
        [_textView setTextColor:COLOR_333];
        _textView.font = [UIFont systemFontOfSize:F(14)];
        _textView.widthHeight = XY(W(275-24), W(80-24));
    }
    return _textView;
}
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:10 width:0];
    }
    return _viewBG;
}
- (UILabel *)labelInput{
    if (_labelInput == nil) {
        _labelInput = [UILabel new];
        _labelInput.textColor = COLOR_333;
        _labelInput.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        [_labelInput fitTitle:@"上传装车凭证" variable:0];
        
    }
    return _labelInput;
}
- (UIImageView *)ivClose{
    if (_ivClose == nil) {
        _ivClose = [UIImageView new];
        _ivClose.image = [UIImage imageNamed:@"inputClose"];
        _ivClose.widthHeight = XY(W(25),W(25));
    }
    return _ivClose;
}
-(UIButton *)btnSubmit{
    if (_btnSubmit == nil) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.backgroundColor = [UIColor clearColor];
        _btnSubmit.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSubmit setTitle:@"提交" forState:(UIControlStateNormal)];
        [_btnSubmit setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(btnSubmitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.font = [UIFont systemFontOfSize:F(15)];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.backgroundColor = [UIColor clearColor];
        [_labelTitle fitTitle:@"请上传装车凭证 (如过磅单、装货单等)" variable:0];
    }
    return _labelTitle;
}

- (Collection_Image *)collection_Image{
    if (!_collection_Image) {
        _collection_Image = [Collection_Image new];
        _collection_Image.isEditing = true;
        _collection_Image.width =  W(315)- W(40);
        [_collection_Image resetWithAry:nil];

    }
    return _collection_Image;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addTarget:self action:@selector(hideKeyboardClick)];
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.labelInput];
    [self.viewBG addSubview:self.ivClose];
    [self.viewBG addSubview:self.collection_Image];
    [self.viewBG addSubview:self.btnSubmit];
    [self.viewBG addSubview:self.labelTitle];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.width = W(315);
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(200)) );
    
    self.labelInput.centerXTop = XY(self.viewBG.width/2.0,W(25));
    
    self.ivClose.rightTop = XY(self.viewBG.width - W(16),W(21));
    [self.viewBG addControlFrame:CGRectInset(self.ivClose.frame, -W(20), -W(20)) belowView:self.ivClose target:self action:@selector(closeClick)];
    
    
    self.labelTitle.leftCenterY = XY(W(20),W(77));
    
    self.collection_Image.leftTop = XY(W(20), self.labelTitle.bottom + W(15));
    
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(275), W(80));
        view.leftTop = XY(W(20), self.collection_Image.bottom + W(15));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:4 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D7DBDA"]];
        [self.viewBG addSubview:view];
        
        [self.viewBG addSubview:self.textView];
        self.textView.center = view.center;
    }
    
    [self.viewBG addLineFrame:CGRectMake(0, self.collection_Image.bottom + W(120), self.viewBG.width, 1)];
    
    self.btnSubmit.widthHeight = XY(self.viewBG.width,W(55));
    self.btnSubmit.centerXTop = XY(self.viewBG.width/2.0,self.collection_Image.bottom + W(120));
    self.viewBG.height = self.btnSubmit.bottom;
    
}
- (void)show{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_ORDER;
    //show
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}

#pragma mark click
- (void)closeClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)btnSubmitClick{
    if (self.blockComplete) {
        self.blockComplete(self.collection_Image.aryDatas,self.textView.text);
    }
    [self removeFromSuperview];
}
- (void)hideKeyboardClick{
    [GlobalMethod endEditing];
}
@end
